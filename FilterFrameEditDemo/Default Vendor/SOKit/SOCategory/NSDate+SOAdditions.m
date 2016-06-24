//
//  NSDate+Additions.m
//  SOKit
//
//  Created by Carl on 15/5/7.
//  Copyright (c) 2015年 Carl. All rights reserved.
//

#import "NSDate+SOAdditions.h"

#define DATE_FORMART @"yyyy-MM-dd"
#define DATE_DETAIL_FORMART @"yyyy-MM-dd HH:mm:ss"

#ifdef __IPHONE_8_0
#define SOCalendarUnitYear NSCalendarUnitYear
#define SOCalendarUnitMonth NSCalendarUnitMonth
#define SOCalendarUnitDay NSCalendarUnitDay
#define SOCalendarUnitWeekday NSCalendarUnitWeekday
#define SOCalendarUnitWeekOfMonth NSCalendarUnitWeekOfMonth
#define SOCalendarIdentifierChinese NSCalendarIdentifierChinese
#else
#define SOCalendarUnitYear NSYearCalendarUnit
#define SOCalendarUnitMonth NSMonthCalendarUnit
#define SOCalendarUnitDay NSDayCalendarUnit
#define SOCalendarUnitWeekday NSWeekdayCalendarUnit
#define SOCalendarUnitWeekOfMonth NSWeekCalendarUnit
#define SOCalendarIdentifierChinese NSChineseCalendar
#endif

@implementation NSDate(SOAdditions)

// 今天是本周的第几天
+ (int) weekdayToday
{
    NSDate * today = [NSDate date];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:SOCalendarIdentifierChinese];
    NSDateComponents *comps= [calendar components:(SOCalendarUnitYear |
                                                   SOCalendarUnitMonth |
                                                   SOCalendarUnitDay |
                                                   SOCalendarUnitWeekday) fromDate:today];
    return (int)[comps weekday];
}

// 当前日期是周几
- (int) weekdayForCurrentDate
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:SOCalendarIdentifierChinese];
    NSDateComponents *comps= [calendar components:(SOCalendarUnitYear |
                                                   SOCalendarUnitMonth |
                                                   SOCalendarUnitDay |
                                                   SOCalendarUnitWeekday) fromDate:self];
    return (int)[comps weekday];
}

// 下个月的此刻
- (NSDate *) dateNextMonthToday
{
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = 1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 上个月的此刻
- (NSDate *) datePreviousMonthToday
{
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 几个月后的今日
- (NSDate *) dateTodayAfterTheFollowingMonth:(int) intMonth
{
    NSDateComponents * dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = intMonth;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 几日后的今日
- (NSDate *) dateTodayAfterDays:(int) intDay
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.day = intDay;
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self options:0];
}

// 本月的天数
- (NSUInteger) numberOfDaysForCurrentMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:SOCalendarUnitDay inUnit:SOCalendarUnitMonth forDate:self].length;
}

// 本月的周数
- (NSUInteger) numberOfWeeksForCurrentMonth
{
    NSUInteger weekday = [[self firstDayOfThisMonth] weekdayForTheFirstDayThisMonth];
    NSUInteger days = [self numberOfDaysForCurrentMonth];
    NSUInteger weeks = 0;
    if (weekday > 1)
    {
        weeks += 1, days -= (7 - weekday + 1);
    }
    weeks += days / 7;
    weeks += (days % 7 > 0) ? 1 : 0;
    
    return weeks;
}

// 本月最初的一天
- (NSDate *) firstDayOfThisMonth
{
    NSDate *startDate = nil;
    BOOL ok = [[NSCalendar currentCalendar] rangeOfUnit:SOCalendarUnitMonth startDate:&startDate interval:NULL forDate:self];
    NSAssert1(ok, @"Failed to calculate the first day of the month based on %@", self);
    return startDate;
}

// 本月最后的一天
- (NSDate *)lastDayOfThisMonth
{
    NSCalendarUnit calendarUnit = SOCalendarUnitYear | SOCalendarUnitMonth | SOCalendarUnitDay;
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:calendarUnit fromDate:self];
    dateComponents.day = [self numberOfDaysForCurrentMonth];
    return [[NSCalendar currentCalendar] dateFromComponents:dateComponents];
}

