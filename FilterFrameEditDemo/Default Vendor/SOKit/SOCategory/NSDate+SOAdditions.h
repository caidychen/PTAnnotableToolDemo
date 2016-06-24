//
//  NSDate+Additions.h
//  SOKit
//
//  Created by Carl on 15/5/7.
//  Copyright (c) 2015年 Carl. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate(SOAdditions)
/*
 * 本方法用于获取当前今天是周几
 * 周日是1, 周一是2，周二是3，周三是4，周四是5，周五是6，周六是7
 */
+ (int) weekdayToday;

/*
 *当前日期是周几
 */
- (int) weekdayForCurrentDate;

/*
 * 下个月的今日 格式: yyyy-MM-dd HH:mm:ss
 */
- (NSDate *) dateNextMonthToday;

/*
 * 上个月的今日
 */
- (NSDate *) datePreviousMonthToday;

/*
 * intMonth 个月后的此刻
 * 注：负数表示前intMonth个月，正数表示后intMonth个月
 */
- (NSDate *) dateTodayAfterTheFollowingMonth:(int)intMonth;

/*
 * intDay 后的今日
 */
- (NSDate *) dateTodayAfterDays:(int)intDay;

/*
 * 本月的天数
 */
- (NSUInteger) numberOfDaysForCurrentMonth;

/*
 * 本月的周数
 */
- (NSUInteger)numberOfWeeksForCurrentMonth;

/*
 * 本月最初的一天
 */
- (NSDate *) firstDayOfThisMonth;

/*
 * 本月最后的一天
 */
- (NSDate *)lastDayOfThisMonth;

/*
 * 本月的第一天是周几
 */
- (NSUInteger)weekdayForTheFirstDayThisMonth;

/*
 * 获取当前日历对象
 */
- (NSDateComponents *)YMDComponents;

////////////////////////////////////////////////////////////////////////////
/*-- 日期格式 --*/

/*
 * "yyyy-MM-dd" 格式的字符串转换为日期
 */
+ (NSDate *) dateFromString:(NSString *) strDate;
/*
 * 日期转换成 yyyy-MM-dd 格式的字符串
 */
+ (NSString *) stringFromDate:(NSDate *) date;

/*
 * 日期转换成 yyyy-MM-dd HH:mm:ss 格式的字符串
 */
+ (NSString *) stringFromDetailDate:(NSDate *) date;

- (NSString *) dateToString;

/*
 * 获取指定日期的农历日期
 */
+(NSString*)getChineseCalendarWithDate:(NSDate *)date;

+(NSInteger)getTimeStampForCurrentDate;

@end
