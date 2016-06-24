//
//  CCPopupButtonItem.h
//  CreditCard
//
//  Created by soso on 15/5/14.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SOBaseItem.h"
#import <CoreGraphics/CGGeometry.h>

@interface SOPopupButtonItem : SOBaseItem
@property (copy, nonatomic) NSString *text;
@property (assign, nonatomic) CGSize size;
+ (instancetype)itemWithText:(NSString *)text
                      itemID:(NSString *)itemID
                    selected:(BOOL)selected
                        size:(CGSize)size;
@end
