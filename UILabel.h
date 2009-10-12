//
//  UILabel.h
//  UIKit
//
//  Created by Shaun Harrison on 6/24/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIText.h>
#import <UIKit/UIView.h>
#import <UIKit/UIColor.h>

// TODO: Fix Shadows.  For some reason CATextLayer is ignoring it's shadow property

@class CATextLayer;
@interface UILabel : UIView {
@private
	CATextLayer* _textLayer;
	NSString* _text;
	NSFont* _font;
	UIColor* _textColor;
	UIColor* _shadowColor;
	UIColor* _highlightedTextColor;
	CGSize _shadowOffset;
	BOOL _highlighted;
	UITextAlignment _textAlignment;
	UILineBreakMode _lineBreakMode;
}

@property(nonatomic,copy) NSString* text;
@property(nonatomic,retain) NSFont* font;
@property(nonatomic,retain) UIColor* textColor;
@property(nonatomic,retain) UIColor* shadowColor;
@property(nonatomic,assign) CGSize shadowOffset;
@property(nonatomic,assign) UITextAlignment textAlignment;
@property(nonatomic,assign) UILineBreakMode lineBreakMode;

@property(nonatomic,retain) UIColor* highlightedTextColor;
@property(nonatomic,assign,getter=isHighlighted) BOOL highlighted;
@end
