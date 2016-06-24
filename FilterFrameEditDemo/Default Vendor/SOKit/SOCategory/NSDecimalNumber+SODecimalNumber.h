//
//  NSDecimalNumber+SODecimalNumber.h
//  PTLatitude
//
//  Created by so on 15/12/10.
//  Copyright © 2015年 PT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDecimalNumber(SODecimalNumber)
+ (NSDecimalNumber *)safeDecimalNumberWithString:(NSString *)numberValue;
@end
