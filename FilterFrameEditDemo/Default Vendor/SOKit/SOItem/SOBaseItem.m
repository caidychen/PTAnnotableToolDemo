//
//  SOBaseItem.m
//  SOKit
//
//  Created by soso on 15/5/5.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <objc/runtime.h>
#import "SOBaseItem.h"
#import "SOGlobal.h"

BOOL SOISDictionaryAndNotNil(NSDictionary *dict) {
    return (dict && [dict isKindOfClass:[NSDictionary class]]);
}


@interface SOKillErrorObj : NSObject
@end
@implementation SOKillErrorObj
@end
static SOKillErrorObj *killErrorObj = nil;
SOKillErrorObj * SOSharedKillErrorObj() {
    if(!killErrorObj) {
        killErrorObj = [[SOKillErrorObj alloc] init];
    }
    return (killErrorObj);
}

@interface SOBaseItem () {
    NSMutableDictionary *_mtlDict;
}
@property (strong, nonatomic) NSMutableDictionary *mtlDict;
@end


@implementation SOBaseItem
@synthesize mtlDict = _mtlDict;

+ (instancetype)item {
    return ([[self alloc] init]);
}

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    id item = [self item];
    if(!SOISDictionaryAndNotNil(dict)) {
        return (item);
    }
//    for(NSString *key in dict.allKeys) {
//        SOSafePerformSelector(item, SOSetSelectorWithPropertyName(key), dict[key]);
//    }
    return (item);
}

- (void)dealloc {
    SORELEASE(_mtlDict);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _selected = NO;
        _itemID = nil;
        _mtlDict = nil;
    }
    return (self);
}

- (instancetype)itemAddAttributesWithDict:(NSDictionary *)dict {
    if(!SOISDictionaryAndNotNil(dict)) {
        return (self);
    }
//    for(NSString *key in dict.allKeys) {
//        SOSafePerformSelector(self, SOSetSelectorWithPropertyName(key), dict[key]);
//    }
    return (self);
}

- (NSString *)description {
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"<%s>\n{", object_getClassName(self)];
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id value= [self valueForKey:key];
        [str appendFormat:@"\n\t%@ = %@",key, value];
    }
    [str appendString:@"\n}"];
    free(properties);
    return str;
}

- (NSString *)debugDescription {
    unsigned int outCount = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableString *str = [[NSMutableString alloc] initWithFormat:@"<%s>\n{", object_getClassName(self)];
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *key = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id value= [self valueForKey:key];
        [str appendFormat:@"\n\t%@ = %@",key, value];
    }
    [str appendString:@"\n}"];
    free(properties);
    return str;
}

#pragma mark - getter
- (NSMutableDictionary *)mtlDict {
    if(!_mtlDict) {
        _mtlDict = [[NSMutableDictionary alloc] init];
    }
    return (_mtlDict);
}
#pragma mark -

#pragma mark - <SOKeysAndValuesProtocol>
- (NSUInteger)count {
    return ([self mtlDict].count);
}

- (NSArray *)allKeys {
    return ([self mtlDict].allKeys);
}

- (NSArray *)allValues {
    return ([self mtlDict].allValues);
}

- (id)objectForKey:(id)aKey {
    return ([[self mtlDict] objectForKey:aKey]);
}

- (NSEnumerator *)keyEnumerator {
    return ([self mtlDict].keyEnumerator);
}

- (NSEnumerator *)objectEnumerator {
    return ([self mtlDict].objectEnumerator);
}

- (void)removeObjectForKey:(id)aKey {
    [[self mtlDict] removeObjectForKey:aKey];
}

- (void)setObject:(id)anObject forKey:(id <NSCopying>)aKey {
    if(!aKey) {
        return;
    }
    if(!anObject) {
        anObject = [NSNull null];
    }
    [[self mtlDict] setObject:anObject forKey:aKey];
}
#pragma mark

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    SOBaseItem *item = [[[self class] allocWithZone:zone] init];
    id cpDict = [self.mtlDict mutableCopy];
    item.itemID = self.itemID;
    item.selected = self.selected;
    item.mtlDict = cpDict;
    SORELEASE(cpDict);
    return (item);
}
#pragma mark -

#pragma mark - <NSCoding>
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.mtlDict forKey:NSStringFromSelector(@selector(setMtlDict:))];
    [aCoder encodeObject:self.itemID forKey:NSStringFromSelector(@selector(setItemID:))];
    [aCoder encodeObject:@(self.selected) forKey:NSStringFromSelector(@selector(setSelected:))];
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    id deObj = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(setMtlDict:))];
    if(deObj && ![deObj isKindOfClass:[NSMutableDictionary class]]) {
        return (self);
    }
    self.mtlDict = (NSMutableDictionary *)deObj;
    self.itemID = (NSString *)[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(setItemID:))];
    self.selected = (BOOL)[[aDecoder decodeObjectForKey:NSStringFromSelector(@selector(setSelected:))] boolValue];
    return (self);
}
#pragma mark -

#pragma mark - invocation
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"###### Error!!!, %@ Invalid selector:%@", anInvocation.target, NSStringFromSelector(anInvocation.selector));
    SEL seletor = [anInvocation selector];
    if ([self respondsToSelector:seletor]) {
        [anInvocation invokeWithTarget:self];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature* signature = [super methodSignatureForSelector:aSelector];
    if (!signature) {
        SOKillErrorObj *killErrorObj = SOSharedKillErrorObj();
        if(![killErrorObj respondsToSelector:aSelector]) {
            class_addMethod([killErrorObj class], aSelector, (IMP)sel_getName(aSelector), "@@:");
        }
        signature = [killErrorObj methodSignatureForSelector:aSelector];
    }
    return (signature);
}
#pragma mark -

@end