// 计算这个月的第一天是礼拜几
- (NSUInteger)weekdayForTheFirstDayThisMonth
{
    NSDate * firstDay = [self firstDayOfThisMonth];
    return [[NSCalendar currentCalendar] ordinalityOfUnit:SOCalendarUnitDay inUnit:SOCalendarUnitWeekOfMonth forDate:firstDay];
}

// 获取日历对象
- (NSDateComponents *)YMDComponents
{
    return [[NSCalendar currentCalendar] components:SOCalendarUnitYear|SOCalendarUnitMonth|SOCalendarUnitDay|SOCalendarUnitWeekday|NSCalendarUnitHour fromDate:self];
}

// 字符串转换成日期
+ (NSDate *) dateFromString:(NSString *) strDate
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = DATE_FORMART;
    return [dateFormatter dateFromString:strDate];
}

+ (NSString *) stringFromDate:(NSDate *) date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = DATE_FORMART;
    return [dateFormatter stringFromDate:date];
}

+ (NSString *) stringFromDetailDate:(NSDate *) date
{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = DATE_DETAIL_FORMART;
    return [dateFormatter stringFromDate:date];
}

- (NSString *) dateToString
{
    return [NSDate stringFromDate:self];
}

+(NSString*)getChineseCalendarWithDate:(NSDate *)date{
    //定义农历数据:
    NSArray *chineseYears = [NSArray arrayWithObjects:
                             @"甲子", @"乙丑", @"丙寅", @"丁卯", @"戊辰", @"己巳", @"庚午", @"辛未", @"壬申", @"癸酉",
                             @"甲戌", @"乙亥", @"丙子", @"丁丑", @"戊寅", @"己卯", @"庚辰", @"辛己", @"壬午", @"癸未",
                             @"甲申", @"乙酉", @"丙戌", @"丁亥", @"戊子", @"己丑", @"庚寅", @"辛卯", @"壬辰", @"癸巳",
                             @"甲午", @"乙未", @"丙申", @"丁酉", @"戊戌", @"己亥", @"庚子", @"辛丑", @"壬寅", @"癸丑",
                             @"甲辰", @"乙巳", @"丙午", @"丁未", @"戊申", @"己酉", @"庚戌", @"辛亥", @"壬子", @"癸丑",
                             @"甲寅", @"乙卯", @"丙辰", @"丁巳", @"戊午", @"己未", @"庚申", @"辛酉", @"壬戌", @"癸亥", nil];
    NSArray *chineseMonths=[NSArray arrayWithObjects:
                            @"正月", @"二月", @"三月", @"四月", @"五月", @"六月",
                            @"七月", @"八月", @"九月", @"十月", @"冬月", @"腊月", nil];
    NSArray *chineseDays=[NSArray arrayWithObjects:
                          @"初一", @"初二", @"初三", @"初四", @"初五", @"初六", @"初七", @"初八", @"初九", @"初十",
                          @"十一", @"十二", @"十三", @"十四", @"十五", @"十六", @"十七", @"十八", @"十九", @"二十",
                          @"廿一", @"廿二", @"廿三", @"廿四", @"廿五", @"廿六", @"廿七", @"廿八", @"廿九", @"三十",  nil];
    
    NSCalendar* localeCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:SOCalendarIdentifierChinese];
    unsigned unitFlags = SOCalendarUnitYear | SOCalendarUnitMonth |  SOCalendarUnitDay;
    NSDateComponents *localeComp = [localeCalendar components:unitFlags fromDate:date];
    
    NSString *y_str = [chineseYears safeObjectAtIndex:localeComp.year - 1];
    NSString *m_str = [chineseMonths safeObjectAtIndex:localeComp.month-1];
    NSString *d_str = [chineseDays safeObjectAtIndex:localeComp.day-1];
    NSString *chineseCal_str =[NSString stringWithFormat: @"农历%@%@%@",y_str,m_str,d_str];
    return chineseCal_str;
}

+(NSInteger)getTimeStampForCurrentDate{
    NSDate *currentDate = [NSDate date];
    return [currentDate timeIntervalSince1970];
}

@end
