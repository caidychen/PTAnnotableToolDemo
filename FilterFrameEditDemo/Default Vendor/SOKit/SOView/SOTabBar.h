//
//  SOTabBar.h
//  SOKit
//
//  Created by soso on 15/5/21.
//  Copyright (c) 2015年 com.. All rights reserved.
//


#import "SOBaseItem.h"
#import "SOBaseView.h"
#import "SOBaseControl.h"

@interface SOTabBarItem : SOBaseItem <NSCopying>

/**
 *  @brief  默认图片，本地图片named
 */
@property (copy, nonatomic) NSString *imageName;

/**
 *  @brief  选中时的图片，本地图片named
 */
@property (copy, nonatomic) NSString *selectedImageName;

/**
 *  @brief  默认字体颜色
 */
@property (copy, nonatomic) UIColor *textColor;

/**
 *  @brief  选中时的字体颜色
 */
@property (copy, nonatomic) UIColor *selectedTextColor;

/**
 *  @brief  文本
 */
@property (copy, nonatomic) NSString *text;

/**
 *  @brief  字体
 */
@property (strong, nonatomic) UIFont *font;

/**
 *  @brief  图片大小
 */
@property (assign, nonatomic) CGSize imageSize;

/**
 *  @brief  文本对齐方式
 */
@property (assign, nonatomic) NSTextAlignment textAlignment;

/**
 *  @brief  留边框
 */
@property (assign, nonatomic) UIEdgeInsets insets;

/**
 *  @brief  类初始化方法
 *
 *  @return 返回自身实例
 */
+ (instancetype)itemWithText:(NSString *)text
                       image:(NSString *)image
               selectedImage:(NSString *)selectedImage
                   textColor:(UIColor *)textColor
           selectedTextColor:(UIColor *)selectedTextColor
                   imageSize:(CGSize)imageSize
                        font:(UIFont *)font
                   alignment:(NSTextAlignment)alignment
                      insets:(UIEdgeInsets)insets;
@end



@interface SOTabBarItemView : SOBaseControl
@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (copy, nonatomic) SOTabBarItem *item;
@property (assign, nonatomic, getter=isDidSelected) BOOL didSelected;
@property (assign, nonatomic, getter=isDidHiglighted) BOOL didHighlighted;
@end


@class SOTabBar;
@protocol SOTabBarDelegate <NSObject>
@optional
- (void)SOTabBar:(SOTabBar *)tabBar didSelectItem:(SOTabBarItem *)item;
@end

@interface SOTabBar : SOBaseView {
    __weak id<SOTabBarDelegate>_delegate;
}

/**
 *  @brief  代理，响应委托方法
 */
@property(nonatomic, weak) id<SOTabBarDelegate> delegate;

/**
 *  @brief  get方法
 *
 *  @return 返回所有item
 */
- (NSArray *)items;

/**
 *  @brief  set方法，传入item的数组
 *
 *  @return 无返回值
 */
- (void)setItems:(NSArray *)items;

/**
 *  @brief  get方法
 *
 *  @return 返回选中的index
 */
- (NSUInteger)selectedIndex;

/**
 *  @brief  get方法
 *
 *  @return 返回索引为index的itemView
 */
- (SOTabBarItemView *)tabBarItemViewAtIndex:(NSUInteger)index;

/**
 *  @brief  set方法，设置选中的index
 *
 *  @return 无返回值
 */
- (void)setSelectedIndex:(NSUInteger)selectedIndex;

/**
 *  @brief  get方法
 *
 *  @return 返回背景图片
 */
- (UIImage *)backgroundImage;

/**
 *  @brief  set方法，设置背景图片
 *
 *  @return 无返回值
 */
- (void)setBackgroundImage:(UIImage *)backgroundImage;

/**
 *  @brief  get方法
 *
 *  @return 返回选中的item
 */
- (SOTabBarItem *)selectedItem;

@end
