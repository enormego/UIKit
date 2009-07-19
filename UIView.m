//
//  UIView.m
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UIView.h"


@implementation UIView

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		
	}
	
	return self;
}

- (void)setNeedsDisplay {
	[super setNeedsDisplay:YES];
}

- (BOOL)isFlipped {
	return YES;
}

@end
