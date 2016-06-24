//
//  SOHTTPPageRequestModel.h
//  SOKit
//
//  Created by soso on 15/6/16.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOHTTPRequestModel.h"

/**
 *  @brief  默认分页大小
 */
#define SO_DEFAULT_PAGEOFFSET   20

/**
 *  @brief  页码
 */
#define _KEY_SOHTTP_PAGEINDEX   @"page"

/**
 *  @brief  页大小
 */
#define _KEY_SOHTTP_PAGEOFFSET  @"offset"


/**
 *  @brief  SOHTTPPageRequestModel及其子类需要遵循的协议
 */
@protocol SOHTTPPageModelProtocol <SOHTTPModelProtocol>
@required

/**
 *  @brief  重新请求所有数据
 *
 *  @return 无返回值
 */
- (AFHTTPRequestOperation *)reloadData;

/**
 *  @brief  请求页码为pageIndex的分页数据
 *
 *  @return 无返回值
 */
- (AFHTTPRequestOperation *)loadDataAtPageIndex:(NSUInteger)pageIndex;
@end

@interface SOHTTPPageRequestModel : SOHTTPRequestModel <SOHTTPPageModelProtocol>

/**
 *  @brief  页大小
 */
@property (assign, nonatomic) NSUInteger pageOffset;

/**
 *  @brief  页码
 */
@property (assign, nonatomic) NSUInteger pageIndex;

/**
 *  @brief  初始化方法，设置属性页大小为pageOffset
 *
 *  @return 返回自身实例
 */
- (instancetype)initWithPageOffset:(NSUInteger)pageOffset;

@end
