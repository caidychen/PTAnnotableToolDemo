//
//  NSOperation+SOAdditions.h
//  SOKit
//
//  Created by soso on 15/5/25.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSOperation (SOAdditions)

/**
 *  @brief  get方法，取得tag
 *
 *  @return 返回tag，未设置则为0
 */
- (NSUInteger)tag;

/**
 *  @brief  set方法，设置tag
 *
 *  @return 无返回值
 */
- (void)setTag:(NSUInteger)tag;

@end


@interface NSOperationQueue (SOAdditions)

/**
 *  @brief  从queue的operations数组中取出标签为tag的第一个operation
 *
 *  @return 返回operation
 */
- (NSOperation *)operationWithTag:(NSUInteger)tag;

/**
 *  @brief  从queue的operations数组中取出标签为tag的所有operation
 *
 *  @return 返回数组，成员为operation
 */
- (NSArray *)operationsWithTag:(NSUInteger)tag;

/**
 *  @brief  取消queue中标签为tag的operation
 *
 *  @return 无返回值
 */
- (void)cancelOperationForTag:(NSUInteger)tag;

/**
 *  @brief  取消queue中name为operationName的operation
 *
 *  @return 无返回值
 */
- (void)cancelOperationForName:(NSString *)operatioName;

@end
