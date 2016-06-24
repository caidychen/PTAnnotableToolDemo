
//  SOHTTPRequestModel.m
//  SOKit
//
//  Created by soso on 15/6/16.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOHTTPRequestModel.h"
#import "AppDelegate.h"

NSString * const SOHTTPRequestMethodGET         = @"GET";
NSString * const SOHTTPRequestMethodPOST        = @"POST";


@implementation SOHTTPRequestModel
@synthesize baseURLString = _baseURLString;
@synthesize parameters = _parameters;
@synthesize requestOperationManager = _requestOperationManager;

- (void)dealloc {
    SORELEASE(_baseURLString);
    SORELEASE(_parameters);
    SORELEASE(_requestOperationManager);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _baseURLString = @"";
        self.method = SOHTTPRequestMethodPOST;
        _parameters = [[NSMutableDictionary alloc] init];
        [self requestOperationManager];
    }
    return (self);
}

#pragma mark - getter
- (AFHTTPRequestOperationManager *)requestOperationManager {
    if(!_requestOperationManager) {
        _requestOperationManager = [[AFHTTPRequestOperationManager alloc] init];
        _requestOperationManager.requestSerializer = [AFHTTPRequestSerializer serializer];
        [_requestOperationManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        _requestOperationManager.requestSerializer.timeoutInterval = 15.f;
        [_requestOperationManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        _requestOperationManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    return (_requestOperationManager);
}
#pragma mark -

#pragma mark - actions
- (void)appendOtherParameters {
    
}

- (NSString *)showFullRequestURL {
    NSMutableString *urlString = [NSMutableString stringWithString:self.baseURLString];
    if(urlString && urlString.length > 0 && self.parameters && self.parameters.count > 0) {
        [urlString appendString:@"?"];
        [self.parameters enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [urlString appendFormat:@"%@=%@&", key, obj];
        }];
        NSString *ps = [urlString substringWithRange:NSMakeRange(0, MAX(0, urlString.length - 1))];
        //NSLog(@">>>>>>param:%@", self.parameters);
        NSLog(@">>>>>>URL:%@", ps);
        return (ps);
    }
    return (nil);
}
#pragma mark -

#pragma mark -- method
- (void)saveCacheTime {
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
//    NSTimeInterval time = [date timeIntervalSince1970];
    // 把时间缓存
    [self cacheObject:date forKey:[self cacheKeyTime] atDisk:YES];
}

- (NSTimeInterval)getCacheTime {
    // 失败先取出缓存
    NSDate *date = [self cachedObjectForKey:[self cacheKeyTime] atDisk:YES];
    NSTimeInterval time = [date timeIntervalSince1970];
    return time;
}
#pragma mark -

#pragma mark - <SOBaseModelCacheProtocol>
- (NSString *)cacheKey {
    return ([NSString stringWithFormat:@"%@-%@", self.baseURLString, self.parameters]);
}

- (NSString *)cacheKeyTime {
    return ([NSString stringWithFormat:@"%@-%@-time", self.baseURLString, self.parameters]);
}
#pragma mark -

#pragma mark - <SOBaseModelProtocol>
- (void)cancelAllRequest {
    [self.requestOperationManager.operationQueue cancelAllOperations];
    [super cancelAllRequest];
}

- (AFHTTPRequestOperation *)startLoad {
    [self appendOtherParameters];
    NSLog(@"baseURL = %@,parameter=%@",self.baseURLString,self.parameters);
    __SOWEAK typeof(self) weak_self = self;
    if(self.method && [self.method isEqualToString:SOHTTPRequestMethodGET]) {
        AFHTTPRequestOperation *operation = [self.requestOperationManager GET:self.baseURLString parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSError * error;
            if ([responseObject isKindOfClass:[NSData class]]) {
                responseObject = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
            }
            
            [weak_self request:operation didReceived:responseObject];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [weak_self request:operation didFailed:error];
        }];
        return (operation);
    }
    AFHTTPRequestOperation *operation = [self.requestOperationManager POST:self.baseURLString parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weak_self request:operation didReceived:responseObject];
        
//        //判断是登录失效,授权失败，重新登录
//        if (responseObject && [[responseObject objectForKey:@"status"] integerValue] == -2) {
//            AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//            if (delegate && [delegate respondsToSelector:@selector(showLogin)]) {
//                [delegate showLogin];
//            }
//        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self request:operation didFailed:error];
    }];
    return (operation);
}

- (AFHTTPRequestOperation *)startLoadForTime:(NSTimeInterval)time {
    [self appendOtherParameters];
    NSDictionary *cacheDic = [self cachedObjectForKey:[self cacheKey] atDisk:YES];
    if (cacheDic && [cacheDic isKindOfClass:[NSDictionary class]] && cacheDic.allKeys > 0) {
        // 有缓存
        NSTimeInterval cacheTime = [self getCacheTime];
        
        NSDate *nowDate = [NSDate dateWithTimeIntervalSinceNow:0];
        NSTimeInterval nowTime = [nowDate timeIntervalSince1970];
        
        NSTimeInterval cacheToNowTime = nowTime - cacheTime;
        if (cacheToNowTime <= time) {
            [self request:nil didReceived:cacheDic];
        } else {
            [self request:nil didReceived:cacheDic];
            AFHTTPRequestOperation *operation = [self startLoadWithTime:time];
            return operation;
        }
    } else {
       AFHTTPRequestOperation *operation = [self startLoadWithTime:time];
        return operation;
    }
    return nil;
}

- (AFHTTPRequestOperation *)startLoadWithTime:(NSTimeInterval)time {
    __SOWEAK typeof(self) weak_self = self;
    if(self.method && [self.method isEqualToString:SOHTTPRequestMethodGET]) {
        AFHTTPRequestOperation *operation = [self.requestOperationManager GET:self.baseURLString parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [weak_self request:operation didReceived:responseObject];
            [weak_self cacheObject:responseObject forKey:[weak_self cacheKey] atDisk:YES];
            [weak_self saveCacheTime];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [weak_self request:operation didFailed:error];
        }];
        return (operation);
    }
    AFHTTPRequestOperation *operation = [self.requestOperationManager POST:self.baseURLString parameters:self.parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [weak_self request:operation didReceived:responseObject];
        [weak_self cacheObject:responseObject forKey:[weak_self cacheKey] atDisk:YES];
        [weak_self saveCacheTime];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [weak_self request:operation didFailed:error];
    }];
    return (operation);
}


- (void)request:(AFHTTPRequestOperation *)request didReceived:(id)responseObject {
    if(self.delegate && [self.delegate respondsToSelector:@selector(model:didReceivedData:userInfo:)]) {
        [self.delegate model:self didReceivedData:responseObject userInfo:nil];
    }
}

- (void)request:(AFHTTPRequestOperation *)request didFailed:(NSError *)error {
    if(self.delegate && [self.delegate respondsToSelector:@selector(model:didFailedInfo:error:)]) {
        [self.delegate model:self didFailedInfo:nil error:error];
    }
}
#pragma mark -

@end
