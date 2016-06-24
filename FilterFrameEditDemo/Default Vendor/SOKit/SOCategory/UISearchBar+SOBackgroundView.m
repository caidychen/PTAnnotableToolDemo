//
//  UISearchBar+SOBackgroundView.m
//  SOKit
//
//  Created by soso on 15/5/18.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "UISearchBar+SOBackgroundView.h"

@implementation UISearchBar(SOBackgroundView)
- (UIView *)searchBackgroundView {
    for (UIView *view in self.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            return (view);
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            return ([view.subviews firstObject]);
        }
    }
    return (nil);
}

- (UIView *)searchTextFieldView {
    for(UIView *view in self.subviews) {
        if([view isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
            return (view);
        }
        for(UIView *subview in view.subviews) {
            if([subview isKindOfClass:NSClassFromString(@"UISearchBarTextField")]) {
                return (subview);
            }
        }
    }
    return (nil);
}

@end
