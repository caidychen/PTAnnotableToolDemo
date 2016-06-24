//
//  CCPopupButtonItem.m
//  CreditCard
//
//  Created by soso on 15/5/14.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SOPopupButtonItem.h"
#import <UIKit/UIGeometry.h>

@implementation SOPopupButtonItem

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    SOPopupButtonItem *item = [self item];
    if(!dict || ![dict isKindOfClass:[NSDictionary class]] || [dict count] == 0) {
        return (item);
    }
    NSString *text = dict[@"text"];
    if(text && [text isKindOfClass:[NSString class]]) {
        item.text = text;
    }
    id objState = dict[@"state"];
    if(objState && [objState isKindOfClass:[NSValue class]]) {
        item.selected = (BOOL)[objState boolValue];
    }
    id objSize = dict[@"size"];
    if(objSize && [objSize isKindOfClass:[NSValue class]]) {
        item.size = (CGSize)[objSize CGSizeValue];
    }
    return (item);
}

+ (instancetype)itemWithText:(NSString *)text
                      itemID:(NSString *)itemID
                    selected:(BOOL)selected
                        size:(CGSize)size {
    SOPopupButtonItem *item = [self item];
    item.text = text;
    item.itemID = itemID;
    item.selected = selected;
    item.size = size;
    return (item);
}

@end
