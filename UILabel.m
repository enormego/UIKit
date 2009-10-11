//
//  UILabel.m
//  UIKit
//
//  Created by Shaun Harrison on 6/24/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UILabel.h"
#import "UITextField.h"

@implementation UILabel
@synthesize text, font, highlightedTextColor, textColor, shadowColor, shadowOffset;

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		_textField = [[UITextField alloc] initWithFrame:self.bounds];
		_textField.textColor = self.textColor;
		_textField.font = self.font;
		[_textField setEditable:NO];
		[_textField setSelectable:NO];
		[_textField setBezeled:NO];
		
		[self addSubview:_textField];
    }
	
    return self;
}

- (void)setSelectable:(BOOL)isSelectable {
	[_textField setSelectable:isSelectable];
}

- (BOOL)isSelectable {
	return [_textField isSelectable];
}

- (void)setText:(NSString*)newText {
	if([newText isEqualToString:text]) return;
	
	if(text) [text release];
	text = [newText copy];

	[_textField setStringValue:text];
}

- (void)setBackgroundColor:(UIColor *)aColor {
	[super setBackgroundColor:aColor];
}

- (void)setFont:(NSFont*)aFont {
	[font release];
	font = [aFont retain];
	_textField.font = self.font;
}

- (NSFont*)font {
	if(!font) {
		self.font = [NSFont systemFontOfSize:17.0f];
	}
	
	return font;
}

- (void)setTextColor:(UIColor *)aColor {
	[textColor release];
	textColor = [aColor retain];
	
	_textField.textColor = self.textColor;
}

- (UIColor*)textColor {
	if(!textColor) {
		self.textColor = [UIColor blackColor];
	}
	
	return textColor;
}

- (UIColor*)highlightedTextColor {
	if(!highlightedTextColor) {
		self.highlightedTextColor = [UIColor whiteColor];
	}
	
	return highlightedTextColor;
}

- (void)setHighlighted:(BOOL)highlighted {
	isHighlighted = highlighted;
	[self setNeedsDisplay];
}


- (BOOL)isHighlighted {
	return isHighlighted;
}

- (void)setFrame:(NSRect)frame {
	[super setFrame:frame];
	[self setNeedsDisplay];
}

- (void)dealloc {
	[text release];
	[font release];
	[textColor release];
	[highlightedTextColor release];
	[shadowColor release];
	[_textField release];
	[super dealloc];
}


@end
