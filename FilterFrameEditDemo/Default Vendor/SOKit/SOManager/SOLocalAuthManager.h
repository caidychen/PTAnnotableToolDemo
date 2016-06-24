//
//  SOLocalAuthManager.h
//  NOETouchIDTest
//
//  Created by soso on 15-1-15.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief  定义本地验证回调block
 *
 *  @return 无返回值
 */
typedef void(^NOELocalAuthCallBackBlock)(BOOL success, NSString *userName, NSString *password);

@interface SOLocalAuthManager : NSObject

/**
 *  @brief  类方法，获得单例对象
 *
 *  @return 反正自身单例
 */
+ (instancetype)shared;

/**
 *  @brief  类方法，获得单例对象
 *
 *  @return 返回自身单例
 */
+ (instancetype)manager;

/**
 *  @brief  get方法
 *
 *  @return 返回所有本地用户名数组
 */
- (NSArray *)allUserNames;

/**
 *  @brief  get方法
 *
 *  @return 返回用户名为username的密码
 */
- (NSString *)passwordWithUserName:(NSString *)username;

/**
 *  @brief  增加本地用户
 *
 *  @return 无返回值
 */
- (void)addUserName:(NSString *)username password:(NSString *)password;

/**
 *  @brief  移除本地用户吗为username的用户
 *
 *  @return 无返回值
 */
- (void)removeUserWithUserName:(NSString *)username;

/**
 *  @brief  批量移除本地用户
 *
 *  @return 无返回值
 */
- (void)removeUsersWithUserNames:(NSArray *)usernames;

/**
 *  @brief  判断是否支持指纹识别
 *
 *  @return 返回bool
 */
- (BOOL)canEvaluateError:(NSError **)error;

/**
 *  @brief  进行指纹识别，回调结果
 *
 *  @return 无返回值
 */
- (void)evaluateWithReason:(NSString *)reason callback:(NOELocalAuthCallBackBlock)block;

@end
