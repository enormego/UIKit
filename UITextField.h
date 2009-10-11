//
//  UITextField.h
//  UIKit
//
//  Created by Shaun Harrison on 7/20/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class UIColor;
@interface UITextField : NSTextField {
@private
	UIColor* textColor;
	UIColor* backgroundColor;
}

@property(nonatomic,retain) UIColor* textColor;
@property(nonatomic,retain) UIColor* backgroundColor;
@end
