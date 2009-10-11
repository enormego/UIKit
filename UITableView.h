//
//  UITableView.h
//  UIKit
//
//  Created by Shaun Harrison on 4/30/09.
//  Copyright 2009 enormego. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <UIKit/UIScrollView.h>
#import <UIKit/UIView.h>
#import <UIKit/UITableViewCell.h>
#import <UIKit/UIKitDefines.h>

typedef enum {
    UITableViewStylePlain,              // regular table view
    UITableViewStyleGrouped             // preferences style table view
} UITableViewStyle;

typedef enum {
    UITableViewScrollPositionNone,        
    UITableViewScrollPositionTop,    
    UITableViewScrollPositionMiddle,   
    UITableViewScrollPositionBottom
} UITableViewScrollPosition;            // scroll so row of interest is completely visible at top/center/bottom of view

typedef enum {
    UITableViewRowAnimationFade,
    UITableViewRowAnimationRight,       // slide in from right (or out to right)
    UITableViewRowAnimationLeft,
    UITableViewRowAnimationTop,
    UITableViewRowAnimationBottom,
    UITableViewRowAnimationNone,        // available in iPhone 3.0
} UITableViewRowAnimation;

@protocol UITableViewDataSource, UITableViewDelegate;

UIKIT_EXTERN_CLASS @interface UITableView : UIScrollView {
@private
    UITableViewStyle            _style;
	
    id<UITableViewDataSource>	_dataSource;
    id<UITableViewDelegate>		_delegate;
    
    NSMutableArray*             _sectionData;
    CGFloat                     _rowHeight;
    CGFloat                     _sectionHeaderHeight;
    CGFloat                     _sectionFooterHeight;
	
	BOOL						_isEditing;
	BOOL						_allowsSelection;
	BOOL						_allowsSelectionDuringEditing;
	
	UITableViewCellSeparatorStyle _separatorStyle;
	
    NSMutableArray             *_visibleCells;
    NSIndexPath                *_firstResponderIndexPath;
    UITableViewCell            *_firstResponderCell;
    NSMutableDictionary        *_reusableTableCells;
    UITableViewCell            *_topSeparatorCell;
    id                          _topSeparator;
    NSMutableArray             *_extraSeparators;
    CFMutableDictionaryRef      _visibleHeaderViews;
    CFMutableDictionaryRef      _visibleFooterViews;
    NSMutableArray             *_reusableHeaderViews;
    NSMutableArray             *_reusableFooterViews;
    NSMutableArray             *_reusableTransparentHeaderViews;
    NSMutableArray             *_reusableTransparentFooterViews;
    
    NSMutableArray             *_highlightedIndexPaths;
    NSMutableArray             *_selectedIndexPaths;
    NSInteger                   _swipeToDeleteSection;
    NSInteger                   _swipeToDeleteRow;
    NSIndexPath                *_pendingSelectionIndexPath;
    UIView                     *_touchedContentView;
    UIView                     *_newContentView;
	
    id                          _deleteAnimationSupport;
    id                          _reorderingSupport;
	
    UIView                     *_index;
    UIView                     *_tableHeaderBackgroundView;
    UIView                     *_tableHeaderView;
    UIView                     *_tableFooterView;
    id                          _countLabel;
	
    NSInteger                   _tableReloadingSuspendedCount;
    NSInteger                   _tableDisplaySuspendedCount;
    NSInteger                   _sectionIndexMinimumDisplayRowCount;
    NSInteger                   _itemCountFooterMinimumDisplayRowCount;
	
    NSMutableArray             *_insertItems;
    NSMutableArray             *_deleteItems;
    NSMutableArray             *_reloadItems;
    
    UIColor                    *_separatorColor;
    UIColor                    *_checkmarkColor;
    
    NSArray                    *_defaultSectionIndexTitles;
	
    NSInteger                   _updateCount;
	
    struct {
        unsigned int dataSourceNumberOfRowsInSection:1;
        unsigned int dataSourceCellForRow:1;
        unsigned int dataSourceNumberOfSectionsInTableView:1;
        unsigned int dataSourceTitleForHeaderInSection:1;
        unsigned int dataSourceTitleForFooterInSection:1;
        unsigned int dataSourceCommitEditingStyle:1;
        unsigned int dataSourceSectionIndexTitlesForTableView:1;
        unsigned int dataSourceSectionForSectionIndexTitle:1;
        unsigned int dataSourceCanEditRow:1;
        unsigned int dataSourceCanMoveRow:1;
		unsigned int dataSourceCanUpdateRow:1;
        unsigned int delegateEditingStyleForRowAtIndexPath:1;
        unsigned int delegateTitleForDeleteConfirmationButtonForRowAtIndexPath:1;
        unsigned int delegateShouldIndentWhileEditing:1;
        unsigned int dataSourceMoveRow:1;
        unsigned int delegateCellForRow:1;
        unsigned int delegateWillDisplayCell:1;
        unsigned int delegateHeightForRow:1;
        unsigned int delegateHeightForSectionHeader:1;
        unsigned int delegateHeightForSectionFooter:1;
        unsigned int delegateViewForHeaderInSection:1;
        unsigned int delegateViewForFooterInSection:1;
        unsigned int delegateDisplayedItemCountForRowCount:1;
        unsigned int delegateDisplayStringForRowCount:1;
        unsigned int delegateAccessoryTypeForRow:1;
        unsigned int delegateAccessoryButtonTappedForRow:1;
        unsigned int delegateWillSelectRow:1;
        unsigned int delegateWillDeselectRow:1;
        unsigned int delegateDidSelectRow:1;
        unsigned int delegateDidDeselectRow:1;
        unsigned int delegateWillBeginEditing:1;
        unsigned int delegateDidEndEditing:1;
        unsigned int delegateWillMoveToRow:1;
        unsigned int delegateIndentationLevelForRow:1;
        unsigned int delegateWantsHeaderForSection:1;
        unsigned int delegateHeightForRowsInSection:1;
        unsigned int style:1;
        unsigned int wasEditing:1;
        unsigned int isEditing:1;
        unsigned int scrollsToSelection:1;
        unsigned int reloadSkippedDuringSuspension:1;
        unsigned int updating:1;
        unsigned int displaySkippedDuringSuspension:1;
        unsigned int needsReload:1;
        unsigned int updatingVisibleCellsManually:1;
        unsigned int scheduledUpdateVisibleCells:1;
        unsigned int scheduledUpdateVisibleCellsFrames:1;
        unsigned int warnForForcedCellUpdateDisabled:1;
        unsigned int displayTopSeparator:1;
        unsigned int countStringInsignificantRowCount:4;
        unsigned int needToAdjustExtraSeparators:1;
        unsigned int overlapsSectionHeaderViews:1;
        unsigned int ignoreDragSwipe:1;        
        unsigned int ignoreTouchSelect:1;
        unsigned int lastHighlightedRowActive:1;
        unsigned int reloading:1;
        unsigned int showsSelectionImmediatelyOnTouchBegin:1;
        unsigned int indexHidden:1;
        unsigned int indexHiddenForSearch:1;
        unsigned int defaultShowsHorizontalScrollIndicator:1;
        unsigned int defaultShowsVerticalScrollIndicator:1;
        unsigned int sectionIndexTitlesLoaded:1;
        unsigned int tableHeaderViewShouldAutoHide:1;
        unsigned int tableHeaderViewIsHidden:1;
        unsigned int tableHeaderViewWasHidden:1;
        unsigned int hideScrollIndicators;
    } _tableFlags;
    
    unsigned int _selectedSection;
    unsigned int _selectedRow;
    unsigned int _lastSelectedSection;
    unsigned int _lastSelectedRow;
	
	CGPoint liveResizeScrollOffset;
}

