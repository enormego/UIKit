//
//  UIView.m
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UIView.h"
#import "UIColor.h"

@implementation UIView
@synthesize backgroundColor=_backgroundColor;

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		self.backgroundColor = [UIColor blackColor];
	}
	
	return self;
}

- (void)drawRect:(NSRect)rect {
	[self.backgroundColor setFill];
	NSRectFill(rect);
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay:YES];
}

- (BOOL)isFlipped {
	return YES;
}

- (void)dealloc {
	self.backgroundColor = nil;
	[super dealloc];
}

@end
