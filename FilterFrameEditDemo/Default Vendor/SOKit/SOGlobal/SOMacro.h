//
//  SOMacro.h
//  SOKit
//
//  Created by Carl on 15/5/7.
//  Copyright (c) 2015年 Carl. All rights reserved.
//

#ifndef SOKit_SOMacro_h
#define SOKit_SOMacro_h


#define SOIFARC __has_feature(objc_arc)

#if __has_feature(objc_arc)
#define SOWEAK                  weak
#define __SOWEAK                __weak
#define PROPERTYWEAK            weak
#define SORETAIN(obj)           (obj)
#define SORELEASE(obj)          (obj=nil)
#define SORELEASEBLOCK(block)   (block)
#define SOCOPYBLOCK(block)      (block)
#define SOAUTORELEASE(obj)      (obj)
#define SOSUPERDEALLOC()
#else
#define SOWEAK                  block
#define __SOWEAK                __block
#define PROPERTYWEAK            assign
#define SORETAIN(obj)           [obj retain];
#define SORELEASE(obj)          [obj release];obj=nil;
#define SORELEASEBLOCK(block)   Block_release(block)
#define SOCOPYBLOCK(block)      Block_copy(block)
#define SOAUTORELEASE(obj)      [obj autorelease]
#define SOSUPERDEALLOC()        [super dealloc]
#endif


/**
 *  打印日志
 */
#ifdef DEBUG
#   define SOLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define SOLog(...)
#endif


/**
 *  弧度角度互转
 */
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)

#ifndef RGBCOLOR
#define RGBCOLOR(r,g,b)             [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#endif

#ifndef RGBACOLOR
#define RGBACOLOR(r,g,b,a)          [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#endif

#ifndef UIColorFromRGB
#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                                        green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
                                        blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#endif

#ifndef UIColorFromRGBWithAlpha
#define UIColorFromRGBWithAlpha(rgbValue,a)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]
#endif

#endif

