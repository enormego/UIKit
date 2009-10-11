//
//  UITableView.m
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <UIKit/UITableView.h>
#import "UIColor.h"
#import "UITableViewCell-Private.h"

static inline CGRect CGRectFromOffsetHeight(float offset, float height) {
	return CGRectMake(0.0f, offset, 100.0f, height);
}

@interface UITableView (Private)
- (void)queueReusableCell:(UITableViewCell*)aTableViewCell;
- (void)layoutVisibleCells;
- (void)removeInvisibleCells;
- (void)clearAllCells;
@end


@implementation UITableView
@synthesize style=_style, dataSource=_dataSource, delegate=_delegate;
@synthesize rowHeight=_rowHeight, sectionHeaderHeight=_sectionHeaderHeight, sectionFooterHeight=_sectionFooterHeight;
@synthesize editing=_isEditing, allowsSelection=_allowsSelection, allowsSelectionDuringEditing=_allowsSelectionDuringEditing;
@synthesize separatorStyle=_separatorStyle, separatorColor=_separatorColor;
@synthesize tableHeaderView=_tableHeaderView, tableFooterView=_tableFooterView;

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		_rowHeight = 44.0f;
		_sectionHeaderHeight = 22.0f;
		_sectionFooterHeight = 22.0f;
		_allowsSelection = YES;
		_allowsSelectionDuringEditing = NO;
		_separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		_separatorColor = [[UIColor grayColor] retain];
		_reusableTableCells = [[NSMutableDictionary alloc] init];
		_visibleCells = [[NSMutableArray alloc] init];
		_sectionData = [[NSMutableArray alloc] init];

		self.hasVerticalScroller = YES;
		self.hasHorizontalScroller = NO;
		self.autohidesScrollers = NO;
		
		((UIView*)self.documentView).autoresizingMask = UIViewAutoresizingFlexibleWidth;
	}
	
	return self;
}

#pragma mark Todo

