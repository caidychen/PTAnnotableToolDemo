//
//  SOGlobal.m
//  SOKit
//
//  Created by soso on 15/6/16.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SOGlobal.h"
#import "NSObject+SOObject.h"

CGSize SOCeilSize(CGSize size) {
    return (CGSizeMake(ceilf(size.width), ceilf(size.height)));
}

CGSize SOFloorSize(CGSize size) {
    return (CGSizeMake(floorf(size.width), floorf(size.height)));
}

double SORandom() {
    u_int32_t b = -1;
    return ((double)(arc4random() % b) / b);
}

CGSize SOScreenSize() {
    return ([[UIScreen mainScreen] bounds].size);
}

//系统版本
CGFloat SOSystemVersion(void) {
    return ((CGFloat)[[[UIDevice currentDevice] systemVersion] floatValue]);
}

//屏幕缩放
CGFloat SODeviceScale(void) {
    return ([[UIScreen mainScreen] scale]);
}

BOOL SOStringIsNilOrEmpty(NSString *str) {
    if(!str) {
        return (YES);
    }
    if(![str isKindOfClass:[NSString class]]) {
        return (YES);
    }
    if([str length] == 0) {
        return (YES);
    }
    return (NO);
}

NSString *NSStringFromBOOL(BOOL b) {
    return (b ? @"Y" : @"N");
}

id SOSafePerformSelector(id target, SEL selector, id obj) {
    if(!target || !selector) {
        return (nil);
    }
    if(![target respondsToSelector:selector]) {
        return (nil);
    }
    IMP imp = [target methodForSelector:selector];
    if(!imp) {
        return (nil);
    }
    id (*func)(id, SEL, id) = (void *)imp;
    id res = func(target, selector, obj);
    return (res);
}

SEL SOSetSelectorWithPropertyName(NSString *pName) {
    if(!pName) {
        return (nil);
    }
    NSString *hd = [pName substringToIndex:1];
    NSString *lt = [pName substringFromIndex:1];
    NSString *slString = [NSString stringWithFormat:@"set%@%@:", [hd uppercaseString], lt];
    return (NSSelectorFromString(slString));
}

UIInterfaceOrientation SOStatusBarOrientation() {
    return ([[UIApplication sharedApplication] statusBarOrientation]);
}

BOOL SOStatusBarIsPortrait() {
    return (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation));
}

BOOL SOStatusBarIsLandscape() {
    return (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation));
}


UIViewController *SOApplicationRootViewController() {
    return ([[[UIApplication sharedApplication] keyWindow] rootViewController]);
}

UIViewController *SOApplicationVisibleViewController() {
    return (SOViewControllersVisibleViewController(SOApplicationRootViewController()));
}

UIViewController *SOApplicationTabBarAtIndex(NSUInteger index) {
    UIViewController *rootViewController = SOApplicationRootViewController();
    if(!rootViewController || ![rootViewController isKindOfClass:[UITabBarController class]]) {
        return (rootViewController);
    }
    return ([[(UITabBarController *)rootViewController viewControllers] safeObjectAtIndex:index]);
}

UIViewController *SOViewControllersRootNavigationViewController(UIViewController *viewController) {
    UIViewController *rootViewController = viewController;
    while (viewController.navigationController) {
        rootViewController = viewController.navigationController;
    }
    return (rootViewController);
}

UIViewController *SOViewControllersVisibleViewController(UIViewController *viewController) {
    if([viewController isKindOfClass:[UITabBarController class]]) {
        return (SOViewControllersVisibleViewController([(UITabBarController *)viewController selectedViewController]));
    }
    if([viewController isKindOfClass:[UINavigationController class]]) {
        return (SOViewControllersVisibleViewController([(UINavigationController *)viewController visibleViewController]));
    }
    return (viewController);
}

