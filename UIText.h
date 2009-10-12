//
//  UIText.h
//  UIKit
//
//  Created by Shaun Harrison on 10/12/09.
//  Copyright 2009 enormego. All rights reserved.
//

typedef enum {		
    UILineBreakModeWordWrap = 0,            // Wraps text
    UILineBreakModeCharacterWrap,           // Same as calling UILineBreakModeWordWrap for right now -- different behavior than the iPhone
    UILineBreakModeClip,                    // Simply clip when it hits the end of the rect
    UILineBreakModeHeadTruncation,          // Truncate at head of line: "...wxyz". Will truncate multiline text on first line
    UILineBreakModeTailTruncation,          // Truncate at tail of line: "abcd...". Will truncate multiline text on last line
    UILineBreakModeMiddleTruncation,        // Truncate middle of line:  "ab...yz". Will truncate multiline text in the middle
} UILineBreakMode;

typedef enum {
    UITextAlignmentLeft = 0,
    UITextAlignmentCenter,
    UITextAlignmentRight,
	
	// As of iPhone OS 3.1.2 these are not available on the iPhone
	UITextAlignmentJusitifed, 
	UITextAlignmentNatural
} UITextAlignment;

typedef enum {
    UIBaselineAdjustmentAlignBaselines = 0, // default. used when shrinking text to position based on the original baseline
    UIBaselineAdjustmentAlignCenters,
    UIBaselineAdjustmentNone,
} UIBaselineAdjustment;