//
//  NSDecimalNumber+SODecimalNumber.m
//  PTLatitude
//
//  Created by so on 15/12/10.
//  Copyright © 2015年 PT. All rights reserved.
//

#import "NSDecimalNumber+SODecimalNumber.h"

@implementation NSDecimalNumber(SODecimalNumber)
+ (NSDecimalNumber *)safeDecimalNumberWithString:(NSString *)numberValue {
    NSDecimalNumber *number = [NSDecimalNumber decimalNumberWithString:numberValue];
    if(!number || isnan([number doubleValue])) {
        number = [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    return (number);
}
@end
