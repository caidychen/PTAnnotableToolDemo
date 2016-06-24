//
//  UIView+Addition.m
//  SOKit
//
//  Created by Carl on 15/5/7.
//  Copyright (c) 2015年 Carl. All rights reserved.
//

#import "UIView+Additions.h"
#import <objc/runtime.h>
#import "SOGlobal.h"
#import "NSString+SOAdditions.h"

@implementation UIView(Additions)

///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)left {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)top {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)x {
    return self.frame.origin.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)y {
    return self.frame.origin.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setY:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerX {
    return self.center.x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)centerY {
    return self.center.y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)width {
    return self.frame.size.width;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)height {
    return self.frame.size.height;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)ttScreenY {
    CGFloat y = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewX {
    CGFloat x = 0.0f;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGPoint)origin {
    return self.frame.origin;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGSize)size {
    return self.frame.size;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)removeAllSubviews {
    while (self.subviews.count) {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

@end
/************************************************************************/




@implementation UIView(Animation)

#pragma mark - Moves

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option {
    [self moveTo:destination duration:secs option:option delegate:nil callback:nil];
}

- (void)moveTo:(CGPoint)destination duration:(float)secs option:(UIViewAnimationOptions)option delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs delay:0.0 options:option
                     animations:^{
                         self.frame = CGRectMake(destination.x,destination.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             SOSafePerformSelector(delegate, method, nil);
                         }
                     }];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack {
    [self raceTo:destination withSnapBack:withSnapBack delegate:nil callback:nil];
}

- (void)raceTo:(CGPoint)destination withSnapBack:(BOOL)withSnapBack delegate:(id)delegate callback:(SEL)method {
    CGPoint stopPoint = destination;
    if (withSnapBack) {
        // Determine our stop point, from which we will "snap back" to the final destination
        int diffx = destination.x - self.frame.origin.x;
        int diffy = destination.y - self.frame.origin.y;
        if (diffx < 0) {
            // Destination is to the left of current position
            stopPoint.x -= 10.0;
        } else if (diffx > 0) {
            stopPoint.x += 10.0;
        }
        if (diffy < 0) {
            // Destination is to the left of current position
            stopPoint.y -= 10.0;
        } else if (diffy > 0) {
            stopPoint.y += 10.0;
        }
    }
    
    // Do the animation
    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         self.frame = CGRectMake(stopPoint.x, stopPoint.y, self.frame.size.width, self.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         if (withSnapBack) {
                             [UIView animateWithDuration:0.1
                                                   delay:0.0
                                                 options:UIViewAnimationOptionCurveLinear
                                              animations:^{
                                                  self.frame = CGRectMake(destination.x, destination.y, self.frame.size.width, self.frame.size.height);
                                              }
                                              completion:^(BOOL finished) {
                                                  SOSafePerformSelector(delegate, method, nil);
                                                  
                                              }];
                         } else {
                             SOSafePerformSelector(delegate, method, nil);
                             
                         }
                     }];
}


#pragma mark - Transforms

- (void)rotate:(int)degrees secs:(float)secs delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radianToDegrees(degrees));
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             SOSafePerformSelector(delegate, method, nil);
                             
                         }
                     }];
}

- (void)scale:(float)secs x:(float)scaleX y:(float)scaleY delegate:(id)delegate callback:(SEL)method {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformScale(self.transform, scaleX, scaleY);
                     }
                     completion:^(BOOL finished) {
                         if (delegate != nil) {
                             SOSafePerformSelector(delegate, method, nil);
                         }
                     }];
}

- (void)spinClockwise:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radianToDegrees(90));
                     }
                     completion:^(BOOL finished) {
                         [self spinClockwise:secs];
                     }];
}

- (void)spinCounterClockwise:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.transform = CGAffineTransformRotate(self.transform, radianToDegrees(270));
                     }
                     completion:^(BOOL finished) {
                         [self spinCounterClockwise:secs];
                     }];
}


#pragma mark - Transitions

- (void)curlDown:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlDown
                    animations:^ { [self setAlpha:1.0]; }
                    completion:nil];
}

- (void)curlUpAndAway:(float)secs {
    [UIView transitionWithView:self duration:secs
                       options:UIViewAnimationOptionTransitionCurlUp
                    animations:^ { [self setAlpha:0]; }
                    completion:nil];
}

- (void)drainAway:(float)secs {
    self.tag = 20;
    /*NSTimer *timer = */[NSTimer scheduledTimerWithTimeInterval:secs/50 target:self selector:@selector(drainTimer:) userInfo:nil repeats:YES];
}

- (void)drainTimer:(NSTimer*)timer {
    CGAffineTransform trans = CGAffineTransformRotate(CGAffineTransformScale(self.transform, 0.9, 0.9),0.314);
    self.transform = trans;
    self.alpha = self.alpha * 0.98;
    self.tag = self.tag - 1;
    if (self.tag <= 0) {
        [timer invalidate];
        timer = nil;
        [self removeFromSuperview];
    }
}

#pragma mark - Effects

