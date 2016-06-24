//
//  UIView+CustomBadge.h
//  SUBTest
//
//  Created by chinaPnr on 13-11-11.
//  Copyright (c) 2013年 chinaPnr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView(CustomBadge)
- (UIView *)badgeView;
- (void)setBadge:(NSInteger)badge position:(CGPoint)position;
@end
