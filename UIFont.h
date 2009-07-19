//
//  UIFont.h
//  UIKit
//
//  Created by Shaun Harrison on 7/19/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface UIFont : NSFont {

}

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize;

@end
