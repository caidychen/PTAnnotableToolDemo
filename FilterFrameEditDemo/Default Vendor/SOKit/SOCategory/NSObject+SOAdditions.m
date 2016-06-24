//
//  SOAdditions.m
//  SOKit
//
//  Created by soso on 15/6/16.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "NSObject+SOAdditions.h"
#import <objc/runtime.h>
#import "SOGlobal.h"

static NSString * const _KeySOObjectAdditionsTag;
static NSString * const _KeySOObjectAdditionsInfo;

@implementation NSObject(SOAdditions)

#pragma mark - mark
- (NSUInteger)soTag {
    id tagObj = objc_getAssociatedObject(self, &_KeySOObjectAdditionsTag);
    return ([tagObj unsignedIntegerValue]);
}

- (void)setSoTag:(NSUInteger)soTag {
    objc_setAssociatedObject(self, &_KeySOObjectAdditionsTag, @(soTag), OBJC_ASSOCIATION_RETAIN);
}

- (id)soInfo {
    return (objc_getAssociatedObject(self, &_KeySOObjectAdditionsInfo));
}

- (void)setSoInfo:(id)soInfo {
    objc_setAssociatedObject(self, &_KeySOObjectAdditionsInfo, soInfo, OBJC_ASSOCIATION_RETAIN);
}
#pragma mark -

#pragma mark - perform
-(void)perform:(void (^)(void))performBlock{
    performBlock();
}

-(void)perform:(void (^)(void))performBlock andDelay:(NSTimeInterval)delay {
    [self performSelector:@selector(perform:) withObject:SOCOPYBLOCK(performBlock) afterDelay:delay];
    SORELEASEBLOCK(performBlock);
}
#pragma mark -

@end



@implementation NSObject(SOJSON)

- (NSString *)SOJSONString {
    NSString *str;
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *err;
        NSData *strData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&err];
        str = [[NSString alloc] initWithData:strData encoding:NSUTF8StringEncoding];
    }
    return str;
}

- (id)SOJSONValue {
    NSError *err = nil;
    if ([self isKindOfClass:[NSString class]]) {
        NSString *jsonstr = (NSString*)self;
        NSString *containString = @":";
        NSRange range = [jsonstr rangeOfString:containString];
        if (range.location == NSNotFound || SOStringIsNilOrEmpty(jsonstr)) {
            return nil;
        }
    } else {
        NSString *jsonstr = [[NSString alloc]initWithData:(NSData *)self encoding:NSUTF8StringEncoding];
        NSString *containString = @":";
        NSRange range = [jsonstr rangeOfString:containString];
        if (range.location == NSNotFound || SOStringIsNilOrEmpty(jsonstr)) {
            return nil;
        }
    }
    if ([self isKindOfClass:[NSString class]]) {
        NSString *jsonstr = (NSString*)self;
        NSData *data = [jsonstr dataUsingEncoding:NSUTF8StringEncoding];
        id dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&err];
        return dict;
    }
    id dict = [NSJSONSerialization JSONObjectWithData:(NSData *)self options:NSJSONReadingAllowFragments error:&err];
    return dict;
}

@end
