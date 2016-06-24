//
//  SOLocalCryptoManager.h
//  SOKit
//
//  Created by soso on 15/6/19.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief  定义状态
 */
typedef NS_OPTIONS(NSUInteger, SOLocalCryptoStatu) {
    SOLocalCryptoStatuSuccess       = 0,
    SOLocalCryptoStatuFail
};

/**
 *  @brief  定义回调block
 */
typedef void(^SOLocalCryptoBlock)(SOLocalCryptoStatu statu, NSError *error);


/**
 *  @brief  管理加密、解密的单例
 */
@interface SOLocalCryptoManager : NSObject

/**
 *  @brief  初始化方法
 *
 *  @return 返回自身实例
 */
+ (instancetype)sharedManager;

/**
 *  @brief  更新用于加密、解密的密码
 *
 *  @return 无返回值
 */
- (void)updatePassword:(NSString *)password newPassword:(NSString *)nPassword block:(SOLocalCryptoBlock)block;

/**
 *  @brief  更新用于加密、解密的密码data
 *
 *  @return 无返回值
 */
- (void)updatePassdata:(NSData *)passdata newPassdata:(NSData *)nPassdata block:(SOLocalCryptoBlock)block;

/**
 *  @brief  加密字符串string，默认密码
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)enCryptString:(NSString *)string error:(NSError **)error;

/**
 *  @brief  加密字符串string，密码passwrd
 *
 *  @return 返回加密后的字符串
 */
- (NSString *)enCryptString:(NSString *)string password:(NSString *)password error:(NSError **)error;

/**
 *  @brief  解密字符串string，默认密码
 *
 *  @return 返回解密后的字符串
 */
- (NSString *)deCryptString:(NSString *)string error:(NSError **)error;

/**
 *  @brief  解密字符串string，密码passwrd
 *
 *  @return 返回解密后的字符串
 */
- (NSString *)deCryptString:(NSString *)string password:(NSString *)password error:(NSError **)error;

/**
 *  @brief  加密data，默认密码
 *
 *  @return 返回加密后的data
 */
- (NSData *)enCryptData:(NSData *)data error:(NSError **)error;

/**
 *  @brief  加密data，密码passdata
 *
 *  @return 返回加密后的data
 */
- (NSData *)enCryptData:(NSData *)data passdata:(NSData *)passdata error:(NSError **)error;

/**
 *  @brief  解密data，默认密码
 *
 *  @return 返回解密后的data
 */
- (NSData *)deCryptData:(NSData *)data error:(NSError **)error;

/**
 *  @brief  解密data，密码passdata
 *
 *  @return 返回解密后的data
 */
- (NSData *)deCryptData:(NSData *)data passdata:(NSData *)passdata error:(NSError **)error;

/**
 *  @brief  加密文件路径为fPath的文件并输出到tPath，默认密码
 *
 *  @return 无返回值
 */
- (void)enCryptFileFromPath:(NSString *)fPath toPath:(NSString *)tPath block:(SOLocalCryptoBlock)block;


/**
 *  @brief  加密文件路径为fPath的文件并输出到tPath，密码passdata
 *
 *  @return 无返回值
 */
- (void)enCryptFileFromPath:(NSString *)fPath toPath:(NSString *)tPath passdata:(NSData *)passdata block:(SOLocalCryptoBlock)block;

/**
 *  @brief  解密文件路径为fPath的文件并输出到tPath，默认密码
 *
 *  @return 无返回值
 */
- (void)deCryptFileFromPath:(NSString *)fPath toPath:(NSString *)tPath block:(SOLocalCryptoBlock)block;


/**
 *  @brief  解密文件路径为fPath的文件并输出到tPath，密码passdata
 *
 *  @return 无返回值
 */
- (void)deCryptFileFromPath:(NSString *)fPath toPath:(NSString *)tPath passdata:(NSData *)passdata block:(SOLocalCryptoBlock)block;

@end
