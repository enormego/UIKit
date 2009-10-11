//
//  UIView.m
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UIView.h"
#import "UIColor.h"

#import <QuartzCore/QuartzCore.h>

@implementation UIView
@synthesize backgroundColor=_backgroundColor;

- (id)initWithFrame:(CGRect)frame {
	if((self = [super initWithFrame:(NSRect)frame])) {
		[self setLayer:[CALayer layer]];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if((self = [super initWithCoder:aDecoder])) {
		[self setLayer:[CALayer layer]];
	}
	
	return self;
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay:YES];
}

- (void)display {
	[super display];
}

- (void)displayIfNeeded {
	[self layoutIfNeeded];
	[super displayIfNeeded];
}

- (void)setBackgroundColor:(UIColor *)aColor {
	[_backgroundColor release];
	_backgroundColor = [aColor retain];
	
	self.layer.backgroundColor = self.backgroundColor.CGColor;
}

- (void)viewDidMoveToSuperview {
	[super viewDidMoveToSuperview];

}

- (void)setNeedsLayout {
	_needsLayout = YES;
	[self setNeedsDisplay];
	[self.layer setNeedsLayout];
}

- (void)layoutSubviews {

}

- (void)layoutIfNeeded {
	if(_needsLayout) {
		[self layoutSubviews];
		_needsLayout = NO;
	}
}

- (BOOL)isFlipped {
	return YES;
}

- (void)dealloc {
	self.backgroundColor = nil;
	[super dealloc];
}

@end
