//
//  UIView+Addition.h
//  SOKit
//
//  Created by Carl on 15/5/7.
//  Copyright (c) 2015年 Carl. All rights reserved.
//

#import <UIKit/UIKit.h>

/************************************************************************/
/***************************** UIView Frame *****************************/
/************************************************************************/
@interface UIView(Additions)

/**
 * Shortcut for frame.origin.x.
 *
 * Sets frame.origin.x = left
 */
@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;


// Frame Origin
/**
 * Shortcut for x
 *
 * Sets frame.origin.x = x
 */
@property (nonatomic) CGFloat x;

/**
 * Shortcut for y
 *
 * Sets frame.origin.y = y
 */
@property (nonatomic) CGFloat y;


/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 * x  equale   left
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 * y  equale   top
 */
@property (nonatomic) CGFloat centerY;

/**
 * Return the x coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenX;

/**
 * Return the y coordinate on the screen.
 */
@property (nonatomic, readonly) CGFloat ttScreenY;

/**
 * Return the x coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewX;

/**
 * Return the y coordinate on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGFloat screenViewY;

/**
 * Return the view frame on the screen, taking into account scroll views.
 */
@property (nonatomic, readonly) CGRect screenFrame;

/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

/**
 * Removes all subviews.
 */
- (void)removeAllSubviews;

@end
/************************************************************************/



/************************************************************************/
/*************************** UIView Animation ***************************/
/************************************************************************/

@interface UIView (Animation)

// Moves
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option;
- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack;
- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method;

// Transforms
- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method;
- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method;
- (void)spinClockwise:(float)secs;
- (void)spinCounterClockwise:(float)secs;

// Transitions
- (void)curlDown:(float)secs;
- (void)curlUpAndAway:(float)secs;
- (void)drainAway:(float)secs;

// Effects
- (void)changeAlpha:(float)newAlpha secs:(float)secs;
- (void)pulse:(float)secs continuously:(BOOL)continuously;

@end
/************************************************************************/




/************************************************************************/
/**************************** UIView Data State *************************/
/************************************************************************/

extern CGFloat const SODataStateDefaultHeight;

typedef NS_OPTIONS(NSUInteger, SOViewDataState) {
    SOViewDataStateNormal  = 0,    //正常显示
    SOViewDataStateNoData,         //没有数据
    SOViewDataStateLoading         //正在加载
};

@interface UIView(DataState)

//相对位置，默认(0.5f, 0.5f)
- (CGPoint)dataStatePosition;
- (void)setDataStatePosition:(CGPoint)position;

- (CGFloat)dataStateImageContentOffset;
- (void)setDataStateImageContentOffset:(CGFloat)offset;

- (UIFont *)dataStateWaringFont;
- (void)setDataStateWaringFont:(UIFont *)font;

- (NSString *)dataStateWaring;
- (void)setDataStateWaring:(NSString *)waring;

- (UIImage *)dataStateWaringImage;
- (void)setDataStateWaringImage:(UIImage *)image;

- (UIColor *)dataStateLoadingViewColor;
- (void)setDataStateLoadingViewColor:(UIColor *)color;

- (SOViewDataState)dataState;
- (void)setDataState:(SOViewDataState)dataState;

- (void)SOStateViewLayoutSubviews;

@end
/************************************************************************/



@interface UIView(SMKDebug)
- (void)SMKDebugWithBorderColor:(UIColor *)color borderWidth:(CGFloat)width;
@end

