//
//  SODropBox.h
//  SOKitDemo
//
//  Created by soso on 15/6/25.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SOBaseView.h"

/**
 *  @brief  动画周期
 */
extern NSTimeInterval const SODropAnimationDuration;

@class SODropBox;
/**
 *  @brief  资源回调协议
 */
@protocol SODropBoxControlDataSource <NSObject>
@optional
/**
 *  @brief  资源回调
 *
 *  @return 返回section数量
 */
- (NSInteger)dropBox:(SODropBox *)dropBox numberOfSectionsInTableView:(UITableView *)tableView;
@required
/**
 *  @brief  资源回调
 *
 *  @return 返回row数量
 */
- (NSInteger)dropBox:(SODropBox *)dropBox tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 *  @brief  资源回调
 *
 *  @return 返回cell
 */
- (UITableViewCell *)dropBox:(SODropBox *)dropBox tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

/**
 *  @brief  响应回调协议
 */
@protocol SODropBoxControlDelegate <NSObject>
@optional
/**
 *  @brief  响应回调方法
 *
 *  @return 返回cell高度
 */
- (CGFloat)dropBox:(SODropBox *)dropBox tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  @brief  响应回调方法
 *
 *  @return 返回header高度
 */
- (CGFloat)dropBox:(SODropBox *)dropBox tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

/**
 *  @brief  响应回调方法
 *
 *  @return 返回footer高度
 */
- (CGFloat)dropBox:(SODropBox *)dropBox tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

/**
 *  @brief  响应回调方法
 *
 *  @return 返回header view
 */
- (UIView *)dropBox:(SODropBox *)dropBox tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

/**
 *  @brief  响应回调方法
 *
 *  @return 返回footer view
 */
- (UIView *)dropBox:(SODropBox *)dropBox tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

/**
 *  @brief  选中cell时响应
 *
 *  @return 无返回值
 */
- (void)dropBox:(SODropBox *)dropBox tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  @brief  取消选中cell的响应
 *
 *  @return 无返回值
 */
- (void)dropBox:(SODropBox *)dropBox tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath;
@end


/**
 *  @brief  下拉框
 */
@interface SODropBox : SOBaseView {
    __weak id<SODropBoxControlDataSource>_dataSource;
    __weak id<SODropBoxControlDelegate>_delegate;
}
/**
 *  @brief  资源回调对象
 */
@property (weak, nonatomic) id<SODropBoxControlDataSource>dataSource;

/**
 *  @brief  响应回调对象
 */
@property (weak, nonatomic) id<SODropBoxControlDelegate>delegate;

/**
 *  @brief  下拉框大小
 */
@property (assign, nonatomic) CGSize dropSize;

/**
 *  @brief  get方法
 *
 *  @return 返回是否已显示
 */
- (BOOL)isShow;

/**
 *  @brief  下拉框显示在view中的frame处
 *
 *  @return 无返回值
 */
- (void)showInView:(UIView *)view frame:(CGRect)frame animated:(BOOL)animated;

/**
 *  @brief  隐藏下拉框
 *
 *  @return 无返回值
 */
- (void)hideAnimate:(BOOL)animated;

/**
 *  @brief  选中方法
 *
 *  @return 无返回值
 */
- (void)setSelectIndexPath:(NSIndexPath *)selectIndexPath animated:(BOOL)animated;

/**
 *  @brief  get方法
 *
 *  @return 返回选中的indexPath
 */
- (NSIndexPath *)selectIndexPath;

/**
 *  @brief  刷新下拉框
 *
 *  @return 无返回值
 */
- (void)reloadData;

@end
