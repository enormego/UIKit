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
@end


@implementation UITableView
@synthesize style=_style, dataSource=_dataSource, delegate=_delegate;
@synthesize rowHeight=_rowHeight, sectionHeaderHeight=_sectionHeaderHeight, sectionFooterHeight=_sectionFooterHeight;
@synthesize editing=_isEditing, allowsSelection=_allowsSelection, allowsSelectionDuringEditing=_allowsSelectionDuringEditing;
@synthesize separatorStyle=_separatorStyle, separatorColor=_separatorColor;
@synthesize tableHeaderView=_tableHeaderView, tableFooterView=_tableFooterView;

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		NSLog(@"initWithFrame");
		_rowHeight = 44.0f;
		_sectionHeaderHeight = 22.0f;
		_sectionFooterHeight = 22.0f;
		_allowsSelection = YES;
		_allowsSelectionDuringEditing = NO;
		_separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		_separatorColor = [[UIColor grayColor] retain];
		_reusableTableCells = [[NSMutableDictionary alloc] init];
		_visibleCells = [[NSMutableArray alloc] init];

		self.hasVerticalScroller = YES;
		self.hasHorizontalScroller = NO;
		self.autohidesScrollers = NO;
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
	
	for(int section = 0; section < sections; section++) {
		NSInteger rows = [self.dataSource tableView:self numberOfRowsInSection:section];
		if(variableRowHeights) {
			for(int row = 0; row < rows; row++) {
				height += [self.delegate tableView:self heightForRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:section]];
			}
		} else {
			height += rows * self.rowHeight;
		}
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

#pragma mark Todo
- (NSArray*)visibleCells {
	return _visibleCells;
}

- (NSArray*)indexPathsForVisibleRows {
	NSInteger sections = 1;
	
	if([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
		sections = [self.dataSource numberOfSectionsInTableView:self];
	}

	NSMutableArray* indexPaths = [NSMutableArray array];
	BOOL variableRowHeights = [self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)];
	float yOffset = 0.0f;
	
	CGRect clipViewBounds = NSRectToCGRect(self.contentView.bounds);
	for(int section = 0; section < sections; section++) {
		NSInteger rows = [self.dataSource tableView:self numberOfRowsInSection:section];
		for(int row = 0; row < rows; row++) {
			CGFloat rowHeight = self.rowHeight;
			NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:section];
			
			if(variableRowHeights) {
				rowHeight = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
			}
			
			CGRect rowRect = CGRectFromOffsetHeight(yOffset, rowHeight);
			if(CGRectIntersectsRect(clipViewBounds, rowRect)) {
				[indexPaths addObject:indexPath];
			}
			
			yOffset += rowHeight;
		}
	}
	
	return indexPaths;
}

- (void)layoutVisibleCells {
	NSInteger sections = 1;
	[_visibleCells removeAllObjects];
	
	if([self.dataSource respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
		sections = [self.dataSource numberOfSectionsInTableView:self];
	}
	
	BOOL variableRowHeights = [self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)];
	float yOffset = 0.0f;
	
	CGRect clipViewBounds = NSRectToCGRect(self.contentView.bounds);
	for(int section = 0; section < sections; section++) {
		NSInteger rows = [self.dataSource tableView:self numberOfRowsInSection:section];
		for(int row = 0; row < rows; row++) {
			CGFloat rowHeight = self.rowHeight;
			NSIndexPath* indexPath = [NSIndexPath indexPathForRow:row inSection:section];
			
			if(variableRowHeights) {
				rowHeight = [self.delegate tableView:self heightForRowAtIndexPath:indexPath];
			}
			
			CGRect rowRect = CGRectFromOffsetHeight(yOffset, rowHeight);
			if(CGRectIntersectsRect(clipViewBounds, rowRect)) {
				UITableViewCell* aCell = [self.dataSource tableView:self cellForRowAtIndexPath:indexPath];
				if(!aCell.separatorColor) aCell.separatorColor = _separatorColor;
				
				aCell.frame = NSMakeRect(0.0f, yOffset, self.documentSize.width, rowHeight);
				[aCell setNeedsLayout];
				[aCell setNeedsDisplay];
				[self.documentView addSubview:aCell];
				[aCell layoutIfNeeded];
				[_visibleCells addObject:aCell];
			}
			
			yOffset += rowHeight;
			
			if(yOffset > (clipViewBounds.origin.y + clipViewBounds.size.height)) break; // No use continuing at this point
		}
	}
}

- (void)removeInvisibleCells {
	NSMutableSet* cellsToRemove = [NSMutableSet set];
	//CGRect clipViewBounds = NSRectToCGRect(self.contentView.bounds);
	for(UITableViewCell* cell in [self.documentView subviews]) {
		if(![cell isKindOfClass:[UITableViewCell class]]) continue;
		//if(CGRectIntersectsRect(clipViewBounds, NSRectToCGRect(cell.frame))) continue;
		[cellsToRemove addObject:cell];
	}
	
	[cellsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
	//[_visibleCells removeObjectsInArray:[cellsToRemove allObjects]];
	
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
	[aTableViewCell prepareForReuse];
	
	return [aTableViewCell autorelease];
}

- (void)queueReusableCell:(UITableViewCell*)aTableViewCell {
	if(!aTableViewCell) return;
	if(!aTableViewCell.reuseIdentifier) return;
	
	if(![_reusableTableCells objectForKey:aTableViewCell.reuseIdentifier]) {
		[_reusableTableCells setObject:[NSMutableSet setWithCapacity:1] forKey:aTableViewCell.reuseIdentifier];
	}
	
	[[_reusableTableCells objectForKey:aTableViewCell.reuseIdentifier] addObject:aTableViewCell];
}

- (void)dealloc {
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
