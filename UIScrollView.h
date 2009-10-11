//
//  UIScrollView.h
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>
#import <UIKit/UIView.h>

@interface UIScrollView : NSScrollView {
@private
	UIColor* _backgroundColor;
}

/*
 IMPORTANT:
 -----------------------------------------------------------------------------
 NSScrollView uses the contentSize/Offset properties differently
 than the way they're used on the iPhone.  Wherever you use contentSize/Offset
 on the iPhone, use documentSize/Offset on Mac.
 */
@property(nonatomic,assign) NSSize documentSize; // contentOffset on iPhone
@property(nonatomic,assign) NSPoint documentOffset; // contentOffset on iPhone

@property(nonatomic,retain) UIColor* backgroundColor;
@end