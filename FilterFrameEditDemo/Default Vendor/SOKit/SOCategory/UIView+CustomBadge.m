//
//  UIView+CustomBadge.m
//  SUBTest
//
//  Created by chinaPnr on 13-11-11.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import "UIView+CustomBadge.h"
#import <objc/runtime.h>
#import "SOMacro.h"

#define DEF_BADGE_SIZE  8.0f

static NSString *badgeViewKey;

@implementation UIView(CustomBadge)

- (UIView *)badgeView {
    UIView *badgeView = (UIView *)objc_getAssociatedObject(self, &badgeViewKey);
    return (badgeView);
}

- (void)setBadge:(NSInteger)badge position:(CGPoint)position {
    if(badge > 0) {
        UIView *badgeView = [self badgeView];
        if(!badgeView) {
            badgeView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, DEF_BADGE_SIZE, DEF_BADGE_SIZE)];
            badgeView.backgroundColor = [UIColor redColor];
        }
        badgeView.layer.cornerRadius = floorf(MIN(CGRectGetWidth(badgeView.bounds), CGRectGetHeight(badgeView.bounds)) / 2.0f);
        badgeView.center = CGPointMake(CGRectGetWidth(self.bounds) * position.x, CGRectGetHeight(self.bounds) * position.y);
        //debugLog(@"%f,  %f",badgeView.centerX,badgeView.centerY);
        if(!badgeView.superview) {
            [self addSubview:badgeView];
        }
        objc_setAssociatedObject(self, &badgeViewKey, badgeView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    } else {
        UIView *badgeView = [self badgeView];
        if(badgeView) {
            if(badgeView.superview) {
                [badgeView removeFromSuperview];
            }
            objc_setAssociatedObject(self, &badgeViewKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            SORELEASE(badgeView);
        }
    }
}

@end
