//
//  UIViewController+SOViewController.m
//  SOKit
//
//  Created by soso on 14-12-18.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "UIViewController+SOViewController.h"
#import "UIButton+SOButton.h"
#import "SOGlobal.h"
#import "NSString+SOAdditions.h"
#import "UIView+Additions.h"

@implementation UIViewController(SOViewController)

- (void)dismissAnimation:(BOOL)animation {
    if(self.navigationController) {
        [self.navigationController popViewControllerAnimated:animation];
    } else {
        [self dismissViewControllerAnimated:animation completion:nil];
    }
}

- (UIButton *)showLeftItemWithText:(NSString *)text
                             color:(UIColor *)color
                              font:(UIFont *)font
                          selector:(SEL)selector
                         animation:(BOOL)animation {
    if(!self.navigationItem) {
        return (nil);
    }
    if(!text || text.length == 0) {
        [self.navigationItem setLeftBarButtonItem:nil];
    }
    
    CGSize textSize = [text soSizeWithFont:font constrainedToSize:CGSizeMake(100, 40)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.size = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:(UIView *)button];
    [self.navigationItem setLeftBarButtonItem:item animated:animation];
    return (button);
}

- (UIButton *)showLeftItemWithImage:(UIImage *)image
                           selector:(SEL)selector
                          animation:(BOOL)animation {
    if(!self.navigationItem) {
        return (nil);
    }
    CGFloat scale = SODeviceScale();
    CGSize imageSize = CGSizeMake(CGImageGetWidth(image.CGImage) / scale, CGImageGetHeight(image.CGImage) / scale);
    return ([self showLeftItemWithImage:image size:imageSize selector:selector animation:animation isMasksToBounds:NO]);
}

- (UIButton *)showLeftItemWithImage:(UIImage *)image
                               size:(CGSize)size
                           selector:(SEL)selector
                          animation:(BOOL)animation
                    isMasksToBounds:(BOOL) masksToBounds{
    UIButton *button = [UIButton buttonWithImage:image];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    if (masksToBounds) {
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = size.width*0.5;
        button.layer.borderWidth = 0.5f;
    }
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:(UIView *)button];
    [self.navigationItem setLeftBarButtonItem:item animated:animation];
    return (button);
}

- (void)hideLeftItemAnimation:(BOOL)animation {
    if(!self.navigationItem) {
        return;
    }
    [self.navigationItem setLeftBarButtonItem:nil animated:animation];
}

- (UIButton *)showRightItemWithText:(NSString *)text
                              color:(UIColor *)color
                               font:(UIFont *)font
                           selector:(SEL)selector
                          animation:(BOOL)animation {
    if(!self.navigationItem) {
        return (nil);
    }
    if(!text || text.length == 0) {
        [self.navigationItem setLeftBarButtonItem:nil];
    }
    CGSize textSize = [text soSizeWithFont:font constrainedToSize:CGSizeMake(100, 40)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.size = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:(UIView *)button];
    [self.navigationItem setRightBarButtonItem:item animated:animation];
    return (button);
}

- (UIButton *)showRightItemWithImage:(UIImage *)image
                            selector:(SEL)selector
                           animation:(BOOL)animation {
    if(!self.navigationItem) {
        return (nil);
    }
    CGFloat scale = SODeviceScale();
    CGSize imageSize = CGSizeMake(CGImageGetWidth(image.CGImage) / scale, CGImageGetHeight(image.CGImage) / scale);
    return ([self showRightItemWithImage:image size:imageSize selector:selector animation:animation]);
}

- (UIButton *)showRightItemWithImage:(UIImage *)image
                                size:(CGSize)size
                            selector:(SEL)selector
                           animation:(BOOL)animation {
    UIButton *button = [UIButton buttonWithImage:image];
    button.frame = CGRectMake(0, 0, size.width, size.height);
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:(UIView *)button];
    [self.navigationItem setRightBarButtonItem:item animated:animation];
    return (button);
}


- (void)hideRightItemAnimation:(BOOL)animation {
    if(!self.navigationItem) {
        return;
    }
    [self.navigationItem setRightBarButtonItem:nil animated:animation];
}

- (UIButton *)setTitle:(NSString *)title
                 color:(UIColor *)color
                  font:(UIFont *)font
              selector:(SEL)selector {
    if(!self.navigationItem) {
        return (nil);
    }
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:button];
    return (button);
}

- (UIButton *)setTitleImage:(UIImage *)image
                   selector:(SEL)selector {
    if(!self.navigationItem) {
        return (nil);
    }
    UIButton *button = [UIButton buttonWithImage:image];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:button];
    return (button);
}

- (void)removeTitleImage {
    if(!self.navigationItem) {
        return;
    }
    [self.navigationItem setTitleView:nil];
}


/**
 * @brief 动态调整导航栏透明度
 */
- (void)setNavigationBarWithColor:(UIColor *)color{
    UIImage *image = [self imageWithColor:color];
    
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBarStyle:UIBarStyleDefault];
    [navigationBar setShadowImage:[UIImage new]];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [navigationBar setTintColor:[UIColor whiteColor]];
    [navigationBar setTranslucent:YES];
}

- (void)recoverNavigationBar{
    UINavigationBar *navigationBar = self.navigationController.navigationBar;
    
    [navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [navigationBar setBarStyle:UIBarStyleDefault];
    [navigationBar setShadowImage:nil];
    [navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    [navigationBar setTintColor:[UIColor clearColor]];
    [navigationBar setTranslucent:NO];
}


- (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    [color setFill];
    UIRectFill(rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
