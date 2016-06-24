//
//  SOObject.h
//  SOKit
//
//  Created by chinaPnr on 13-10-24.
//  Copyright (c) 2013-2015 chinaPnr. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray(SOObject)
- (id)safeObjectAtIndex:(NSInteger)index;
@end


@interface NSMutableArray(SOObject)
- (void)safeAddObject:(id)anObject;
- (void)safeInsertObject:(id)anObject atIndex:(NSInteger)index;
- (void)safeRemoveObjectAtIndex:(NSInteger)index;
- (void)safeReplaceObjectAtIndex:(NSInteger)index withObject:(id)anObject;
@end


@interface NSDictionary(SOObject)
- (NSString *)stringObjectForKey:(id <NSCopying>)key;
- (id)safeJsonObjectForKey:(id <NSCopying>)key;
@end


@interface NSMutableDictionary(SOObject)
- (void)safeSetObject:(id)anObject forKey:(id <NSCopying>)aKey;
@end
