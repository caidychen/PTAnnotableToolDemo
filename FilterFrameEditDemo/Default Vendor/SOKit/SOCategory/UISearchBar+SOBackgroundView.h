//
//  UISearchBar+SOBackgroundView.h
//  SOKit
//
//  Created by soso on 15/5/18.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISearchBar(SOBackgroundView)

/**
 *  @brief  get方法，取得背景视图
 *
 *  @return 返回背景视图，未找到则返回nil
 */
- (UIView *)searchBackgroundView;

/**
 *  @brief  get方法，取得输入框视图
 *
 *  @return 返回输入框，未找到则返回nil
 */
- (UIView *)searchTextFieldView;

@end
