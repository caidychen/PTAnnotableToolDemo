//
//  SOLoadingView.h
//  SOKit
//
//  Created by soso on 15/6/10.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseView.h"

/**
 *  @brief  动画周期，单位秒
 */
extern NSTimeInterval const SOLoadingViewDuration;

/**
 *  @brief  动画视图大小
 */
extern CGSize SOLoadingSubViewSize;


@interface SOLoadingView : SOBaseView

/**
 *  @brief  动画停止后是否隐藏
 */
@property (assign, nonatomic, getter=isHidesWhenStopped) BOOL hidesWhenStopped;

/**
 *  @brief  所做动画的文字描述
 */
@property (copy, nonatomic, readonly) NSString *text;

/**
 *  @brief  初始化，传入字符串text
 *
 *  @return 返回自身实例
 */
- (instancetype)initWithText:(NSString *)text;

/**
 *  @brief  判断是否正在进行动画
 *
 *  @return 返回BOOL
 */
- (BOOL)isAnimating;

/**
 *  @brief  开始动画
 *
 *  @return 无返回值
 */
- (void)startAnimating;

/**
 *  @brief  结束动画
 *
 *  @return 无返回值
 */
- (void)stopAnimating;

@end
