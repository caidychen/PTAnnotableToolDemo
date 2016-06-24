//
//  SOBaseViewController.h
//  SOKit
//
//  Created by soso on 14-12-17.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+SOViewController.h"

/**
 *  @brief  实例化viewControllerClass，并传递参数parameters，然后跳转对应视图控制器
 *  ######  使用此方法的类viewControllerClass必须实现SOViewControllerProtocol协议
 *
 *  @return 无返回值
 */
void SOJumpViewController(Class viewControllerClass, NSDictionary *parameters, BOOL animated);

/**
 *  @brief  基础类如果需要直接传递参数，就需要实现此协议
 */
@protocol SOViewControllerProtocol <NSObject>
@optional
/**
 *  @brief  类初始化方法
 *
 *  @return 返回自身实例
 */
+ (instancetype)viewControllerWithParameters:(id)parameters;

/**
 *  @brief  初始化方法
 *
 *  @return 返回自身实例
 */
- (instancetype)initWithParameters:(id)parameters;

/**
 *  @brief  set方法，设置参数
 *
 *  @return 无返回值
 */
- (void)setParameters:(id)parameters;
@end



/**
 *  @brief  定义基础视图控制器类
 */
@interface SOBaseViewController : UIViewController <SOViewControllerProtocol>
/**
 *  @brief  初始化方法，从和自身类名相同的xib文件加载布局
 *
 *  @return 返回自身实例
 */
- (instancetype)initWithSelfClassNameNib;

/**
 *  @brief  关闭从iOS7.0开始系统对scrollView布局所作的自动调整
 *
 *  @return 无返回值
 */
- (void)disableAdjustsScrollView;

/**
 *  @brief  清除从iOS7.0开始系统对布局所作的一些自动调整
 *
 *  @return 无返回值
 */
- (void)cleanEdgesForExtendedLayout;

@end
