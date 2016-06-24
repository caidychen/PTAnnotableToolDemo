//
//  SOHTTPPageRequestModel.m
//  SOKit
//
//  Created by soso on 15/6/16.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOHTTPPageRequestModel.h"
#import "AFHTTPRequestOperation+SOHTTPRequestOperation.h"

@implementation SOHTTPPageRequestModel

- (void)dealloc {
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithPageOffset:SO_DEFAULT_PAGEOFFSET]);
}

- (instancetype)initWithPageOffset:(NSUInteger)pageOffset {
    self = [super init];
    if(self) {
        _pageOffset = pageOffset;
        _pageIndex = 1;
    }
    return (self);
}

#pragma mark - <SOBaseModelCacheProtocol>
- (NSString *)cacheKey {
    return ([NSString stringWithFormat:@"%@-%@-%@-%@", self.baseURLString, self.parameters, @(self.pageIndex), @(self.pageOffset)]);
}
#pragma mark -

#pragma mark - <SOHTTPPageModelProtocol>
- (void)cancelAllRequest {
    [super cancelAllRequest];
}

- (AFHTTPRequestOperation *)startLoad {
    [self.parameters setObject:[@(self.pageIndex) stringValue] forKey:_KEY_SOHTTP_PAGEINDEX];
    [self.parameters setObject:[@(self.pageOffset) stringValue] forKey:_KEY_SOHTTP_PAGEOFFSET];
    AFHTTPRequestOperation *operation = [super startLoad];
    [operation setPageOffset:self.pageOffset];
    [operation setPageIndex:self.pageIndex];
    return (operation);
}

- (AFHTTPRequestOperation *)reloadData {
    self.pageIndex = 1;
    return ([self startLoad]);
}

- (AFHTTPRequestOperation *)loadDataAtPageIndex:(NSUInteger)pageIndex {
    self.pageIndex = pageIndex;
    return ([self startLoad]);
}

- (void)request:(AFHTTPRequestOperation *)request didReceived:(id)responseObject {
    NSUInteger pgIndex = (NSUInteger)[request pageIndex];
    if(pgIndex > 0) {
        self.pageIndex = (pgIndex + 1);
    }
    if(self.delegate && [self.delegate respondsToSelector:@selector(model:didReceivedData:userInfo:)]) {
        [self.delegate model:self didReceivedData:responseObject userInfo:nil];
    }
}
#pragma mark -

@end
