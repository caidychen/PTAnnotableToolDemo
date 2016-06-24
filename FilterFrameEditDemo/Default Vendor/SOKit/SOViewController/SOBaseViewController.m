//
//  SOBaseViewController.m
//  SOKit
//
//  Created by soso on 14-12-17.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseViewController.h"
#import "SOGlobal.h"

void SOJumpViewController(Class viewControllerClass, NSDictionary *parameters, BOOL animated) {
    id viewController = [[viewControllerClass alloc] init];
    if(![viewController isKindOfClass:[UIViewController class]]) {
        NSLog(@">>>%@ is not subclass UIViewController", NSStringFromClass(viewControllerClass));
        SORELEASE(viewController);
        return;
    }
    if([viewController conformsToProtocol:@protocol(SOViewControllerProtocol)]) {
        [viewController setParameters:parameters];
    }
    UIViewController *visibleViewController = SOApplicationVisibleViewController();
    if(!visibleViewController) {
        NSLog(@">>>visible viewController is nil");
        SORELEASE(viewController);
        return;
    }
    if(visibleViewController.navigationController) {
        [visibleViewController.navigationController pushViewController:viewController animated:animated];
        return;
    }
#ifdef __IPHONE_6_0
    [visibleViewController presentViewController:viewController animated:animated completion:^{}];
#else
    [visibleViewController presentModalViewController:viewController animated:animated];
#endif
}

@interface SOBaseViewController ()

@end

@implementation SOBaseViewController

- (void)dealloc {
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithNibName:nil bundle:nil]);
}

- (instancetype)initWithSelfClassNameNib {
    return ([self initWithNibName:NSStringFromClass([self class]) bundle:[NSBundle mainBundle]]);
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
    self.navigationController.navigationBar.translucent = NO;
}

- (void)disableAdjustsScrollView {
    if([self respondsToSelector:@selector(setAutomaticallyAdjustsScrollViewInsets:)]) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

- (void)cleanEdgesForExtendedLayout {
    if([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

#pragma mark - <SOViewControllerProtocol>
+ (instancetype)viewControllerWithParameters:(id)parameters {
    id viewController = [[[self class] alloc] initWithParameters:parameters];
    SOAUTORELEASE(viewController);
    return (viewController);
}

- (instancetype)initWithParameters:(id)parameters {
    self = [super init];
    if(self) {
        [self setParameters:parameters];
    }
    return (self);
}

- (void)setParameters:(id)parameters {
    //root do nothing
}
#pragma mark -

#pragma mark - orientation
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation NS_DEPRECATED_IOS(2_0, 6_0) {
    return (NO);
}

- (BOOL)shouldAutorotate NS_AVAILABLE_IOS(6_0) {
    return (NO);
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations NS_AVAILABLE_IOS(6_0) {
    return (UIInterfaceOrientationMaskPortrait);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation NS_AVAILABLE_IOS(6_0) {
    return (UIInterfaceOrientationPortrait);
}
#pragma mark -

@end
