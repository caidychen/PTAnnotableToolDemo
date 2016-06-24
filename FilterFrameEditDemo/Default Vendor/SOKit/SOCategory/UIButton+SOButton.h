//
//  UIButton+SOButton.h
//  SOKit
//
//  Created by soso on 15-05-05.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton(SOButton)

/**
 *  @brief  类初始化方法，默认图片为image
 *
 *  @return 返回自身的实例
 */
+ (instancetype)buttonWithImage:(UIImage *)image;

/**
 *  @brief  类初始化方法，默认图片为nimage。选中图片为sImage
 *
 *  @return 返回自身的实例
 */
+ (instancetype)buttonWithImage:(UIImage *)nImage
                  selectedImage:(UIImage *)sImage;

/**
 *  @brief  类初始化方法，默认图片为nimage，选中图片为sImage，高亮图片为hImage
 *
 *  @return 返回自身的实例
 */
+ (instancetype)buttonWithImage:(UIImage *)nImage
                  selectedImage:(UIImage *)sImage
                hightlightImage:(UIImage *)hImage;

/**
 *  @brief  类初始化方法，默认图片为nimage，选中图片为sImage，高亮图片为hImage，未激活图片为dImage
 *
 *  @return 返回自身的实例
 */
+ (instancetype)buttonWithImage:(UIImage *)nImage
                  selectedImage:(UIImage *)sImage
                 highlightImage:(UIImage *)hImage
                   disableImage:(UIImage *)dImage;

/**
 *  @brief  初始化方法，默认图片为image
 *
 *  @return 返回自身
 */
- (instancetype)initWithImage:(UIImage *)image;

/**
 *  @brief  初始化方法，默认图片为nimage，选中图片为sImage
 *
 *  @return 返回自身
 */
- (instancetype)initWithImage:(UIImage *)nImage
                selectedImage:(UIImage *)sImage;

/**
 *  @brief  初始化方法，默认图片为nimage，选中图片为sImage，高亮图片为hImage
 *
 *  @return 返回自身
 */
- (instancetype)initWithImage:(UIImage *)nImage
                selectedImage:(UIImage *)sImage
              hightlightImage:(UIImage *)hImage;

/**
 *  @brief  初始化方法，默认图片为nimage，选中图片为sImage，高亮图片为hImage，未激活图片为dImage
 *
 *  @return 返回自身
 */
- (instancetype)initWithImage:(UIImage *)nImage
                selectedImage:(UIImage *)sImage
               highlightImage:(UIImage *)hImage
                 disableImage:(UIImage *)dImage;

@end




@interface UIButton (SORotationAnimatiion)

/**
 *  @brief  图片开始旋转
 *
 *  @return 无返回值
 */
- (void)startAnimating;

/**
 *  @brief  图片停止旋转
 *
 *  @return 无返回值
 */
- (void)stopAnimating;

/**
 *  @brief  图片是否正在旋转
 *
 *  @return 返回bool
 */
- (BOOL)isAnimating;

@end

