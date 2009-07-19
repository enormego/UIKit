//
//  UITableView.m
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <UIKit/UITableView.h>
#import "UIColor.h"


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
	return nil;
}

#pragma mark Todo
- (NSArray*)indexPathsForVisibleRows {
	return nil;	
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
	return [_reusableTableCells objectForKey:identifier];
}

- (void)dealloc {
	[_reusableTableCells release];
	[super dealloc];
}

@end

@implementation NSIndexPath (UITableView)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)row inSection:(NSUInteger)section {
	NSUInteger indexArr[] = {row,section};
	return [NSIndexPath indexPathWithIndexes:indexArr length:2];
}

- (NSUInteger)section {
	return [self indexAtPosition:1];
}

- (NSUInteger)row {
	return [self indexAtPosition:0];
}

@end
