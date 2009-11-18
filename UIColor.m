//
//  UIColor.m
//  UIKit
//
//  Created by Shaun Harrison on 7/19/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import "UIColor.h"

CGPatternRef CreateImagePattern(CGImageRef image);
CGColorRef CreatePatternColor(CGImageRef image);	

@implementation UIColor

// Convenience methods for creating autoreleased colors
+ (UIColor *)colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	return [[[UIColor alloc] initWithWhite:white alpha:alpha] autorelease];
}

+ (UIColor *)colorWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	return [[[UIColor alloc] initWithHue:hue saturation:saturation brightness:brightness alpha:alpha] autorelease];
}

+ (UIColor *)colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	return [[[UIColor alloc] initWithRed:red green:green blue:blue alpha:alpha] autorelease];
}

+ (UIColor *)colorWithCGColor:(CGColorRef)cgColor {
	return [[[UIColor alloc] initWithCGColor:cgColor] autorelease];
}

+ (UIColor *)colorWithPatternImage:(UIImage *)image {
	return [[[UIColor alloc] initWithPatternImage:image] autorelease];
}

+ (UIColor *)colorWithPatternImageRef:(CGImageRef)imageRef {
	return [[[UIColor alloc] initWithPatternImageRef:imageRef] autorelease];
}

// Initializers for creating non-autoreleased colors
- (UIColor *)initWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
	if((self = [super init])) {
		CGColor = CGColorCreateGenericGray(white, alpha);
	}
	
	return self;
}

- (UIColor *)initWithHue:(CGFloat)hue saturation:(CGFloat)saturation brightness:(CGFloat)brightness alpha:(CGFloat)alpha {
	hue = roundf(hue * 100) / 100;
	saturation = roundf(saturation * 100) / 100;
	brightness = roundf(brightness * 100) / 100;

	NSInteger hexBrightness = (NSInteger)roundf(brightness * 2.55f);
	NSInteger red = 0;
	NSInteger green = 0;
	NSInteger blue = 0;

	if (saturation == 0.0f) {
		red = green = blue = hexBrightness;
	} else {
		
		NSInteger Hi = floor(hue / 60);
		NSInteger f = hue / 60 - Hi;
		NSInteger p = round(brightness * (100 - saturation) * .0255);
		NSInteger q = round(brightness * (100 - f * saturation) * .0255);
		NSInteger t = round(brightness * (100 - (1 - f) * saturation) * .0255);
		
		switch (Hi) {
			case 0:
				red = hexBrightness;
				green = t;
				blue = p;
				break;
			case 1:
				red = q;
				green = hexBrightness;
				blue = p;
				break;
			case 2:
				red = p;
				green = hexBrightness;
				blue = t;
				break;
			case 3:
				red = p;
				green = q;
				blue = hexBrightness;
				break;
			case 4:
				red = t;
				green = p;
				blue = hexBrightness;
				break;
			case 5:
				red = hexBrightness;
				green = p;
				blue = q;
		}
	}
	
	return [self initWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];  
}

- (UIColor *)initWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
	if((self = [super init])) {
		CGColor = CGColorCreateGenericRGB(red, green, blue, alpha);
	}
	
	return self;
}

- (UIColor *)initWithCGColor:(CGColorRef)cgColor {
	if((self = [super init])) {
		CGColor = CGColorRetain(cgColor);
	}
	
	return self;
}

- (UIColor *)initWithPatternImage:(UIImage*)image {
	return nil;
}

- (UIColor *)initWithPatternImageRef:(CGImageRef)imageRef {
	if((self = [super init])) {
		CGColor = CreatePatternColor(imageRef);	
	}
	
	return self;
}

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
	// Not sure
}

// Set the fill or stroke colors individually. These should be implemented by subclassers.
- (void)setFill {
	// Not sure
}

- (void)setStroke {
	// Not sure
}

// Returns a color in the same color space as the receiver with the specified alpha component.
- (UIColor *)colorWithAlphaComponent:(CGFloat)alpha {
	CGColorRef cgColor = CGColorCreateCopyWithAlpha(self.CGColor, alpha);
	UIColor* color = [UIColor colorWithCGColor:cgColor];
	CGColorRelease(cgColor);
	return color;
}

- (CGColorRef)CGColor {
	return CGColor;
}

- (NSColor*)NSColor {
	NSColorSpace* colorSpace = [[[NSColorSpace alloc] initWithCGColorSpace:CGColorGetColorSpace(self.CGColor)] autorelease];
	const CGFloat* components = (const CGFloat*)CGColorGetComponents(self.CGColor);
	NSInteger numberOfComponents = CGColorGetNumberOfComponents(self.CGColor);
	
	return [NSColor colorWithColorSpace:colorSpace components:components count:numberOfComponents];
}

- (BOOL)isEqual:(UIColor*)aColor {
	if(![aColor isKindOfClass:[UIColor class]]) return NO;
	return CGColorEqualToColor(self.CGColor, aColor.CGColor);
}

- (void)dealloc {
	CGColorRelease(CGColor);
	[super dealloc];
}


@end


/*
 * @see http://developer.apple.com/mac/library/samplecode/GeekGameBoard/listing38.html
 */

// callback for CreateImagePattern.
static void drawPatternImage (void *info, CGContextRef ctx) {
    CGImageRef image = (CGImageRef) info;
    CGContextDrawImage(ctx, 
                       CGRectMake(0,0, CGImageGetWidth(image),CGImageGetHeight(image)),
                       image);
}

// callback for CreateImagePattern.
static void releasePatternImage( void *info ) {
    CGImageRelease( (CGImageRef)info );
}


CGPatternRef CreateImagePattern(CGImageRef image) {
    NSCParameterAssert(image);
    int width = CGImageGetWidth(image);
    int height = CGImageGetHeight(image);
    static const CGPatternCallbacks callbacks = {0, &drawPatternImage, &releasePatternImage};
    return CGPatternCreate (image,
                            CGRectMake (0, 0, width, height),
                            CGAffineTransformMake (1, 0, 0, 1, 0, 0),
                            width,
                            height,
                            kCGPatternTilingConstantSpacing,
                            true,
                            &callbacks);
}


CGColorRef CreatePatternColor(CGImageRef image) {
    CGPatternRef pattern = CreateImagePattern(image);
    CGColorSpaceRef space = CGColorSpaceCreatePattern(NULL);
    CGFloat components[1] = {1.0};
    CGColorRef color = CGColorCreateWithPattern(space, pattern, components);
    CGColorSpaceRelease(space);
    CGPatternRelease(pattern);
    return color;
}