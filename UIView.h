//
//  UIView.h
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <UIKit/UIKitDefines.h>

@class UIColor;
@interface UIView : NSView {
@private
	UIColor* _backgroundColor;
}

- (void)setNeedsDisplay;

@property(nonatomic,retain) UIColor* backgroundColor;
@end
