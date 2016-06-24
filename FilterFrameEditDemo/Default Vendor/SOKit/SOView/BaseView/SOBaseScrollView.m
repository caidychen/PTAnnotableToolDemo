//
//  SOBaseScrollView.m
//  SOKit
//
//  Created by soso on 15/5/5.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseScrollView.h"

@implementation SOBaseScrollView

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
    }
    return self;
}

@end
