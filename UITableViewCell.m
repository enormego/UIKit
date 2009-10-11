//
//  UITableViewCell.m
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UITableViewCell.h"
#import "UITableViewCell-Private.h"
#import "UILabel.h"

#import <QuartzCore/QuartzCore.h>

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
	if(self = [self initWithFrame:NSMakeRect(0.0f, 0.0f, 320.0f, 44.0f) reuseIdentifier:reuseIdentifier]) {
		
	}
	
	return self;
}

- (id)initWithFrame:(NSRect)frame reuseIdentifier:(NSString *)reuseIdentifier {
	if((self = [super initWithFrame:frame])) {
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		self.backgroundColor = [UIColor whiteColor];
		_reuseIdentifier = [reuseIdentifier copy];
		_selectionStyle = UITableViewCellSelectionStyleBlue;
		
		_contentView = [[UIView alloc] initWithFrame:NSMakeRect(0.0f, 0.0f, frame.size.width, frame.size.height-1.0f)];
		_contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

		
		self.separatorColor = [UIColor blackColor];

		_separatorView = [[UIView alloc] initWithFrame:NSMakeRect(0.0f, 10.0f, frame.size.width, 10.0f)];
		_separatorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

		//[_contentView addSubview:_separatorView];
		
		[self addSubview:_contentView];
		//[self addSubview:_separatorView];
		
		_separatorView.backgroundColor = [UIColor blackColor];
	}
	
	return self;
}

- (UILabel*)textLabel {
	@synchronized(self) {
		if(!_textLabel) {
			_textLabel = [[UILabel alloc] initWithFrame:_contentView.bounds];
			_textLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
			_textLabel.font = [UIFont boldSystemFontOfSize:17.0f];
			_textLabel.backgroundColor = self.backgroundColor;
			_textLabel.textColor = [UIColor blackColor];
			
			[_contentView addSubview:_textLabel];
		}
	}
	
	return _textLabel;
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

- (UIColor*)separatorColor {
	return _separatorColor;
}

- (void)setSeparatorColor:(UIColor*)aColor {
	[_separatorColor release];
	_separatorColor = [aColor retain];
	_separatorView.backgroundColor = _separatorColor;
}

- (void)layoutSubviews {
	[super layoutSubviews];
}

- (void)dealloc {
	[_separatorColor release];
	[_contentView release];
	[super dealloc];
}

@end
