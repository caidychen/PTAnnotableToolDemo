//
//  SOLoadMoreItem.h
//  SOKit
//
//  Created by soso on 15/5/18.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseItem.h"

/**
 *  @brief  是否自动加载更多的key
 */
extern NSString * const _KeyLoadMoreItemAutoLoadMore;

/**
 *  @brief  加载时，是否显示提示的key
 */
extern NSString * const _KeyLoadMoreItemShowActivity;


@interface SOLoadMoreItem : SOBaseItem <NSCopying>

/**
 *  @brief  标题文本
 */
@property (copy, nonatomic) NSString *title;

/**
 *  @brief  标签
 */
@property (assign, nonatomic) NSInteger tag;

/**
 *  @brief  是否自动加载更多
 */
@property (assign, nonatomic, getter=isAutoLoadMore) BOOL autoLoadMore;

/**
 *  @brief  加载时，是否显示提示
 */
@property (assign, nonatomic, getter=isShowActivity) BOOL showActivity;

/**
 *  @brief  类初始化方法
 *
 *  @return 返回自身实例
 */
+ (instancetype)itemWithTitle:(NSString *)title
                          tag:(NSInteger)tag
                 autoLoadMore:(BOOL)autoLoadMore
                 showActivity:(BOOL)showActivity;
@end
