//
//  UIWebView+Memory.m
//  kidsPlay
//
//  Created by so on 15/10/10.
//  Copyright (c) 2015年 so. All rights reserved.
//

#import "UIWebView+Memory.h"

static NSMutableURLRequest *lastReq = nil;

@implementation UIWebView (Memory)
- (void)cleanMemory {
    if (lastReq) {
        [[NSURLCache sharedURLCache] removeCachedResponseForRequest:lastReq];
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
    }
    lastReq = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:10000];
    [lastReq setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [self loadRequest:lastReq];
}
@end
