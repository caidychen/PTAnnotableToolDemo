//
//  SOBaseControl.m
//  SOKit
//
//  Created by soso on 15/5/5.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseControl.h"

@implementation SOBaseControl
@synthesize contentInsets = _contentInsets;
@synthesize verticalSpace = _verticalSpace;
@synthesize horizontalSpace = _horizontalSpace;

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _contentInsets = UIEdgeInsetsZero;
        _verticalSpace = _horizontalSpace = 0;
    }
    return self;
}

@end
