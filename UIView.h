//
//  UIView.h
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <UIKit/UIKitDefines.h>

enum {
    UIViewAutoresizingNone					=  0,
    UIViewAutoresizingFlexibleLeftMargin	=  1,
    UIViewAutoresizingFlexibleWidth			=  2,
    UIViewAutoresizingFlexibleRightMargin	=  4,
    UIViewAutoresizingFlexibleTopMargin		=  8,
    UIViewAutoresizingFlexibleHeight		= 16,
    UIViewAutoresizingFlexibleBottomMargin	= 32
};

@class UIColor, CALayer;
@interface UIView : NSView {
@private
	UIColor* _backgroundColor;
	BOOL _needsLayout;
}

- (void)setNeedsDisplay;

- (void)setNeedsLayout;
- (void)layoutIfNeeded;
- (void)layoutSubviews;

@property(nonatomic,retain) UIColor* backgroundColor;
@end

@interface NSView (UIViewLayerBacking)
@property(nonatomic,assign,getter=isHidden) BOOL hidden;
@property(nonatomic,retain) CALayer* layer;
@end