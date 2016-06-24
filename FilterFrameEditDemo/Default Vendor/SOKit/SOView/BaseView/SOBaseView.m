//
//  SOBaseView.m
//  SOKit
//
//  Created by soso on 15/5/5.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseView.h"
#import "SOGlobal.h"

@implementation SOBaseView
@synthesize contentInsets = _contentInsets;
@synthesize verticalSpace = _verticalSpace;
@synthesize horizontalSpace = _horizontalSpace;

- (void)dealloc {
    SOSUPERDEALLOC();
}

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

#pragma mark - setter
- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self setNeedsLayout];
}

- (void)setVerticalSpace:(CGFloat)verticalSpace {
    _verticalSpace = verticalSpace;
    [self setNeedsLayout];
}

- (void)setHorizontalSpace:(CGFloat)horizontalSpace {
    _horizontalSpace = horizontalSpace;
    [self setNeedsLayout];
}
#pragma mark -
@end
