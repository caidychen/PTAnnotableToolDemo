//
//  SOBaseModel.m
//  SOKit
//
//  Created by soso on 15/5/15.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIApplication.h>
#import "SOBaseModel.h"
#import "SOGlobal.h"
#import "NSString+SOAdditions.h"

@interface SOBaseModel () {
    NSCache *_cache;
}
@end


@implementation SOBaseModel
@synthesize delegate = _delegate;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    _delegate = nil;
    SORELEASE(_cache);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _cache = nil;
        _delegate = nil;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return (self);
}

- (instancetype)initWithDelegate:(id<SOModelDelegate>)delegate {
    self = [self init];
    if(self) {
        self.delegate = delegate;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cleanCache) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    }
    return (self);
}

- (void)cleanCache {
    [self cleanCacheAtDisk:NO];
}

#pragma mark - <SOBaseModelCacheProtocol>
- (NSCache *)cache {
    if(!_cache) {
        _cache = [[NSCache alloc] init];
    }
    return (_cache);
}

- (NSString *)cacheDiskPath {
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ModelCache"];
    return (path);
}

- (NSString *)cacheKey {
    NSMutableString *key = [NSMutableString stringWithString:NSStringFromClass([self class])];
    return (key);
}

- (id)cachedObjectAtDisk:(BOOL)disk {
    return ([self cachedObjectForKey:[self cacheKey] atDisk:disk]);
}

- (id)cachedObjectForKey:(NSString *)key atDisk:(BOOL)disk {
    if(!key) {
        return (nil);
    }
    if(!disk) {
        return ([self.cache objectForKey:key]);
    }
    NSString *filePath = [self cacheDiskPath];
    NSString *path = [filePath stringByAppendingPathComponent:[key md5]];
    NSData *data = [NSData dataWithContentsOfFile:path];
    if(!data || ![data isKindOfClass:[NSData class]]) {
        return (nil);
    }
    id obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return (obj);
}

- (void)cacheObject:(id)obj atDisk:(BOOL)disk {
    [self cacheObject:obj forKey:[self cacheKey] atDisk:disk];
}

- (void)cacheObject:(id)obj forKey:(NSString *)key atDisk:(BOOL)disk {
    if(!obj || !key) {
        return;
    }
    
    if(!disk) {
        [self.cache setObject:obj forKey:key];
        return;
    }
    
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
    NSString *filePath = [self cacheDiskPath];
    NSString *path = [filePath stringByAppendingPathComponent:[key md5]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager isExecutableFileAtPath:path]) {
        NSError *error = nil;
        if([fileManager removeItemAtPath:path error:&error]) {
            NSLog(@">>>remove file failed:%@", error.debugDescription);
        }
        return;
    }
    if(![fileManager fileExistsAtPath:filePath]) {
        if(![fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil]) {
            NSLog(@">>>carete directory failed at path:%@", filePath);
        }
    }
    if(![fileManager createFileAtPath:path contents:data attributes:nil]) {
        NSLog(@">>>carete file failed at path:%@", path);
    }
}

- (void)cleanCacheAtDisk:(BOOL)disk {
    [self cleanCacheWithKey:[self cacheKey] atDisk:disk];
}

- (void)cleanCacheWithKey:(NSString *)key atDisk:(BOOL)disk {
    if(!disk) {
        [self.cache removeObjectForKey:key];
        return;
    }
    
    NSString *filePath = [self cacheDiskPath];
    NSString *path = [filePath stringByAppendingPathComponent:[key md5]];
    if(![[NSFileManager defaultManager] removeItemAtPath:path error:nil]) {
        NSLog(@">>>remove item failed at path:%@", path);
    }
}
#pragma mark -

#pragma mark - <SOBaseModelProtocol>
- (void)cancelAllRequest {
    if(self.delegate && [self.delegate respondsToSelector:@selector(model:didCanceled:)]) {
        [self.delegate model:self didCanceled:nil];
    }
}
#pragma mark -

@end
