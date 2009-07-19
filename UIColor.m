//
//  UIColor.m
//  UIKit
//
//  Created by Shaun Harrison on 7/19/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UIColor.h"


@implementation UIColor

// Convenience methods for creating autoreleased colors
+ (UIColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	return (UIColor*)[UIColor colorWithCalibratedWhite:white alpha:alpha];
	// return [[[UIColor alloc] initWithWhite:white alpha:alpha] autorelease];
}

+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	return (UIColor*)[UIColor colorWithCalibratedHue:hue saturation:saturation brightness:brightness alpha:alpha];
	// return [[[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha] autorelease];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return (UIColor*)[UIColor colorWithCalibratedRed:red green:green blue:blue alpha:alpha];
	// return [[[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha] autorelease];
}

+ (UIColor *)colorWithCGColor:(CGColorRef)cgColor {
	return (UIColor*)[super colorWithCIColor:[CIColor colorWithCGColor:cgColor]];
	//return [[[UIColor alloc] initWithCGColor:cgColor] autorelease];
}

+ (UIColor *)colorWithPatternImage:(UIImage *)image {
	return [[[UIColor alloc] initWithPatternImage:image] autorelease];
}

// Initializers for creating non-autoreleased colors
- (UIColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	return nil;
}

- (UIColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	return nil;
}

- (UIColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return nil;
}

- (UIColor *)initWithCGColor:(CGColorRef)cgColor {
	return nil;
}

- (UIColor *)initWithPatternImage:(UIImage*)image {
	return nil;
}

// Some convenience methods to create colors.  These colors will be as calibrated as possible.
// These colors are cached.
+ (UIColor *)blackColor {
	return [UIColor colorWithWhite:0.0f alpha:1.0f];
}

+ (UIColor *)darkGrayColor {
	return [UIColor colorWithWhite:0.333f alpha:1.0f];
}

+ (UIColor *)lightGrayColor {
	return [UIColor colorWithWhite:0.667f alpha:1.0f];
}

+ (UIColor *)whiteColor {
	return [UIColor colorWithWhite:1.0f alpha:1.0f];
}

+ (UIColor *)grayColor {
	return [UIColor colorWithWhite:0.5f alpha:1.0f];
}

+ (UIColor *)redColor {
	return [UIColor colorWithRed:1.0f green:0.0f blue:0.0f alpha:1.0f];
}

+ (UIColor *)greenColor {
	return [UIColor colorWithRed:0.0f green:1.0f blue:0.0f alpha:1.0f];
}

+ (UIColor *)blueColor {
	return [UIColor colorWithRed:0.0f green:0.0f blue:1.0f alpha:1.0f];
}

+ (UIColor *)cyanColor {
	return [UIColor colorWithRed:0.0f green:1.0f blue:1.0f alpha:1.0f];
}

+ (UIColor *)yellowColor {
	return [UIColor colorWithRed:1.0f green:1.0f blue:0.0f alpha:1.0f];
}

+ (UIColor *)magentaColor {
	return [UIColor colorWithRed:1.0f green:0.0f blue:1.0f alpha:1.0f];
}

+ (UIColor *)orangeColor {
	return [UIColor colorWithRed:1.0f green:0.5f blue:0.0f alpha:1.0f];
}

+ (UIColor *)purpleColor {
	return [UIColor colorWithRed:0.5f green:0.0f blue:0.5f alpha:1.0f];
}

+ (UIColor *)brownColor {
	return [UIColor colorWithRed:0.6f green:0.4f blue:0.2f alpha:1.0f];
}

+ (UIColor *)clearColor {
	return [UIColor colorWithWhite:0.0f alpha:0.0f];
}

// Set the color: Sets the fill and stroke colors in the current drawing context. Should be implemented by subclassers.
- (void)set {
	[super set];	
}

// Set the fill or stroke colors individually. These should be implemented by subclassers.
- (void)setFill {
	[super setFill];
}

- (void)setStroke {
	[super setStroke];
}

// Returns a color in the same color space as the receiver with the specified alpha component.
- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha {
	return nil;
}

- (CGColorRef)CGColor {
	return NULL;
}

@end
