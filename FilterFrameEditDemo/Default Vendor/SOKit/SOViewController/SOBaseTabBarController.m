//
//  SOBaseTabBarController.m
//  SOKit
//
//  Created by soso on 14-12-17.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseTabBarController.h"
#import "SOGlobal.h"

@interface SOBaseTabBarController ()

@end

@implementation SOBaseTabBarController

- (void)dealloc {
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithNibName:nil bundle:nil]);
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        
    }
    return (self);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation NS_DEPRECATED_IOS(2_0, 6_0) {
    return ([[self selectedViewController] shouldAutorotateToInterfaceOrientation:toInterfaceOrientation]);
}

- (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0) {
    return ([[self selectedViewController] shouldAutorotate]);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0) {
    return ([[self selectedViewController] supportedInterfaceOrientations]);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation NS_AVAILABLE_IOS(6_0) {
    return ([[self selectedViewController] preferredInterfaceOrientationForPresentation]);
}
#pragma mark -

@end
