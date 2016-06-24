//
//  SOHTTPRequestOperation.h
//  SOKit
//
//  Created by soso on 15/6/18.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "AFHTTPRequestOperation.h"

/**
 *  @brief  AFHTTPRequestOperation的分类类，附加了一些属性和方法
 */
@interface AFHTTPRequestOperation(SOHTTPRequestOperation)

/**
 *  @brief  get方法，取得页大小
 *
 *  @return 返回页大小
 */
- (NSUInteger)pageOffset;

/**
 *  @brief  get方法，取得页码，页码一定大于1
 *
 *  @return 返回页码
 */
- (NSUInteger)pageIndex;

/**
 *  @brief  set方法，设置页大小
 *
 *  @return 无返回值
 */
- (void)setPageOffset:(NSUInteger)pageOffset;

/**
 *  @brief  set方法，设置页码，页码一定要大于或等于1
 *
 *  @return 无返回值
 */
- (void)setPageIndex:(NSUInteger)pageIndex;

@end
