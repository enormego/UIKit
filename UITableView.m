//
//  UITableView.m
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UITableView.h"


@implementation UITableView
@synthesize style=_style, dataSource=_dataSource, delegate=_delegate;
@synthesize rowHeight=_rowHeight, sectionHeaderHeight=_sectionHeaderHeight, sectionFooterHeight=_sectionFooterHeight;
@synthesize editing=_isEditing, allowsSelection=_allowsSelection, allowsSelectionDuringEditing=_allowsSelectionDuringEditing;
@synthesize sectionIndexMinimumDisplayRowCount=_sectionIndexMinimumDisplayRowCount, separatorStyle=_separatorStyle;
@synthesize separatorColor=_separatorColor, tableHeaderView=_tableHeaderView, tableFooterView=_tableFooterView;

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		_rowHeight = 44.0f;
		_sectionHeaderHeight = 22.0f;
		_sectionFooterHeight = 22.0f;
		_allowsSelection = YES;
		_allowsSelectionDuringEditing = NO;
		_separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		_separatorColor = [[NSColor grayColor] retain];
	}
	
	return self;
}

@end
