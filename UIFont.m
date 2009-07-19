//
//  UIFont.m
//  UIKit
//
//  Created by Shaun Harrison on 7/19/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UIFont.h"


@implementation UIFont

+ (UIFont *)systemFontOfSize:(CGFloat)fontSize {
	return (UIFont *)[[self class] fontWithName:@"Helvetica" size:fontSize];
}

+ (UIFont *)boldSystemFontOfSize:(CGFloat)fontSize {
	return (UIFont *)[[self class] fontWithName:@"Helvetica Bold" size:fontSize];
}

@end