@property(nonatomic,readonly) UITableViewStyle           style;
@property(nonatomic,assign)   id <UITableViewDataSource> dataSource;
@property(nonatomic,assign)   id <UITableViewDelegate>   delegate;
@property(nonatomic)          CGFloat                    rowHeight;             // will return the default value if unset
@property(nonatomic)          CGFloat                    sectionHeaderHeight;   // will return the default value if unset
@property(nonatomic)          CGFloat                    sectionFooterHeight;   // will return the default value if unset

/* Data
 * Reloads everything from scratch. redisplays visible rows. because we only keep
 * info about visible rows, this is cheap. will adjust offset if table shrinks
 */
- (void)reloadData;

// Info

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;

/*
- (NSRect)rectForSection:(NSInteger)section;									// includes header, footer and all rows
- (NSRect)rectForHeaderInSection:(NSInteger)section;
- (NSRect)rectForFooterInSection:(NSInteger)section;
- (NSRect)rectForRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSIndexPath *)indexPathForRowAtPoint:(CGPoint)point;							// returns nil if point is outside table
- (NSIndexPath *)indexPathForCell:(UITableViewCell*)cell;						// returns nil if cell is not visible
- (NSArray *)indexPathsForRowsInRect:(NSRect)rect;								// returns nil if rect not valid 
*/

- (UITableViewCell*)cellForRowAtIndexPath:(NSIndexPath*)indexPath;				// returns nil if cell is not visible or index path is out of range
- (NSArray*)visibleCells;
- (NSArray*)indexPathsForVisibleRows;

- (void)scrollToRowAtIndexPath:(NSIndexPath *)indexPath atScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;
- (void)scrollToNearestSelectedRowAtScrollPosition:(UITableViewScrollPosition)scrollPosition animated:(BOOL)animated;

