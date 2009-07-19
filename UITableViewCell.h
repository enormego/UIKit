//
//  UITableViewCell.h
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIView.h>
#import <UIKit/UIKitDefines.h>

@class UIImage, UIColor, UILabel, UIImageView, UIButton, UITextField;

typedef enum {
    UITableViewCellStyleDefault,	// Simple cell with text label and optional image view (behavior of UITableViewCell in iPhoneOS 2.x)
    UITableViewCellStyleValue1,		// Left aligned label on left and right aligned label on right with blue text (Used in Settings)
    UITableViewCellStyleValue2,		// Right aligned label on left with blue text and left aligned label on right (Used in Phone/Contacts)
    UITableViewCellStyleSubtitle	// Left aligned label on top and left aligned label on bottom with gray text (Used in iPod).
} UITableViewCellStyle;                 // available in iPhone 3.0

typedef enum {
    UITableViewCellSeparatorStyleNone,
    UITableViewCellSeparatorStyleSingleLine
} UITableViewCellSeparatorStyle;

typedef enum {
    UITableViewCellSelectionStyleNone,
    UITableViewCellSelectionStyleBlue,
    UITableViewCellSelectionStyleGray
} UITableViewCellSelectionStyle;

typedef enum {
    UITableViewCellEditingStyleNone,
    UITableViewCellEditingStyleDelete,
    UITableViewCellEditingStyleInsert
} UITableViewCellEditingStyle;

typedef enum {
    UITableViewCellAccessoryNone,                   // don't show any accessory view
    UITableViewCellAccessoryDisclosureIndicator,    // regular chevron. doesn't track
    UITableViewCellAccessoryDetailDisclosureButton, // blue button w/ chevron. tracks
    UITableViewCellAccessoryCheckmark               // checkmark. doesn't track
} UITableViewCellAccessoryType;

enum {
    UITableViewCellStateDefaultMask                     = 0,
    UITableViewCellStateShowingEditControlMask          = 1 << 0,
    UITableViewCellStateShowingDeleteConfirmationMask   = 1 << 1
};
typedef NSUInteger UITableViewCellStateMask;        // available in iPhone 3.0

#define UITableViewCellStateEditingMask UITableViewCellStateShowingEditControlMask

UIKIT_EXTERN_CLASS @interface UITableViewCell : UIView {
@private
    id           _layoutManager;
    id           _target;
    SEL          _editAction;
    SEL          _accessoryAction;
    id           _oldEditingData;
    id           _editingData;
    CGFloat      _rightMargin;
    NSInteger    _indentationLevel;
    CGFloat      _indentationWidth;
    NSString    *_reuseIdentifier;
    UIView      *_contentView;
    UIImageView *_imageView;
    UILabel     *_textLabel;
    UILabel     *_detailTextLabel;
    UIView      *_backgroundView;
    UIView      *_selectedBackgroundView;
    UIView      *_selectedOverlayView;
    UIColor     *_backgroundColor;
    UIColor     *_separatorColor;
    UIView      *_floatingSeparatorView;
    CFMutableDictionaryRef _unhighlightedStates;
    struct {
        unsigned int separatorStyle:3;
        unsigned int selectionFadeFraction:11;	// used to indicate selection
        unsigned int editingStyle:3;
        unsigned int showsAccessoryWhenEditing:1;
        unsigned int showDisclosure:1;
        unsigned int showTopSeparator:1;
		
        unsigned int disclosureClickable:1;
        unsigned int disclosureStyle:1;
        unsigned int showingRemoveControl:1;
        unsigned int sectionLocation:3;
        unsigned int tableViewStyle:1;
        unsigned int fontSet:1;
        unsigned int usingDefaultSelectedBackgroundView:1;
        unsigned int wasSwiped:1;
        unsigned int highlighted:1;
        unsigned int separatorDirty:1;
        unsigned int drawn:1;
        unsigned int drawingDisabled:1;
        unsigned int style:12;
    } _tableCellFlags;
    
    UIView *_accessoryView;
    UIView *_editingAccessoryView;
    UIView *_customAccessoryView;
    UIView *_customEditingAccessoryView;
    UIView *_separatorView;
    UIView *_topSeparatorView;
    UITextField *_editableTextField;
    CFAbsoluteTime _lastSelectionTime;
    NSTimer *_deselectTimer;
    CGFloat _textFieldOffset;
    SEL _returnAction;
	UITableViewCellSelectionStyle  _selectionStyle;
	BOOL _isSelected;
	BOOL _isHighlighted;
	UITableViewCellEditingStyle _editingStyle;
	BOOL _showsReorderControl;
	BOOL _shouldIndentWhileEditing;
	BOOL _editing;
	BOOL _showingDeleteConfirmation;
	UITableViewCellAccessoryType   _accessoryType;
	UITableViewCellAccessoryType   _editingAccessoryType;
}

// Designated initializer.  If the cell can be reused, you must pass in a reuse identifier.  You should use the same reuse identifier for all cells of the same form.  
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

// Content.  These properties provide direct access to the internal label and image views used by the table view cell.  These should be used instead of the content properties below.
@property(nonatomic,readonly,retain) UIImageView  *imageView __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);   // default is nil.  image view will be created if necessary.

