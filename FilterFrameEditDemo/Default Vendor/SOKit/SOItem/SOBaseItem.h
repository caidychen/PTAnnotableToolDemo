//
//  SOBaseItem.h
//  SOKit
//
//  Created by soso on 15/5/5.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

/**
 *  @brief  判断dict是否为空且是否为字典对象
 *
 *  @return 返回BOOL
 */
BOOL SOISDictionaryAndNotNil(NSDictionary *dict);

/**
 *  @brief  Item需要遵循的键值对协议
 */
@protocol SOKeysAndValuesProtocol <NSObject>
@required
/**
 *  @brief  get方法
 *
 *  @return 返回键值对数量
 */
- (NSUInteger)count;

/**
 *  @brief  get方法
 *
 *  @return 返回所有键
 */
- (NSArray *)allKeys;

/**
 *  @brief  get方法
 *
 *  @return 返回所有值
 */
- (NSArray *)allValues;

/**
 *  @brief  get方法
 *
 *  @return 返回键aKey对应的值
 */
- (id)objectForKey:(id)aKey;

/**
 *  @brief  移除键为aKey的值
 *
 *  @return 无返回值
 */
- (void)removeObjectForKey:(id)aKey;

/**
 *  @brief  设置键为akey的值为anObject
 *
 *  @return 无返回值
 */
- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey;

@optional
/**
 *  @brief  get方法
 *
 *  @return 返回键的枚举对象
 */
- (NSEnumerator *)keyEnumerator;

/**
 *  @brief  get方法
 *
 *  @return 返回值的枚举对象
 */
- (NSEnumerator *)objectEnumerator;
@end



@interface SOBaseItem : NSObject <NSCopying, NSCoding, SOKeysAndValuesProtocol>

/**
 *  @brief  标记item的id
 */
@property (copy, nonatomic) NSString *itemID;

/**
 *  @brief  是否被选中
 */
@property (assign, nonatomic, getter=isSelected) BOOL selected;

/**
 *  @brief  类初始化方法
 *
 *  @return 返回自身实例
 */
+ (instancetype)item;

/**
 *  @brief  类初始化方法，从dict中初始化属性
 *
 *  @return 返回自身实例
 */
+ (instancetype)itemWithDict:(NSDictionary *)dict;

/**
 *  @brief  实例方法，从dict中取值，覆盖原有值
 *
 *  @return 返回自身
 */
- (instancetype)itemAddAttributesWithDict:(NSDictionary *)dict;

@end

