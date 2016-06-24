//
//  UIView+Pop.m
//  PTAlbum
//
//  Created by LiLiLiu on 15/11/13.
//  Copyright © 2015年 putao.Inc. All rights reserved.
//

#import "UIView+Pop.h"

@implementation UIView (Pop)

- (void)showPopUpView:(UIView *)popView Frame:(CGRect)rect {
    popView.frame = rect;
    popView.top = self.height;
    [self addSubview:popView];
    [UIView animateWithDuration:0.3f animations:^{
        popView.top = 64.0f;
    }];
}

@end
