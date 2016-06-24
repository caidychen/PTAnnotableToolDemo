//
//  SORefreshTableView
//  SlimeRefresh
//
//  Created by soso on 14-8-11.
//  Copyright (c) 2014-2015 soso. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SRRefreshView.h"

@class SORefreshTableView;
/**
 *  @brief  自定义回调block
 */
typedef void (^SORefreshTableViewDidStartRefreshBlock)(SORefreshTableView *resreshTableView);

/**
 *  @brief  带下拉刷新的tableView
 */
@interface SORefreshTableView : UITableView
/**
 *  @brief  下拉指示视图
 */
@property (strong, nonatomic, readonly) SRRefreshView *refreshView;

/**
 *  @brief  回调block
 */
@property (strong, nonatomic) SORefreshTableViewDidStartRefreshBlock startRefreshBlock;

/**
 *  @brief  是否显示下拉视图
 */
@property (nonatomic) BOOL showRefreshView;

//结束下拉刷新，success为YES则显示“刷新成功”，NO显示“刷新失败”

/**
 *  @brief  设定是否刷新成功
 *
 *  @return 无返回值
 */
- (void)endRefreshSuccess:(BOOL)success;

@end
