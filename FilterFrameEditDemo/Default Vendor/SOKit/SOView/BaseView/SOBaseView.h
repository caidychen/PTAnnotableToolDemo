//
//  SOBaseView.h
//  SOKit
//
//  Created by soso on 15/5/5.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+Additions.h"

@interface SOBaseView : UIView {
    UIEdgeInsets _contentInsets;
    CGFloat _verticalSpace;
    CGFloat _horizontalSpace;
}

/**
 *  @brief  四周留的边框
 */
@property (assign, nonatomic) UIEdgeInsets contentInsets;

/**
 *  @brief  竖直方向的间距
 */
@property (assign, nonatomic) CGFloat verticalSpace;

/**
 *  @brief  水平方向的间距
 */
@property (assign, nonatomic) CGFloat horizontalSpace;

@end
