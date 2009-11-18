//
//  UILabel.m
//  UIKit
//
//  Created by Shaun Harrison on 6/24/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UILabel.h"
#import "UITextField.h"

#import <QuartzCore/QuartzCore.h>

@implementation UILabel
@synthesize text=_text, font=_font, textColor=_textColor, shadowColor=_shadowColor, shadowOffset=_shadowOffset;
@synthesize textAlignment=_textAlignment, lineBreakMode=_lineBreakMode;
@synthesize highlighted=_highlighted, highlightedTextColor=_highlightedTextColor;

- (id)initWithFrame:(NSRect)frame {
    if (self = [super initWithFrame:frame]) {
		self.layer = [CATextLayer layer];
		self.textColor = [UIColor blackColor];
		self.font = [NSFont systemFontOfSize:17.0f];
		self.textAlignment = UITextAlignmentLeft;
		self.lineBreakMode = UILineBreakModeTailTruncation;
    }
	
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if((self = [super initWithCoder:aDecoder])) {
		self.layer = [CATextLayer layer];
		self.textColor = [UIColor blackColor];
		self.font = [NSFont systemFontOfSize:17.0f];
		self.textAlignment = UITextAlignmentLeft;
		self.lineBreakMode = UILineBreakModeTailTruncation;
	}
	
	return self;
}

- (void)setText:(NSString *)text {
	[_text release];
	_text = [text copy];
	
	((CATextLayer*)self.layer).string = _text;
}

- (void)setFont:(NSFont *)font {
	[_font release];
	_font = [font retain];
	
	((CATextLayer*)self.layer).font = _font;
	((CATextLayer*)self.layer).fontSize = [_font pointSize];
}

- (void)setTextColor:(UIColor *)textColor {
	[_textColor release];
	_textColor = [textColor retain];
	
	if(![self isHighlighted]) {
		((CATextLayer*)self.layer).foregroundColor = _textColor.CGColor;
	}
}

- (void)setShadowColor:(UIColor *)shadowColor {
	[_shadowColor release];
	_shadowColor = [shadowColor retain];
	
	self.layer.shadowColor = _shadowColor.CGColor;
}

- (void)setShadowOffset:(CGSize)shadowOffset {
	_shadowOffset = shadowOffset;
	
	self.layer.shadowOffset = _shadowOffset;
}

- (void)setTextAlignment:(UITextAlignment)textAlignment {
	_textAlignment = textAlignment;
	
	NSString* alignmentMode = nil;
	switch(_textAlignment) {
		case UITextAlignmentCenter:
			alignmentMode = kCAAlignmentCenter;
			break;
		case UITextAlignmentRight:
			alignmentMode = kCAAlignmentRight;
			break;
		case UITextAlignmentJusitifed:
			alignmentMode = kCAAlignmentJustified;
			break;
		case UITextAlignmentNatural:
			alignmentMode = kCAAlignmentNatural;
			break;
		default:
			alignmentMode = kCAAlignmentLeft;
	}
	
	((CATextLayer*)self.layer).alignmentMode = alignmentMode;
}

- (void)setLineBreakMode:(UILineBreakMode)lineBreakMode {
	_lineBreakMode = lineBreakMode;
	
	NSString* truncationMode = nil;
	
	switch(_lineBreakMode) {
		case UILineBreakModeWordWrap:
		case UILineBreakModeCharacterWrap:
			((CATextLayer*)self.layer).wrapped = YES;
			truncationMode = kCATruncationNone;
			break;
		case UILineBreakModeClip:
			((CATextLayer*)self.layer).wrapped = NO;
			truncationMode = kCATruncationNone;
			break;
		case UILineBreakModeHeadTruncation:
			truncationMode = kCATruncationStart;
			break;
		case UILineBreakModeMiddleTruncation:
			truncationMode = kCATruncationMiddle;
			break;
		default:
			truncationMode = kCATruncationEnd;
	}
	
	((CATextLayer*)self.layer).truncationMode = truncationMode;
}

- (void)setHighlightedTextColor:(UIColor *)highlightedTextColor {
	[_highlightedTextColor release];
	_highlightedTextColor = [highlightedTextColor retain];
	
	if([self isHighlighted]) {
		((CATextLayer*)self.layer).foregroundColor = _highlightedTextColor.CGColor;
	}	
}

- (void)setHighlighted:(BOOL)highlighted {
	_highlighted = highlighted;

	if(_highlighted && self.highlighted) {
		((CATextLayer*)self.layer).foregroundColor = self.highlightedTextColor.CGColor;
	} else {
		((CATextLayer*)self.layer).foregroundColor = self.textColor.CGColor;
	}
}

- (void)dealloc {
	[_text release];
	[_font release];
	[_textColor release];
	[_shadowColor release];
    [super dealloc];
}

@end