- (void)changeAlpha:(float)newAlpha secs:(float)secs {
    [UIView animateWithDuration:secs
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.alpha = newAlpha;
                     }
                     completion:nil];
}

- (void)pulse:(float)secs continuously:(BOOL)continuously {
    [UIView animateWithDuration:secs/2
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         // Fade out, but not completely
                         self.alpha = 0.3;
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:secs/2
                                               delay:0.0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              // Fade in
                                              self.alpha = 1.0;
                                          }
                                          completion:^(BOOL finished) {
                                              if (continuously) {
                                                  [self pulse:secs continuously:continuously];
                                              }
                                          }];
                     }];
}

@end
/************************************************************************/



CGFloat const SODataStateDefaultHeight    = 66.0f;

static NSString * const _KeySONowScoreDataFont;
static NSString * const _KeySONowScoreDataState;
static NSString * const _KeySONowScoreDataWaring;
static NSString * const _KeySONowScoreDataImage;
static NSString * const _KeySONowScoreDataWaringLabel;
static NSString * const _KeySONowScoreDataImageView;
static NSString * const _KeySONowScoreDataImageSizeOffset;

static NSString * const _KeySONowScoreDataLoadingView;
static NSString * const _KeySONowScoreDataLoadingViewColor;

static NSString * const SONowScoreDataPositionKey;

static NSString * const SONowScoreDataDefaultWaringText = @"暂无数据";

static CGFloat  const SONowScoreDataDefaultImageSizeOffset = 0.6f;

@implementation UIView(DataState)

//+ (void)load {
//    Method m1 = class_getInstanceMethod([self class], @selector(layoutSubviews));
//    Method m2 = class_getInstanceMethod([self class], @selector(SOStateViewLayoutSubviews));
//    method_exchangeImplementations(m1, m2);
//}

- (CGPoint)dataStatePosition {
    id p = objc_getAssociatedObject(self, &SONowScoreDataPositionKey);
    if(p) {
        return ([p CGPointValue]);
    }
    return (CGPointMake(0.5f, 0.5f));
}

- (void)setDataStatePosition:(CGPoint)position {
    objc_setAssociatedObject(self, &SONowScoreDataPositionKey, [NSValue valueWithCGPoint:position], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self SONowScoreDataViewRefresh];
}

- (CGFloat)dataStateImageContentOffset {
    id obj_offset = objc_getAssociatedObject(self, &_KeySONowScoreDataImageSizeOffset);
    return (obj_offset ? [obj_offset floatValue] : SONowScoreDataDefaultImageSizeOffset);
}

- (void)setDataStateImageContentOffset:(CGFloat)offset {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataImageSizeOffset,
                             @(offset),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)dataStateWaringFont {
    UIFont *font = objc_getAssociatedObject(self, &_KeySONowScoreDataFont);
    return (font ? font : [UIFont systemFontOfSize:12]);
}

- (void)setDataStateWaringFont:(UIFont *)font {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataFont,
                             font,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)dataStateWaring {
    NSString *t = objc_getAssociatedObject(self, &_KeySONowScoreDataWaring);
    return (t ? t : SONowScoreDataDefaultWaringText);
}

- (void)setDataStateWaring:(NSString *)waring {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataWaring,
                             waring,
                             OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self SONowScoreDataViewDataRefresh];
}

- (UIImage *)dataStateWaringImage {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataImage));
}

- (void)setDataStateWaringImage:(UIImage *)image {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataImage,
                             image,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self SONowScoreDataViewDataRefresh];
}

- (UIColor *)dataStateLoadingViewColor {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataLoadingViewColor));
}

- (void)setDataStateLoadingViewColor:(UIColor *)color {
    if(!color) {
        color = [UIColor lightGrayColor];
    }
    if([self dataStateLoadingView]) {
        [[self dataStateLoadingView] setColor:color];
    }
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataLoadingViewColor,
                             color,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIActivityIndicatorView *)dataStateLoadingView {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataLoadingView));
}

- (void)setDataStateLoadingView:(UIActivityIndicatorView *)loadingView {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataLoadingView,
                             loadingView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (SOViewDataState)dataState {
    id obj_state = objc_getAssociatedObject(self, &_KeySONowScoreDataState);
    if(!obj_state) {
        return (SOViewDataStateNormal);
    }
    return ((SOViewDataState)[obj_state unsignedIntegerValue]);
}

- (void)setDataState:(SOViewDataState)dataState {
    objc_setAssociatedObject(self,
                             &_KeySONowScoreDataState,
                             @(dataState),
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self SONowScoreDataViewRefresh];
}

- (UILabel *)waringLabel {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataWaringLabel));
}

- (UIImageView *)waringImageView {
    return (objc_getAssociatedObject(self, &_KeySONowScoreDataImageView));
}

- (void)SONowScoreDataViewDataRefresh {
    SOViewDataState state = [self dataState];
    if(SOViewDataStateNoData == state) {
        [self SONowScoreDataViewRefresh];
    }
}

