//
//  UIColor+SOColor.h
//  SOKit
//
//  Created by soso on 14-12-19.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @brief  颜色分量结构体（red、green、blue、alpha）
 */
typedef struct _SOColorComponents SOColorComponents;
struct _SOColorComponents {
    CGFloat r;
    CGFloat g;
    CGFloat b;
    CGFloat a;
};

/**
 *  @brief  零值分量
 */
extern SOColorComponents const SOColorComponentsZero;

/**
 *  @brief  传入分量r、g、b、a构造颜色分量
 *
 *  @return 返回颜色分量
 */
SOColorComponents SOColorComponentsMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a);

/**
 *  @brief  从UIColor构造颜色分量
 *
 *  @return 返回颜色分量
 */
SOColorComponents SOColorComponentsWithUIColor(UIColor *color);

/**
 *  @brief  从CGColorRef构造颜色分量
 *
 *  @return 返回颜色分量
 */
SOColorComponents SOColorComponentsWithCGColor(CGColorRef color);

/**
 *  @brief  从颜色分量构造CGColorRef
 *
 *  @return 返回CGColorRef
 */
CGColorRef CGColorWithColorComponents(SOColorComponents components);

/**
 *  @brief  从颜色分量构造UIColor
 *
 *  @return 返回UIColor
 */
UIColor * UIColorWithColorComponents(SOColorComponents components);


@interface UIColor(SOColor)

/**
 *  @brief  get方法
 *
 *  @return 返回随机颜色值
 */
+ (UIColor *)randomColor;

/**
 *  @brief  get方法
 *
 *  @return 返回透明度为alpha的随机颜色值
 */
+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha;

/**
 *  @brief  get方法
 *
 *  @return 返回颜色空间model
 */
- (CGColorSpaceModel)colorSpaceModel;

/**
 *  @brief  get方法
 *
 *  @return 返回red分量
 */
- (CGFloat)red;

/**
 *  @brief  get方法
 *
 *  @return 返回green分量
 */
- (CGFloat)green;

/**
 *  @brief  get方法
 *
 *  @return 返回blue分量
 */
- (CGFloat)blue;

/**
 *  @brief  get方法
 *
 *  @return 返回alpha分量
 */
- (CGFloat)alpha;

/**
 *  @brief  get方法
 *
 *  @return 返回当前颜色选中后的颜色，各分量<0.5则减到0.9，否则加到1.1，alpha值不变
 */
- (UIColor *)selectedColor;

/**
 *  @brief  get方法
 *
 *  @return 返回当前颜色选中的颜色，alpha值减为0.5
 */
- (UIColor *)highlightColor;

/**
 *  @brief  get方法
 *
 *  @return 返回当前颜色未激活的颜色，alpha值减为0.3
 */
- (UIColor *)disableColor;

/**
 *  @brief  get方法
 *
 *  @return 返回当前颜色的反色，各分量的负值同1.0做加法，包括alpha值
 */
- (UIColor *)invertColor;

/**
 *  @brief  get方法
 *
 *  @return 返回自身到color的进度为progress过渡颜色
 */
- (UIColor *)colorToColor:(UIColor *)color progress:(double)progress;

+ (UIColor *) colorWithHexString: (NSString *) hexString;

@end