@property(nonatomic,readonly,retain) UILabel      *textLabel __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);   // default is nil.  label will be created if necessary.
@property(nonatomic,readonly,retain) UILabel      *detailTextLabel __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);   // default is nil.  label will be created if necessary (and the current style supports a detail label).

// If you want to customize cells by simply adding additional views, you should add them to the content view so they will be positioned appropriately as the cell transitions into and out of editing mode.
@property(nonatomic,readonly,retain) UIView       *contentView;

// Default is nil for cells in UITableViewStylePlain, and non-nil for UITableViewStyleGrouped. The 'backgroundView' will be added as a subview behind all other views.
@property(nonatomic,retain) UIView                *backgroundView;

// Default is nil for cells in UITableViewStylePlain, and non-nil for UITableViewStyleGrouped. The 'selectedBackgroundView' will be added as a subview directly above the backgroundView if not nil, or behind all other views. It is added as a subview only when the cell is selected. Calling -setSelected:animated: will cause the 'selectedBackgroundView' to animate in and out with an alpha fade.
@property(nonatomic,retain) UIView                *selectedBackgroundView;

@property(nonatomic,readonly,copy) NSString       *reuseIdentifier;
- (void)prepareForReuse;                                                        // if the cell is reusable (has a reuse identifier), this is called just before the cell is returned from the table view method dequeueReusableCellWithIdentifier:.  If you override, you MUST call super.

@property(nonatomic) UITableViewCellSelectionStyle  selectionStyle;             // default is UITableViewCellSelectionStyleBlue.
@property(nonatomic,getter=isSelected) BOOL         selected;                   // set selected state (title, image, background). default is NO. animated is NO
@property(nonatomic,getter=isHighlighted) BOOL      highlighted;                // set highlighted state (title, image, background). default is NO. animated is NO
- (void)setSelected:(BOOL)selected animated:(BOOL)animated;                     // animate between regular and selected state
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated;               // animate between regular and highlighted state

@property(nonatomic,readonly) UITableViewCellEditingStyle editingStyle;         // default is UITableViewCellEditingStyleNone. This is set by UITableView using the delegate's value for cells who customize their appearance accordingly.
@property(nonatomic) BOOL                           showsReorderControl;        // default is NO
@property(nonatomic) BOOL                           shouldIndentWhileEditing;   // default is YES.  This is unrelated to the indentation level below.

@property(nonatomic) UITableViewCellAccessoryType   accessoryType;              // default is UITableViewCellAccessoryNone. use to set standard type
@property(nonatomic,retain) UIView                 *accessoryView;              // if set, use custom view. ignore accessoryType. tracks if enabled can calls accessory action
@property(nonatomic) UITableViewCellAccessoryType   editingAccessoryType;       // default is UITableViewCellAccessoryNone. use to set standard type
@property(nonatomic,retain) UIView                 *editingAccessoryView;       // if set, use custom view. ignore editingAccessoryType. tracks if enabled can calls accessory action

@property(nonatomic) NSInteger                      indentationLevel;           // adjust content indent. default is 0
@property(nonatomic) CGFloat                        indentationWidth;           // width for each level. default is 10.0

@property(nonatomic,getter=isEditing) BOOL          editing;                    // show appropriate edit controls (+/- & reorder). By default -setEditing: calls setEditing:animated: with NO for animated.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@property(nonatomic,readonly) BOOL                  showingDeleteConfirmation;  // currently showing "Delete" button

@end

@interface UITableViewCell (UIDeprecated)

// Frame is ignored.  The size will be specified by the table view width and row height.
- (id)initWithFrame:(NSRect)frame reuseIdentifier:(NSString *)reuseIdentifier;

// Content properties.  These properties were deprecated in iPhone OS 3.0.  The textLabel and imageView properties above should be used instead.
// For selected attributes, set the highlighted attributes on the textLabel and imageView.
@property(nonatomic,copy)   NSString *text __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);                        // default is nil
@property(nonatomic,retain) NSFont   *font __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);                        // default is nil (Use default font)
// @property(nonatomic) UITextAlignment  textAlignment __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);               // default is UITextAlignmentLeft
// @property(nonatomic) UILineBreakMode  lineBreakMode __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);               // default is UILineBreakModeTailTruncation
@property(nonatomic,retain) UIColor  *textColor __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);                   // default is nil (text draws black)
@property(nonatomic,retain) UIColor  *selectedTextColor __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);           // default is nil (text draws white)

@property(nonatomic,retain) UIImage  *image __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);                       // default is nil. appears on left next to title.
@property(nonatomic,retain) UIImage  *selectedImage __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);               // default is nil

// Use the new editingAccessoryType and editingAccessoryView instead
@property(nonatomic) BOOL             hidesAccessoryWhenEditing __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);   // default is YES

// Use the table view data source method -tableView:commitEditingStyle:forRowAtIndexPath: or the table view delegate method -tableView:accessoryButtonTappedForRowWithIndexPath: instead
@property(nonatomic,assign) id        target __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);                      // target for insert/delete/accessory clicks. default is nil (i.e. go up responder chain). weak reference
@property(nonatomic) SEL              editAction __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);                  // action to call on insert/delete call. set by UITableView
@property(nonatomic) SEL              accessoryAction __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);             // action to call on accessory view clicked. set by UITableView

@end
