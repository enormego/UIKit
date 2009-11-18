//
//  UITextField.m
//  UIKit
//
//  Created by Shaun Harrison on 7/20/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UITextField.h"
#import "UIColor.h"
#import <QuartzCore/QuartzCore.h>

//
// IMPORTANT NOTE:
// Do NOT layer back UI/NSTextField.  It will cause a lot of issues.
//

@implementation UITextField
@synthesize backgroundColor, textColor;

- (id)initWithFrame:(NSRect)frame {
	if((self = [super initWithFrame:(NSRect)frame])) {
		[self setDrawsBackground:NO];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if((self = [super initWithCoder:aDecoder])) {
		[self setDrawsBackground:NO];
	}
	
	return self;
}

- (BOOL)isFlipped {
	return YES;
}

- (void)setTextColor:(UIColor *)aColor {
	[textColor release];
	textColor = [aColor retain];
	[super setTextColor:self.textColor.NSColor];
}

- (void)setBackgroundColor:(UIColor *)aColor {
	[backgroundColor release];
	backgroundColor = [aColor retain];
	[super setBackgroundColor:backgroundColor.NSColor];
}

- (void)dealloc {
	[textColor release];
	[backgroundColor release];
	[super dealloc];
}

@end
