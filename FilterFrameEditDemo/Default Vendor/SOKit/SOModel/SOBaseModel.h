//
//  SOBaseModel.h
//  SOKit
//
//  Created by soso on 15/5/15.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOGlobal.h"

/**
 *  @brief  数据状态体的key
 */
#define KEY_SODEFAULT_RESPONSE_RESP     @"resp"

/**
 *  @brief  数据状态码的key
 */
#define KEY_SODEFAULT_RESPONSE_CODE     @"http_code"

/**
 *  @brief  数据状态描述的key
 */
#define KEY_SODEFAULT_RESPONSE_DESC     @"desc"

#define KEY_SMKDFAULT_ACCESSTOKEN       @"accesstoken"

#define KEY_PTDEFAULT_STATUS            @"http_code"

#define KEY_PTDEFAULT_DATA              @"data"


@class SOBaseModel;
/**
 *  @brief  model的委托协议
 */
@protocol SOModelDelegate <NSObject>
@optional

/**
 *  @brief  model开始请求的回调
 *
 *  @return 无返回值
 */
- (void)model:(SOBaseModel *)model didStartRequest:(id)info;

/**
 *  @brief  model接收到返回值的回调
 *
 *  @return 无返回值
 */
- (void)model:(SOBaseModel *)model didReceivedData:(id)data userInfo:(id)info;

/**
 *  @brief  model请求失败的回调
 *
 *  @return 无返回值
 */
- (void)model:(SOBaseModel *)model didFailedInfo:(id)info error:(id)error;

/**
 *  @brief  model请求被取消的回调
 *
 *  @return 无返回值
 */
- (void)model:(SOBaseModel *)model didCanceled:(id)info;

/**
 *  @brief  model请求结果发生变化时的回调
 *
 *  @return 无返回值
 */
- (void)modelDidChanged:(SOBaseModel *)model;
@end


/**
 *  @brief  SOBaseModel需要遵循的协议
 */
@protocol SOBaseModelProtocol <NSObject>
@property (weak, nonatomic) id <SOModelDelegate>delegate;
@required

/**
 *  @brief  model遵循的协议，取消所有正在进行的请求
 *
 *  @return 无返回值
 */
- (void)cancelAllRequest;
@end


/**
 *  @brief  SOBaseModel需要遵循的缓存协议
 */
@protocol SOBaseModelCacheProtocol <NSObject>
@optional
/**
 *  @brief  get方法
 *
 *  @return 返回缓存对象
 */
- (NSCache *)cache;

/**
 *  @brief  get方法
 *
 *  @return 返回缓存目录
 */
- (NSString *)cacheDiskPath;

/**
 *  @brief  缓存key
 *
 *  @return 返回NSString类型的缓存key
 */
- (NSString *)cacheKey;

/**
 *  @brief  获取缓存的对象
 *
 *  @return 返回缓存的对象
 */
- (id)cachedObjectAtDisk:(BOOL)disk;

/**
 *  @brief  获取缓存的对象
 *
 *  @return 返回对应key的缓存对象
 */
- (id)cachedObjectForKey:(NSString *)key atDisk:(BOOL)disk;

/**
 *  @brief  缓存对象obj
 *
 *  @return 无返回值
 */
- (void)cacheObject:(id)obj atDisk:(BOOL)disk;

/**
 *  @brief  缓存对象obj对应key
 *
 *  @return 无返回值
 */
- (void)cacheObject:(id)obj forKey:(NSString *)key atDisk:(BOOL)disk;

/**
 *  @brief  清除所有缓存
 *
 *  @return 无返回值
 */
- (void)cleanCacheAtDisk:(BOOL)disk;

/**
 *  @brief  清除对应key的缓粗
 *
 *  @return 无返回值
 */
- (void)cleanCacheWithKey:(NSString *)key atDisk:(BOOL)disk;
@end

/**
 *  @brief  SOBaseModel，model基类，定义一些基本model属性、方法和协议
 */
@interface SOBaseModel : NSObject <SOBaseModelProtocol, SOBaseModelCacheProtocol>
/**
 *  @brief  承担委托的代理对象，响应回调
 */
@property (weak, nonatomic) id <SOModelDelegate>delegate;

- (instancetype)initWithDelegate:(id<SOModelDelegate>)delegate;

@end

