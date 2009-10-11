//
//  UIScrollView.m
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UIScrollView.h"
#import "UIClipView.h"
#import "UIColor.h"

@interface UIScrollView (Private)
@property(nonatomic,retain) UIView* documentView;
@end


@implementation UIScrollView
@synthesize backgroundColor=_backgroundColor;

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		self.wantsLayer = YES;

		self.contentView = [[[UIClipView alloc] initWithFrame:self.bounds] autorelease];
		self.contentView.wantsLayer = YES;
		self.hasVerticalScroller = YES;
		self.hasHorizontalScroller = YES;
		self.autohidesScrollers = YES;
		self.documentView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
		
		self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	}
	
	return self;
}

- (void)setDocumentSize:(NSSize)aSize {
	NSRect aRect = self.documentView.frame;
	aRect.size = aSize;
	self.documentView.frame = aRect;
}

- (NSSize)documentSize {
	return self.documentView.frame.size;	
}

- (void)setDocumentOffset:(NSPoint)aPoint {
	
}

- (NSPoint)documentOffset {
	return NSMakePoint(0.0f, 0.0f);
}

- (void)addSubview:(UIView*)aView {
	if([aView isKindOfClass:[NSClipView class]]) {
		[super addSubview:aView];
	} else if([aView isKindOfClass:[NSScroller class]]) {
		[super addSubview:aView];
	} else {
		[self.documentView addSubview:aView];
	}
}

- (BOOL)isFlipped {
	return YES;
}

- (void)setBackgroundColor:(UIColor *)aColor {
	[_backgroundColor release];
	_backgroundColor = [aColor retain];
	
	self.documentView.backgroundColor = aColor;
	self.contentView.backgroundColor = aColor.NSColor;
}

- (void)dealloc {
	[_backgroundColor release];
	[super dealloc];
}

@end
