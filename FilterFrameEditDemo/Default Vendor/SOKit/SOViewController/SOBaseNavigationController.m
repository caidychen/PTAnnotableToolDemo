//
//  SOBaseNavigationController.m
//  SOKit
//
//  Created by soso on 14-12-17.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseNavigationController.h"
#import "SOGlobal.h"

@interface SOBaseNavigationController ()

@end

@implementation SOBaseNavigationController

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
    return ([[self topViewController] shouldAutorotateToInterfaceOrientation:toInterfaceOrientation]);
}

- (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0) {
    return ([[self topViewController] shouldAutorotate]);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0) {
    return ([[self topViewController] supportedInterfaceOrientations]);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation NS_AVAILABLE_IOS(6_0) {
    return ([[self topViewController] preferredInterfaceOrientationForPresentation]);
}
#pragma mark -

@end
