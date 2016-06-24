//
//  UINavigationBar+FixedHeightWhenStatusBarHidden.h
//
//  Created by Vitaliy Ivanov on 7/30/14.
//  Copyright (c) 2014 Factorial Complexity. All rights reserved.
//
//  Normally on iOS 7+ navigation bar height equals to 64 px, when status bar is shown. After it is hidden, the height is changed to 44 px by default.
//  This category adds property fixedHeightWhenStatusBarHidden to UINavigationBar class.
//  If set to YES navigation bar will keep its size even if status bar was hidden.
//  This is especially useful in case of "drawer"-styled side panel, when you want status bar to be hidden when this panel is shown.

#import <UIKit/UIKit.h>

@interface UINavigationBar (FixedHeightWhenStatusBarHidden)

/**
 * If set to YES, UINavigationBar height will not change after status bar was hidden.
 * Normally on iOS 7+ navigation bar height equals to 64 px, when status bar is shown.
 * After it is hidden, its height is changed to 44 px by default.
 */
@property (readwrite, nonatomic) BOOL fixedHeightWhenStatusBarHidden;

@end