- (void)SONowScoreDataViewRefresh {
    SOViewDataState state = [self dataState];
    UILabel *label = [self waringLabel];
    UIImageView *imageView = [self waringImageView];
    UIActivityIndicatorView *loadingView = [self dataStateLoadingView];
    
    switch (state) {
        case SOViewDataStateNormal: {
            if(label) {
                if([label superview]) {
                    [label removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataWaringLabel,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                label = nil;
            }
            if(imageView) {
                if([imageView superview]) {
                    [imageView removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataImageView,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                imageView = nil;
            }
            if(loadingView) {
                [loadingView stopAnimating];
                if([loadingView superview]) {
                    [loadingView removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataLoadingView,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                loadingView = nil;
            }
        }break;
            
        case SOViewDataStateNoData: {
            if(loadingView) {
                [loadingView stopAnimating];
                if([loadingView superview]) {
                    [loadingView removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataLoadingView,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                loadingView = nil;
            }
            
            if(!label) {
                label = [[UILabel alloc] init];
                label.backgroundColor = [UIColor clearColor];
                label.textColor = [UIColor grayColor];
                label.textAlignment = NSTextAlignmentCenter;
                [self addSubview:label];
                [self bringSubviewToFront:label];
                //[label release];
                
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataWaringLabel,
                                         label,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            
            if(!imageView) {
                imageView = [[UIImageView alloc] init];
                imageView.backgroundColor = [UIColor clearColor];
                [self addSubview:imageView];
                [self bringSubviewToFront:imageView];
                //[imageView release];
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataImageView,
                                         imageView,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            NSString *text = [self dataStateWaring];
            UIImage *image = [self dataStateWaringImage];
            
            label.font = [self dataStateWaringFont];
            label.text = text;
            imageView.image = image;
            
            CGSize boundSize = self.bounds.size;
            CGSize textSize = [text soSizeWithFont:label.font constrainedToSize:boundSize lineBreakMode:label.lineBreakMode];
            
            CGSize imageSize = CGSizeMake(CGImageGetWidth(image.CGImage), CGImageGetHeight(image.CGImage));
            if(imageSize.width <= 0) {
                imageSize.width = 1.0f;
            }
            if(imageSize.height <= 0) {
                imageSize.height = 1.0f;
            }
            
            //限制图片大小
            CGFloat iw = MAX(1.0f, MIN(imageSize.width, boundSize.width * [self dataStateImageContentOffset]));
            CGFloat ih = imageSize.height * iw / imageSize.width;
            imageSize = CGSizeMake(iw, ih);
            ih = MIN(imageSize.height, boundSize.height * [self dataStateImageContentOffset]);
            iw = imageSize.width * ih / imageSize.height;
            imageSize = CGSizeMake(iw, ih);
            
            if(!text || [text length] == 0) {
                imageView.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
                imageView.center = CGPointMake(boundSize.width * [self dataStatePosition].x, boundSize.height * [self dataStatePosition].y);
                return;
            }
            if(!image) {
                //                label.frame = self.bounds;
                label.frame = CGRectMake(0, 0, SOScreenSize().width, self.bounds.size.height);
                return;
            }
            
            CGFloat space = 7.0f;
            CGPoint total_center = CGPointMake(boundSize.width * [self dataStatePosition].x, boundSize.height * [self dataStatePosition].y);
            CGFloat total_height = textSize.height + imageSize.height + space;
            imageView.frame = CGRectMake(0, total_center.y - total_height / 2.0f, imageSize.width, imageSize.height);
            label.frame = CGRectMake((boundSize.width - textSize.width) / 2.0f, CGRectGetMaxY(imageView.frame) + space, textSize.width, textSize.height);
            imageView.centerX = label.centerX = total_center.x;
        }break;
            
        case SOViewDataStateLoading: {
            if(label) {
                if([label superview]) {
                    [label removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataWaringLabel,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                label = nil;
            }
            if(imageView) {
                if([imageView superview]) {
                    [imageView removeFromSuperview];
                }
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataImageView,
                                         nil,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                imageView = nil;
            }
            if(!loadingView) {
                loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                if([self dataStateLoadingViewColor]) {
                    loadingView.color = [self dataStateLoadingViewColor];
                }
                [self addSubview:loadingView];
                [self bringSubviewToFront:loadingView];
                //[loadingView release];
                objc_setAssociatedObject(self,
                                         &_KeySONowScoreDataLoadingView,
                                         loadingView,
                                         OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            loadingView.center = CGPointMake(CGRectGetWidth(self.bounds) * [self dataStatePosition].x, CGRectGetHeight(self.bounds) * [self dataStatePosition].y);
            [loadingView startAnimating];
        }break;
            
        default: break;
    }
}

- (void)SOStateViewLayoutSubviews {
    [self SONowScoreDataViewRefresh];
}

@end
/************************************************************************/






@implementation UIView(SMKDebug)
- (void)SMKDebugWithBorderColor:(UIColor *)color borderWidth:(CGFloat)width {
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = width;
}
@end