//
//  SOSegmentButton.h
//  SOKit
//
//  Created by soso on 13-2-21.
//  Copyright (c) 2013-2015 soso. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOBaseControl.h"
#import "SOSegmentControlItem.h"

/**
 *  @brief  分段选项按钮
 */
@interface SOSegmentButton : SOBaseControl
/**
 *  @brief  自定义高亮
 */
@property (assign, nonatomic, getter=isDidHighlighted) BOOL didHighlighted;

/**
 *  @brief  标题标签
 */
@property (strong, nonatomic, readonly) UILabel *titleLabel;

/**
 *  @brief  图片视图
 */
@property (strong, nonatomic, readonly) UIImageView *imageView;

/**
 *  @brief  按钮的item
 */
@property (nonatomic, strong) SOSegmentControlItem *item;

@end
