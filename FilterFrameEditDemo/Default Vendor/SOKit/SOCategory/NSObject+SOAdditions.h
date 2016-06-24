//
//  SOAdditions.h
//  SOKit
//
//  Created by soso on 15/6/16.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject(SOAdditions)

/**
 *  @brief  无参数
 *
 *  @return 返回动态绑定的tag，默认为0
 */
- (NSUInteger)soTag;

/**
 *  @brief  传入类型为NSUInterger的tag
 *
 *  @return 无返回值
 */
- (void)setSoTag:(NSUInteger)soTag;

/**
 *  @brief  无参数
 *
 *  @return 返回动态绑定的info，类型为id
 */
- (id)soInfo;

/**
 *  @brief  传入类型为id的info
 *
 *  @return 无返回值
 */
- (void)setSoInfo:(id)soInfo;


/**
 *  @brief  传入无返回无参数的block
 *
 *  @return 无返回值
 */
-(void)perform:(void (^)(void))performBlock;

/**
 *  @brief  传入无返回无参数的block和执行延迟delay（单位为秒）
 *
 *  @return 无返回值
 */
-(void)perform:(void (^)(void))performBlock andDelay:(NSTimeInterval)delay;

@end




/**
 *  @brief  NSObject和JSON的互转，运用iOS5.0开始支持的NSJSONSerialization
 */
@interface NSObject(SOJSON)
/**
 *  @brief  无参数
 *
 *  @return 返回JSON对象的字符串格式
 */
- (NSString *)SOJSONString;

/**
 *  @brief  无参数
 *
 *  @return 返回JSON对象
 */
- (id)SOJSONValue;

@end