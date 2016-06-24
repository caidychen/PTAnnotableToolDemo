//
//  UITableView+SOAdditions.h
//  SOKit
//
//  Created by soso on 15/5/20.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Additions)

/**
 *  @brief  通过设置footerView为nil来去掉系统自动添加的横线
 *
 *  @return 无返回值
 */
- (void)clearExtendCellLine;

@end
