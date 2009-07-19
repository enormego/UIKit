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

- (id)initWithFrame:(NSRect)frameRect {
	if((self = [super initWithFrame:frameRect])) {
		self.contentView = [[[UIClipView alloc] initWithFrame:self.bounds] autorelease];
		self.hasVerticalScroller = YES;
		self.hasHorizontalScroller = YES;
		self.autohidesScrollers = YES;
		self.documentView = [[[UIView alloc] initWithFrame:self.bounds] autorelease];
		self.documentView.backgroundColor = [UIColor whiteColor];
		
		self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		self.documentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
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

- (void)dealloc {
	[super dealloc];
}

@end
