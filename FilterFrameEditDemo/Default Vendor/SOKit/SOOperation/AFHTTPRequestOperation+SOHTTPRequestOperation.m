//
//  SOHTTPRequestOperation.m
//  SOKit
//
//  Created by soso on 15/6/18.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "AFHTTPRequestOperation+SOHTTPRequestOperation.h"
#import <objc/runtime.h>

static NSString * const _KeySOHTTPRequestOperationPageOffset;
static NSString * const _KeySOHTTPRequestOpreationPageIndex;

@implementation AFHTTPRequestOperation(SOHTTPRequestOperation)

- (NSUInteger)pageOffset {
    id obj = objc_getAssociatedObject(self, &_KeySOHTTPRequestOperationPageOffset);
    return ([obj unsignedIntegerValue]);
}

- (NSUInteger)pageIndex {
    id obj = objc_getAssociatedObject(self, &_KeySOHTTPRequestOpreationPageIndex);
    return ([obj unsignedIntegerValue]);
}

- (void)setPageOffset:(NSUInteger)pageOffset {
    objc_setAssociatedObject(self, &_KeySOHTTPRequestOperationPageOffset, @(pageOffset), OBJC_ASSOCIATION_RETAIN);
}

- (void)setPageIndex:(NSUInteger)pageIndex {
    objc_setAssociatedObject(self, &_KeySOHTTPRequestOpreationPageIndex, @(pageIndex), OBJC_ASSOCIATION_RETAIN);
}

@end