// Row insertion/deletion/reloading.
/*
- (void)beginUpdates;   // allow multiple insert/delete of rows and sections to be animated simultaneously. Nestable
- (void)endUpdates;     // only call insert/delete/reload calls inside an update block.  otherwise things like row count, etc. may be invalid.

- (void)insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation;

- (void)insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)deleteRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
- (void)reloadRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation;
*/

// Editing. When set, rows show insert/delete/reorder controls based on data source queries

@property(nonatomic,getter=isEditing) BOOL editing;                             // default is NO. setting is not animated.
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

@property(nonatomic) BOOL allowsSelection;										// default is YES. Controls whether rows can be selected when not in editing mode
@property(nonatomic) BOOL allowsSelectionDuringEditing;                         // default is NO. Controls whether rows can be selected when in editing mode

// Selection

- (NSIndexPath *)indexPathForSelectedRow;                                       // return nil or index path representing section and row of selection.

// Selects and deselects rows. These methods will not call the delegate methods (-tableView:willSelectRowAtIndexPath: or tableView:didSelectRowAtIndexPath:), nor will it send out a notification.
- (void)selectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UITableViewScrollPosition)scrollPosition;
- (void)deselectRowAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated;

// Appearance

@property(nonatomic) UITableViewCellSeparatorStyle separatorStyle;              // default is UITableViewCellSeparatorStyleSingleLine
@property(nonatomic,retain) UIColor* separatorColor;							// default is the standard separator gray

@property(nonatomic,retain) UIView* tableHeaderView;                            // accessory view for above row content. default is nil. not to be confused with section header
@property(nonatomic,retain) UIView* tableFooterView;                            // accessory view below content. default is nil. not to be confused with section footer

- (UITableViewCell *)dequeueReusableCellWithIdentifier:(NSString *)identifier;  // Used by the delegate to acquire an already allocated cell, in lieu of allocating a new one.

@end

//_______________________________________________________________________________________________________________
// this protocol represents the data model object. as such, it supplies no information about appearance (including the cells)

@protocol UITableViewDataSource<NSObject>

@required

- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section;

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;              // Default is 1 if not implemented

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;    // fixed font style. use custom view (UILabel) if you want something different
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;

// Editing

// Individual rows can opt out of having the -editing property set for them. If not implemented, all rows are assumed to be editable.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;

// Moving/reordering

// Allows the reorder accessory view to optionally be shown for a particular row. By default, the reorder control will be shown only if the datasource implements -tableView:moveRowAtIndexPath:toIndexPath:
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;

// Index

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView;                                                    // return list of section titles to display in section index view (e.g. "ABCD...Z#")
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;  // tell table which section corresponds to section title/index (e.g. "B",1))

// Data manipulation - insert and delete support

// After a row has the minus or plus button invoked (based on the UITableViewCellEditingStyle for the cell), the dataSource must commit the change
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;

// Data manipulation - reorder / moving support

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

@end

//_______________________________________________________________________________________________________________
// this represents the display and behaviour of the cells.

@protocol UITableViewDelegate<NSObject/*, UIScrollViewDelegate*/>

@optional

// Display customization

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

// Variable height support

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

// Section header & footer information. Views are preferred over title should you decide to provide both

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;   // custom view for header. will be adjusted to default or specified header height
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;   // custom view for footer. will be adjusted to default or specified footer height

// Accessories (disclosures). 

- (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_BUT_DEPRECATED(__MAC_NA,__MAC_NA,__IPHONE_2_0,__IPHONE_3_0);
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath;

// Selection

// Called before the user changes the selection. Return a new indexPath, or nil, to change the proposed selection.
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSIndexPath *)tableView:(UITableView *)tableView willDeselectRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);

// Editing

// Allows customization of the editingStyle for a particular cell located at 'indexPath'. If not implemented, all editable cells will have UITableViewCellEditingStyleDelete set for them when the table has editing property set to YES.
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);

// Controls whether the background is indented while editing.  If not implemented, the default is YES.  This is unrelated to the indentation level below.  This method only applies to grouped style table views.
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath;

// The willBegin/didEnd methods are called whenever the 'editing' property is automatically changed by the table (allowing insert/delete/move). This is done by a swipe activating a single row
- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath;

// Moving/reordering

// Allows customization of the target row for a particular row as it is being moved/reordered
- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath;               

// Indentation

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath; // return 'depth' of row for hierarchies

@end

UIKIT_EXTERN NSString *const UITableViewSelectionDidChangeNotification;

//_______________________________________________________________________________________________________________

// This category provides convenience methods to make it easier to use an NSIndexPath to represent a section and row
@interface NSIndexPath (UITableView)

+ (NSIndexPath *)indexPathForRow:(NSUInteger)row inSection:(NSUInteger)section;

@property(nonatomic,readonly) NSUInteger section;
@property(nonatomic,readonly) NSUInteger row;

@end
