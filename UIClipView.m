//
//  UIClipView.m
//  UIKit
//
//  Created by Shaun Harrison on 7/19/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UIClipView.h"
#import "UIColor.h"


@implementation UIClipView

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		[self setWantsLayer:YES];
	}
	
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
	if((self = [super initWithCoder:aDecoder])) {
		[self setWantsLayer:YES];
	}
	
	return self;
}

- (BOOL)isFlipped {
	return YES;
}

- (NSString*)description {
	NSString* description = [super description];
	description = [description substringToIndex:description.length - 1];
	description = [description stringByAppendingFormat:@"; %@>", NSStringFromRect(self.frame)];
	return description;
}

@end
