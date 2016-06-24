//
//  SOBaseTableViewController.m
//  SOKit
//
//  Created by soso on 14-12-17.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseTableViewController.h"
#import "SOGlobal.h"

@implementation SOBaseTableViewController

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

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}
#pragma mark -

@end
