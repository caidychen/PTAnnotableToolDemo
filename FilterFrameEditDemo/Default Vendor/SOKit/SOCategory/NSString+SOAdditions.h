//
//  NSString+Size.h
//  SOKit
//
//  Created by soso on 15-1-28.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGGeometry.h>

@class UIFont;
@interface NSString(SOSize)

/**
 *  @brief  传入字体和定宽，计算字符串排列高度
 *
 *  @return 返回所占大小
 */
- (CGSize)soSizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

/**
 *  @brief  传入字体、定宽和换行模式
 *
 *  @return 返回所占大小
 */
- (CGSize)soSizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width lineBreakMode:(NSInteger)lineBreakMode;

/**
 *  @brief  传入字体、定宽和换行模式
 *
 *  @return 返回所占大小
 */
- (CGSize)soSizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width textAlignment:(NSTextAlignment)alignment lineBreakMode:(NSInteger)lineBreakMode;

/**
 *  @brief  传入字体、定宽和换行模式
 *
 *  @return 返回所占大小
 */
- (CGSize)soSizeWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width textAlignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing lineBreakMode:(NSInteger)lineBreakMode;

/**
 *  @brief  传入字体和限定大小
 *
 *  @return 返回所占大小
 */
- (CGSize)soSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

/**
 *  @brief  传入字体、限定大小和换行模式
 *
 *  @return 返回所占大小
 */
- (CGSize)soSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSInteger)lineBreakMode;

/**
 *  @brief  传入字体、限定大小和换行模式
 *
 *  @return 返回所占大小
 */
- (CGSize)soSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size textAlignment:(NSTextAlignment)alignment lineBreakMode:(NSInteger)lineBreakMode;

/**
 *  @brief  传入字体、限定大小和换行模式
 *
 *  @return 返回所占大小
 */
- (CGSize)soSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size textAlignment:(NSTextAlignment)alignment lineSpacing:(CGFloat)lineSpacing lineBreakMode:(NSInteger)lineBreakMode;
@end


@interface NSString(SOAdditions)

/**
 *	@brief	移除字符串首位空字符串.
 *
 *	@return	字符串实例.
 */
- (NSString *)trim;

/**
 *	@brief	返回常量空字符串.
 *
 *	@return	空字符串实例.
 */
+ (NSString *)empty;

/**
 *	@brief	url编码.
 *
 *	@return	返回url编码字符串.
 */
- (NSString *)urlEncoded;

/**
 *	@brief	md5编码.
 *
 *	@return md5字符串.
 */
- (NSString*)md5Hash;

/**
 *	@brief	sha1.
 *
 *	@return	sha1字符串.
 */
- (NSString*)sha1Hash;

/*!
 @abstract   普通MD5加密
 
 @return MD5加密后的字符串
 */
-(NSString *)md5Com;

/*!
 @abstract   快速MD5加密
 
 @return MD5加密后的字符串
 */
- (NSString *)md5;

/*!
 @abstract   快速MD5加密，传入key
 
 @return MD5加密后的字符串
 */
- (NSString *)md5:(NSString *)key;

/*!
 @abstract  汉字转拼音
 
 @return 返回字符串
 */
- (NSString *)ChineaseStringToASIIString;

@end
