//
//  SOTitleView.h
//  SOKit
//
//  Created by soso on 14-7-7.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseControl.h"

/**
 *  @brief  动画周期
 */
extern NSTimeInterval const SOTitleControlAnimationDuration;


@interface SOTitleControl : SOBaseControl

/**
 *  @brief  是否选中
 */
@property (assign, nonatomic) BOOL didSelected;

/**
 *  @brief  标题标签
 */
@property (strong, nonatomic, readonly) UILabel *titleLabel;

/**
 *  @brief  图片UIImageView
 */
@property (strong, nonatomic, readonly) UIImageView *lastImgView;

/**
 *  @brief  set方法，animation决定是否执行动画
 *
 *  @return 无返回值
 */
- (void)setDidSelected:(BOOL)didSelected animation:(BOOL)animation;

/**
 *  @brief  set方法，设置标签内容
 *
 *  @return 无返回值
 */
- (void)setText:(NSString *)text;

/**
 *  @brief  set方法，设置是否开启，animation决定是否执行动画
 *
 *  @return 无返回值
 */
- (void)setEnabled:(BOOL)enabled animation:(BOOL)animation;

@end
