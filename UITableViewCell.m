//
//  UITableViewCell.m
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UITableViewCell.h"


@implementation UITableViewCell
@synthesize imageView=_imageView, textLabel=_textLabel, detailTextLabel=_detailTextLabel;
@synthesize contentView=_contentView, backgroundView=_backgroundView, selectedBackgroundView=_selectedBackgroundView;
@synthesize reuseIdentifier=_reuseIdentifier, selectionStyle=_selectionStyle, selected=_isSelected;
@synthesize highlighted=_isHighlighted, editingStyle=_editingStyle, showsReorderControl=_showsReorderControl;
@synthesize shouldIndentWhileEditing=_shouldIndentWhileEditing, accessoryType=_accessoryType;
@synthesize accessoryView=_accessoryView, editingAccessoryView=_editingAccessoryView;
@synthesize editingAccessoryType=_editingAccessoryType, indentationLevel=_indentationLevel;
@synthesize indentationWidth=_indentationWidth, editing=_editing, showingDeleteConfirmation=_showingDeleteConfirmation;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
	if(self = [self initWithFrame:NSMakeRect(0.0f, 0.0f, 500.0f, 44.0f) reuseIdentifier:reuseIdentifier]) {
		
	}
	
	return self;
}

- (id)initWithFrame:(NSRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if((self = [super initWithFrame:frame])) {
		_reuseIdentifier = [reuseIdentifier copy];
		_selectionStyle = UITableViewCellSelectionStyleBlue;
		
		_contentView = [[UIView alloc] initWithFrame:NSMakeRect(0.0f, 0.0f, frame.size.width, frame.size.height)];
	}
	
	return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
	self.selected = selected;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
	self.highlighted = highlighted;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
	self.editing = editing;
}

- (void)prepareForReuse {
	
}

- (void)dealloc {
	[_contentView release];
	[super dealloc];
}

@end
