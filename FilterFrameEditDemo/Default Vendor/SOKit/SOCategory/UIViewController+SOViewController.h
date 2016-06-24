//
//  UIViewController+SOViewController.h
//  SOKit
//
//  Created by soso on 14-12-18.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIKit.h>


/*
 * @brief 扩展了对当前控制器中的 导航栏的功能
 */
@interface UIViewController(SOViewController)

/**
 *  @brief  退出当前视图控制器
 *
 *  @return 无返回值
 */
- (void)dismissAnimation:(BOOL)animation;

/**
 *  @brief  设置导航栏左边的item
 *
 *  @return 无返回值
 */
- (UIButton *)showLeftItemWithText:(NSString *)text
                             color:(UIColor *)color
                              font:(UIFont *)font
                          selector:(SEL)selector
                         animation:(BOOL)animation;

- (UIButton *)showLeftItemWithImage:(UIImage *)image
                           selector:(SEL)selector
                          animation:(BOOL)animation;

- (UIButton *)showLeftItemWithImage:(UIImage *)image
                               size:(CGSize)size
                           selector:(SEL)selector
                          animation:(BOOL)animation
                    isMasksToBounds:(BOOL) masksToBounds;


/**
 *  @brief  隐藏导航栏左边的item
 *
 *  @return 无返回值
 */
- (void)hideLeftItemAnimation:(BOOL)animation;

/**
 *  @brief  设置导航栏右边的item
 *
 *  @return 无返回值
 */
- (UIButton *)showRightItemWithText:(NSString *)text
                              color:(UIColor *)color
                               font:(UIFont *)font
                           selector:(SEL)selector
                          animation:(BOOL)animation;

- (UIButton *)showRightItemWithImage:(UIImage *)image
                            selector:(SEL)selector
                           animation:(BOOL)animation;

- (UIButton *)showRightItemWithImage:(UIImage *)image
                                size:(CGSize)size
                            selector:(SEL)selector
                           animation:(BOOL)animation;


/**
 *  @brief  隐藏导航栏的item
 *
 *  @return 无返回值
 */
- (void)hideRightItemAnimation:(BOOL)animation;

/**
 *  @brief  设置标题
 *
 *  @return 无返回值
 */
- (UIButton *)setTitle:(NSString *)title
                 color:(UIColor *)color
                  font:(UIFont *)font
              selector:(SEL)selector;

- (UIButton *)setTitleImage:(UIImage *)image
                   selector:(SEL)selector;

/**
 *  @brief  去掉标题图片
 *
 *  @return 无返回值
 */
- (void)removeTitleImage;


/**
 * @brief 动态调整导航栏颜色及透明度
 * 传递参数如: UIColor * color = [UIColor colorWithRed:(190/255.0) green:(218/255.0) blue:(218/255) alpha:1.0f];
 */
- (void)setNavigationBarWithColor:(UIColor *)color;
/**
 * @brief 还原导航栏
 */
- (void)recoverNavigationBar;

@end
