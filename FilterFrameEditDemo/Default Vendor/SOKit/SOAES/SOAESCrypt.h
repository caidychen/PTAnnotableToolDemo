//
//  SOAESCrypt.h
//  SOKit
//
//  Created by soso on 15/6/18.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  @brief  以密码password加密字符串message
 *
 *  @return 返回加密后的字符串
 */
NSString * SOAESEncrypt(NSString *message, NSString *password, NSError **error);

/**
 *  @brief  以密码password解密base64字符串base64EncodedString
 *
 *  @return 返回解密后的字符串
 */
NSString * SOAESDecrypt(NSString *base64EncodedString, NSString *password, NSError **error);

/**
 *  @brief  以密码passdata加密data
 *
 *  @return 返回加密后的data
 */
NSData * SOAESEncryptData(NSData *data, NSData *passdata, NSError **error);

/**
 *  @brief  以密码passdata解密data
 *
 *  @return 返回解密后的data
 */
NSData * SOAESDecryptData(NSData *data, NSData *passdata, NSError **error);

