//
//  SOLoadMoreItem.m
//  SOKit
//
//  Created by soso on 15/5/18.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOLoadMoreItem.h"
#import "SOGlobal.h"

NSString * const _KeyLoadMoreItemAutoLoadMore = @"KeyLMIATLM";
NSString * const _KeyLoadMoreItemShowActivity = @"KeyLMITSA";

@implementation SOLoadMoreItem
+ (instancetype)itemWithTitle:(NSString *)title
                          tag:(NSInteger)tag
                 autoLoadMore:(BOOL)autoLoadMore
                 showActivity:(BOOL)showActivity {
    SOLoadMoreItem *item = [self item];
    item.title = title;
    item.tag = tag;
    item.autoLoadMore = autoLoadMore;
    item.showActivity = showActivity;
    return (item);
}

+ (instancetype)itemWithDict:(NSDictionary *)dict {
    SOLoadMoreItem *item = [self item];
    if(!dict || [dict count] == 0) {
        return (item);
    }
    item.title = dict[@"title"];
    item.tag = [dict[@"tag"] integerValue];
    item.autoLoadMore = [dict[_KeyLoadMoreItemAutoLoadMore] boolValue];
    item.showActivity = [dict[_KeyLoadMoreItemShowActivity] boolValue];
    return (item);
}

- (void)dealloc {
    SORELEASE(_title);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _tag = 0;
        _autoLoadMore = YES;
        _showActivity = YES;
        _title = nil;
    }
    return (self);
}

- (NSString *)description {
    NSMutableString *mtlStr = [NSMutableString stringWithString:[super description]];
    [mtlStr replaceOccurrencesOfString:@"\n}" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, mtlStr.length)];
    [mtlStr appendFormat:@"\n\ttitle = %@; ", self.title];
    [mtlStr appendFormat:@"\n\ttag = %@; ", @(self.tag)];
    [mtlStr appendFormat:@"\n\tautoLoadMore = %@; ", @(self.autoLoadMore)];
    [mtlStr appendFormat:@"\n\tshowActivity = %@; ", @(self.showActivity)];
    [mtlStr appendFormat:@"\n}"];
    return (mtlStr);
}

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    SOLoadMoreItem *item = [super copyWithZone:zone];
    item.title = self.title;
    item.tag = self.tag;
    item.autoLoadMore = self.autoLoadMore;
    item.showActivity = self.showActivity;
    return (item);
}
#pragma mark -

@end
