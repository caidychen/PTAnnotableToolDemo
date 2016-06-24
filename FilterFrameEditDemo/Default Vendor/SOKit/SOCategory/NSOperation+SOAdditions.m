//
//  NSOperation+SOAdditions.m
//  SOKit
//
//  Created by soso on 15/5/25.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "NSOperation+SOAdditions.h"
#import "NSObject+SOAdditions.h"
#import "SOGlobal.h"

@implementation NSOperation (SOAdditions)
- (NSUInteger)tag {
    return ([self soTag]);
}

- (void)setTag:(NSUInteger)tag {
    [self setSoTag:tag];
}
@end


@implementation NSOperationQueue (SOAdditions)
- (NSOperation *)operationWithTag:(NSUInteger)tag {
    NSOperation *operation = nil;
    for(NSOperation *op in self.operations) {
        if([op tag] == tag) {
            operation = op;
            break;
        }
    }
    return (operation);
}

- (NSArray *)operationsWithTag:(NSUInteger)tag {
    NSMutableArray *operations = [NSMutableArray array];
    for(NSOperation *op in self.operations) {
        if([op tag] == tag) {
            [operations addObject:op];
        }
    }
    return (operations);
}

- (void)cancelOperationForTag:(NSUInteger)tag {
    NSOperation *operation = [self operationWithTag:tag];
    if(operation && [operation isKindOfClass:[NSOperation class]]) {
        [operation cancel];
    }
}

- (void)cancelOperationForName:(NSString *)operatioName {
#ifdef __IPHONE_8_0
    if(!operatioName || ![operatioName isKindOfClass:[NSString class]]) {
        return;
    }
    NSArray *operations = [self operations];
    for(NSOperation *operation in operations) {
        if(operation.name && [operation.name isEqualToString:operatioName]) {
            [operation cancel];
        }
    }
#endif
}
@end
