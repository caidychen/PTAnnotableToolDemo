//
//  SOSegmentControlItem.h
//  SOKit
//
//  Created by soso on 13-2-21.
//  Copyright (c) 2013-2015 soso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOBaseItem.h"

/**
 *  @brief  分段选项的item
 */
@interface SOSegmentControlItem : SOBaseItem <NSCopying>
/**
 *  @brief  标题
 */
@property (copy, nonatomic) NSString *text;

/**
 *  @brief  文本字体
 */
@property (strong, nonatomic) UIFont *font;

/**
 *  @brief  高亮文本字体
 */
@property (strong, nonatomic) UIFont *highlightedFont;

/**
 *  @brief  默认文本颜色
 */
@property (strong, nonatomic) UIColor *textColor;

/**
 *  @brief  高亮文本颜色
 */
@property (strong, nonatomic) UIColor *highlightedTextColor;

/**
 *  @brief  默认图片
 */
@property (strong, nonatomic) UIImage *image;

/**
 *  @brief  高亮图片
 */
@property (strong, nonatomic) UIImage *highlightedImage;

/**
 *  @brief  边框
 */
@property (assign, nonatomic) UIEdgeInsets titleEdgeInset;


/**
 *  @brief  一些初始化方法
 *
 *  @return 返回自身实例
 */
+ (instancetype)itemWithText:(NSString *)text
                       image:(UIImage *)image;

+ (instancetype)itemWithText:(NSString *)text
                       image:(UIImage *)image
                 titleInsets:(UIEdgeInsets)titleInsets;

+ (instancetype)itemWithText:(NSString *)text
                        font:(UIFont *)font
                       image:(UIImage *)image
                 titleInsets:(UIEdgeInsets)titleInsets;

+ (instancetype)itemWithText:(NSString *)text
                   textColor:(UIColor *)textColor
                        font:(UIFont *)font
                       image:(UIImage *)image
                 titleInsets:(UIEdgeInsets)titleInsets;

+ (instancetype)itemWithText:(NSString *)text
                   textColor:(UIColor *)textColor
        highlightedTextColor:(UIColor *)highlightedTextColor
                        font:(UIFont *)font
             highlightedFont:(UIFont *)highlightedFont
                       image:(UIImage *)image
                 titleInsets:(UIEdgeInsets)titleInsets;

+ (instancetype)itemWithText:(NSString *)text
                   textColor:(UIColor *)textColor
        highlightedTextColor:(UIColor *)highlightedTextColor
                        font:(UIFont *)font
             highlightedFont:(UIFont *)highlightedFont
                       image:(UIImage *)image
            highlightedImage:(UIImage *)highlightedImage
                 titleInsets:(UIEdgeInsets)titleInsets;


@end
