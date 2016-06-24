//
//  SafeObject.m
//  SOKit
//
//  Created by chinaPnr on 13-10-24.
//  Copyright (c) 2013-2015 chinaPnr. All rights reserved.
//

#import "NSObject+SOObject.h"

@implementation NSArray(SOObject)
- (id)safeObjectAtIndex:(NSInteger)index {
    if(index < 0) {
        return (nil);
    }
    if(self.count == 0) {
        return (nil);
    }
    if(index > MAX(self.count - 1, 0)) {
        return (nil);
    }
    return ([self objectAtIndex:index]);
}
@end


@implementation NSMutableArray(SOObject)
- (void)safeAddObject:(id)anObject {
    if(!anObject) {
        return;
    }
    [self addObject:anObject];
}

- (void)safeInsertObject:(id)anObject atIndex:(NSInteger)index {
    if(index < 0) {
        return;
    }
    if(index > MAX((NSInteger)self.count - 1, 0)) {
        NSLog(@"--- insertObject:atIndex: out of array range ---");
        return;
    }
    if(!anObject) {
        NSLog(@"--- insertObject:atIndex: object must not nil ---");
        return;
    }
    [self insertObject:anObject atIndex:index];
}

- (void)safeRemoveObjectAtIndex:(NSInteger)index {
    if(index < 0) {
        return;
    }
    if(index > MAX((NSInteger)self.count - 1, 0)) {
        NSLog(@"--- removeObjectAtIndex: out of array range ---");
        return;
    }
    [self removeObjectAtIndex:index];
}

- (void)safeReplaceObjectAtIndex:(NSInteger)index withObject:(id)anObject {
    if(index < 0) {
        return;
    }
    if(index > MAX((NSInteger)self.count - 1, 0)) {
        NSLog(@"--- replaceObjectAtIndex:atIndex: out of array range ---");
        return;
    }
    if(!anObject) {
        NSLog(@"--- replaceObjectAtIndex:atIndex: object must not nil ---");
        return;
    }
    [self replaceObjectAtIndex:index withObject:anObject];
}

@end


#define checkNull(__X__) (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

@implementation NSDictionary(SOObject)

- (NSString *)stringObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null] || ob == nil) {
        return (@"");
    }
    if([ob isKindOfClass:[NSString class]]) {
        return (ob);
    }
    return ([NSString stringWithFormat:@"%@", ob]);
}

- (id)safeJsonObjectForKey:(id <NSCopying>)key {
    id ob = [self objectForKey:key];
    if(ob == [NSNull null]) {
        return (nil);
    }
    return (ob);
}

@end


@implementation NSMutableDictionary(SOObject)

- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if(!aKey || !anObject) {
        NSLog(@"--- setObject:forKey: key must not nil");
    } else {
        [self setObject:anObject forKey:aKey];
    }
}

@end

