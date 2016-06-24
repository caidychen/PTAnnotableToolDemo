//
//  SOIndexView.h
//  SOKit
//
//  Created by soso on 15/5/20.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseView.h"

@class SOIndexView;

/**
 *  @brief  自定义SOIndexViewIndexingBlock，参数为SOIndexView和NSString的key
 *
 *  @return 无返回值
 */
typedef void(^SOIndexViewIndexingBlock)(SOIndexView *view, NSUInteger index, NSString *key);

@interface SOIndexView : SOBaseView

/**
 *  @brief  快速导航的标签，实质是主体
 */
@property (strong, nonatomic, readonly) UILabel *indexLabel;

/**
 *  @brief  关键字数组，成员为NSString的实例
 */
@property (strong, nonatomic) NSArray *titles;

/**
 *  @brief  回调block
 */
@property (copy, nonatomic) SOIndexViewIndexingBlock indexingBlock;

/**
 *  @brief  get方法
 *
 *  @return 返回文本颜色
 */
- (UIColor *)textColor;

/**
 *  @brief  set方法，设置文本颜色
 *
 *  @return 无返回值
 */
- (void)setTextColor:(UIColor *)textColor;

/**
 *  @brief  get方法
 *
 *  @return 返回字体
 */
- (UIFont *)font;

/**
 *  @brief  set方法，设置文本字体
 *
 *  @return 无返回值
 */
- (void)setFont:(UIFont *)font;

@end
