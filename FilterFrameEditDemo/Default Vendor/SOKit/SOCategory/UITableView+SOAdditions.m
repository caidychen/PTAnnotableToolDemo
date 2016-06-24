//
//  UITableView+SOAdditions.m
//  SOKit
//
//  Created by soso on 15/5/20.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "UITableView+SOAdditions.h"

@implementation UITableView (Additions)

- (void)clearExtendCellLine {
    if (!self.tableFooterView) {
        UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
        view.backgroundColor = [UIColor clearColor];
        [self setTableFooterView:view];
    }
}

@end