- (void)reloadData {
	float height = 0.0f;
	NSInteger sections = 1;
	BOOL variableRowHeights = [self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)];
	
	if([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
		sections = [self.dataSource numberOfSectionsInTableView:self];
	}
	
	[_sectionData removeAllObjects];
	
	for(int section = 0; section < sections; section++) {
		float offsetY = self.rowHeight;
		NSInteger rows = [self.dataSource tableView:self numberOfRowsInSection:section];
		NSMutableArray* rowInfo = [[NSMutableArray alloc] initWithCapacity:rows];

		for(int row = 0; row < rows; row++) {
			float rowHeight = self.rowHeight;
			
			if(variableRowHeights) {
				rowHeight = [self.delegate tableView:self heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
			}
			
			NSRect rowRect = NSMakeRect(0.0f, height, self.contentView.frame.size.width, rowHeight);
			[rowInfo addObject:[NSValue valueWithRect:rowRect]];
			
			height += rowHeight;
		}
		
		NSMutableDictionary* sectionInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
		[sectionInfo setObject:rowInfo forKey:@"rows"];
		[rowInfo release];
		
		NSRect sectionRect = NSMakeRect(0.0f, offsetY, self.contentView.frame.size.width, height-offsetY);
		[sectionInfo setObject:[NSValue valueWithRect:sectionRect] forKey:@"rect"];
		[_sectionData addObject:sectionInfo];
		[sectionInfo release];
	}
	

	[self removeInvisibleCells];
	[self layoutVisibleCells];
	
	self.documentSize = NSMakeSize([self contentSize].width, height);
}

- (NSInteger)numberOfSections {
	if([_dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
		return [_dataSource numberOfSectionsInTableView:self];
	} else {
		return 1;
	}
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section {
	return [_dataSource tableView:self numberOfRowsInSection:section];
}

- (UITableViewCell*)cellForRowAtIndexPath:(NSIndexPath*)indexPath {
	return [_dataSource tableView:self cellForRowAtIndexPath:indexPath];
}

- (NSArray*)visibleCells {
	return _visibleCells;
}

- (NSArray*)indexPathsForVisibleRows {
	// ToDo: indexPathsForVisibleRows
	return nil;
}

- (void)layoutVisibleCells {
	CGRect clipViewBounds = NSRectToCGRect(self.contentView.bounds);
	NSArray* subviews = [[[self.documentView subviews] copy] autorelease];
	
	NSInteger section = 0;
	for(NSDictionary* sectionInfo in _sectionData) {
		CGRect sectionRect = NSRectToCGRect([[sectionInfo objectForKey:@"rect"] rectValue]);
		sectionRect.origin.x = 0.0f;
		sectionRect.size.width = self.contentView.frame.size.width;
		
		if(!CGRectIntersectsRect(clipViewBounds, sectionRect)) {
			section++;
			continue;
		}
		
		NSInteger row = 0;
		for(NSValue* rowRectValue in [sectionInfo objectForKey:@"rows"]) {
			CGRect rowRect = NSRectToCGRect([rowRectValue rectValue]);
			rowRect.origin.x = 0.0f;
			rowRect.size.width = self.contentView.frame.size.width;

			if(!CGRectIntersectsRect(clipViewBounds, rowRect)) {
				row++;
				continue;
			}
			
			BOOL skip = NO;
			for(UIView* view in subviews) {
				if(![view isKindOfClass:[UITableViewCell class]]) continue;
				if(CGRectIntersectsRect(rowRect, NSRectToCGRect(view.frame))) {
					skip = YES;
					break;
				}
			}
			
			if(skip) {
				row++;
				continue;
			}
			
			NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:section];
			
			UITableViewCell* aCell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
			// if(!aCell.separatorColor) aCell.separatorColor = _separatorColor;
			
			aCell.frame = rowRect;
			[aCell setNeedsLayout];
			[aCell setNeedsDisplay];
			[self.documentView addSubview:aCell];
			[aCell layoutIfNeeded];
			[_visibleCells addObject:aCell];

			row++;
		}
		
		section++;
	}
}

- (void)clearAllCells {
	[_visibleCells removeAllObjects];
	
	for(UITableViewCell* cell in [self.documentView subviews]) {
		if(![cell isKindOfClass:[UITableViewCell class]]) continue;
		[self queueReusableCell:cell];
		[cell removeFromSuperview];
	}
}

- (void)removeInvisibleCells {
	NSMutableSet* cellsToRemove = [NSMutableSet set];
	CGRect clipViewBounds = NSRectToCGRect(self.contentView.bounds);
	
	for(UITableViewCell* cell in [self.documentView subviews]) {
		if(![cell isKindOfClass:[UITableViewCell class]]) continue;
		if(CGRectIntersectsRect(clipViewBounds, NSRectToCGRect(cell.frame))) continue;
		[cellsToRemove addObject:cell];
	}
	
	[cellsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
	[_visibleCells removeObjectsInArray:[cellsToRemove allObjects]];
	
	for(UITableViewCell* cell in cellsToRemove) {
		[self queueReusableCell:cell];
	}
}

- (void)reflectScrolledClipView:(NSClipView *)aClipView{
	[super reflectScrolledClipView:aClipView];

	[self removeInvisibleCells];
	[self layoutVisibleCells];
}

#pragma mark Todo
- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
	
}

#pragma mark Todo
- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated {
	
}

#pragma mark Todo
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	
}

#pragma mark Todo
- (NSIndexPath *)indexPathForSelectedRow {
	return nil;
}

#pragma mark Todo
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition {
	
}

#pragma mark Todo
- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
	
}

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier {
	if(!identifier) return nil;
	
	UITableViewCell* aTableViewCell = [[_reusableTableCells objectForKey:identifier] anyObject];
	if(!aTableViewCell) return nil;
	
	[aTableViewCell retain];
	
	[[_reusableTableCells objectForKey:identifier] removeObject:aTableViewCell];
	
	return [aTableViewCell autorelease];
}

- (void)queueReusableCell:(UITableViewCell*)aTableViewCell {
	if(!aTableViewCell) return;
	if(!aTableViewCell.reuseIdentifier) return;
	
	[aTableViewCell prepareForReuse];
	
	if(![_reusableTableCells objectForKey:aTableViewCell.reuseIdentifier]) {
		[_reusableTableCells setObject:[NSMutableSet setWithCapacity:1] forKey:aTableViewCell.reuseIdentifier];
	}
	
	[[_reusableTableCells objectForKey:aTableViewCell.reuseIdentifier] addObject:aTableViewCell];
}

- (void)dealloc {
	[_sectionData release];
	[_visibleCells release];
	[_reusableTableCells release];
	[super dealloc];
}

@end

@implementation NSIndexPath (UITableView)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)row inSection:(NSUInteger)section {
	NSUInteger indexArr[] = {section,row};
	return [NSIndexPath indexPathWithIndexes:indexArr length:2];
}

- (NSUInteger)section {
	return [self indexAtPosition:0];
}

- (NSUInteger)row {
	return [self indexAtPosition:1];
}

@end
