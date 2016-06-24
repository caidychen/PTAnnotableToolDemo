//
//  UIImage+SOImage.h
//  SOKit
//
//  Created by soso on 14-12-17.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(SOImage)

/**
 *  @brief  初始化方法，创建背景颜色为color，大小为size的图片
 *
 *  @return 返回自身实例
 */
+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  @brief  初始化方法，创建背景颜色为backgroundColor，前景颜色为foregroundColor，路径为path，大小为size，线宽为lineWidth的图片
 *
 *  @return 返回自身实例
 */
+ (instancetype)imageWithBackgroundColor:(UIColor *)backgroundColor
                         foregroundColor:(UIColor *)foregroundColor
                                    path:(CGPathRef)path
                                    size:(CGSize)size
                               lineWidth:(CGFloat)lineWidth;

@end
