//
//  UILabel.m
//  UIKit
//
//  Created by Shaun Harrison on 6/24/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UILabel.h"

@implementation UILabel
@synthesize text, font, highlightedTextColor, textColor, shadowColor, shadowOffset;

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {

    }
	
    return self;
}

- (void)setText:(NSString*)newText {
	if([newText isEqualToString:text]) return;
	
	if(text) [text release];
	text = [newText copy];
	[self setNeedsDisplay];
}

- (void)drawRect:(NSRect)rect {
	if(!self.text) return;
	
	if(!isHighlighted && self.shadowColor) {
		[self.shadowColor set];
		NSRect offsetRect = rect;
		offsetRect.origin = NSMakePoint(offsetRect.origin.x+self.shadowOffset.width, offsetRect.origin.y+self.shadowOffset.height);
		[self.text drawInRect:offsetRect withAttributes:[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName]];
	}
	
	if(isHighlighted) {
		[self.highlightedTextColor set];
	} else {
		[self.textColor set];
	}

	[self.text drawInRect:rect withAttributes:[NSDictionary dictionaryWithObject:self.font forKey:NSFontAttributeName]];
}

- (NSFont*)font {
	if(!font) {
		self.font = [NSFont systemFontOfSize:17.0f];
	}
	
	return font;
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
	[super dealloc];
}


@end
