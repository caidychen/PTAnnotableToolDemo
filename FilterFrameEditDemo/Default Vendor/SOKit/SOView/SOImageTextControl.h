//
//  SOImageTextControl.h
//  SOKit
//
//  Created by soso on 15/6/5.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseControl.h"

typedef NS_OPTIONS(NSUInteger, SOImagePosition) {
    SOImagePositionTop      = 0,    //图片在上
    SOImagePositionBottom,          //图片在下
    SOImagePositionLeft,            //图片在左
    SOImagePositionRight,           //图片在右
    
    SOImagePositionBothRight,       // 整体居右
    SOImagePositionHorizontalBothCenter,    // 整体水平居中
    SOImagePositionVerticalBothCenter       // 整体竖直居中
};

@interface SOImageTextControl : SOBaseControl

/**
 *  @brief  内容视图
 */
@property (strong, nonatomic, readonly) UIView *contentView;

/**
 *  @brief  文本标签
 */
@property (strong, nonatomic, readonly) UILabel *textLabel;

/**
 *  @brief  图片视图
 */
@property (strong, nonatomic, readonly) UIImageView *imageView;

/**
 *  @brief  图片大小
 */
@property (assign, nonatomic) CGSize imageSize;

/**
 *  @brief  图片与文字的间距
 */
@property (assign, nonatomic) CGFloat imageAndTextSpace;

/**
 *  @brief  排列和对齐方式
 */
@property (assign, nonatomic) SOImagePosition imagePosition;

@end
