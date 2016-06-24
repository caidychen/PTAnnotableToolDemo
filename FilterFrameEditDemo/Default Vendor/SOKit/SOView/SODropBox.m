//
//  SODropBox.m
//  SOKitDemo
//
//  Created by soso on 15/6/25.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SODropBox.h"
#import "SOGlobal.h"

NSTimeInterval const SODropAnimationDuration    = 0.2f;

@interface SODropBox () <UITableViewDataSource, UITableViewDelegate>
@property (assign, nonatomic) BOOL show;
@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) UITableView *tableView;
@end


@implementation SODropBox
@synthesize dataSource = _dataSource;
@synthesize delegate = _delegate;

- (void)dealloc {
    SORELEASE(_tableView);
    SORELEASE(_indexPath);
    SOSUPERDEALLOC();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        _dataSource = nil;
        _delegate = nil;
        self.show = NO;
        self.dropSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame) * 8);
        [self addSubview:self.tableView];
        self.indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.bounds;
}

#pragma mark - getter
- (BOOL)isShow {
    return (self.show);
}

- (NSIndexPath *)selectIndexPath {
    return (_indexPath);
}

- (UITableView *)tableView {
    if(!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds), self.dropSize.width, self.dropSize.height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return (_tableView);
}
#pragma mark -

#pragma mark - setter
- (void)setDataSource:(id<SODropBoxControlDataSource>)dataSource {
    _dataSource = dataSource;
    [self reloadData];
}

- (void)setDelegate:(id<SODropBoxControlDelegate>)delegate {
    _delegate = delegate;
    [self reloadData];
}

- (void)setSelectIndexPath:(NSIndexPath *)selectIndexPath animated:(BOOL)animated {
    self.indexPath = selectIndexPath;
    [self.tableView selectRowAtIndexPath:selectIndexPath animated:animated scrollPosition:UITableViewScrollPositionTop];
}
#pragma mark -

#pragma mark - actions
- (void)showInView:(UIView *)view frame:(CGRect)frame animated:(BOOL)animated {
    if(!view || ![view isKindOfClass:[UIView class]]) {
        return;
    }
    self.frame = CGRectMake(CGRectGetMinX(frame), CGRectGetMaxY(frame), self.dropSize.width, 0);
    [view addSubview:self];
    _show = YES;
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:SODropAnimationDuration animations:^{
        weak_self.height = weak_self.dropSize.height;
    }];
}

- (void)hideAnimate:(BOOL)animated {
    __weak typeof(self) weak_self = self;
    _show = NO;
    [UIView animateWithDuration:SODropAnimationDuration animations:^{
        weak_self.height = 0;
    } completion:^(BOOL finished) {
        if(finished && weak_self) {
            [weak_self removeFromSuperview];
        }
    }];
}

- (void)reloadData {
    [self.tableView reloadData];
    [self setSelectIndexPath:self.indexPath animated:YES];
}
#pragma mark -

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(dropBox:numberOfSectionsInTableView:)]) {
        return ([self.dataSource dropBox:self numberOfSectionsInTableView:tableView]);
    }
    return (1);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(dropBox:tableView:numberOfRowsInSection:)]) {
        return ([self.dataSource dropBox:self tableView:tableView numberOfRowsInSection:section]);
    }
    return (0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.dataSource && [self.dataSource respondsToSelector:@selector(dropBox:tableView:cellForRowAtIndexPath:)]) {
        return ([self.dataSource dropBox:self tableView:tableView cellForRowAtIndexPath:indexPath]);
    }
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    SOAUTORELEASE(cell);
    return (cell);
}
#pragma mark -

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.delegate && [self.delegate respondsToSelector:@selector(dropBox:tableView:heightForRowAtIndexPath:)]) {
        return ([self.delegate dropBox:self tableView:tableView heightForRowAtIndexPath:indexPath]);
    }
    return (tableView.rowHeight);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(self.delegate && [self.delegate respondsToSelector:@selector(dropBox:tableView:heightForHeaderInSection:)]) {
        return ([self.delegate dropBox:self tableView:tableView heightForHeaderInSection:section]);
    }
    return (tableView.sectionHeaderHeight);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(self.delegate && [self.delegate respondsToSelector:@selector(dropBox:tableView:heightForFooterInSection:)]) {
        return ([self.delegate dropBox:self tableView:tableView heightForFooterInSection:section]);
    }
    return (tableView.sectionFooterHeight);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(self.delegate && [self.delegate respondsToSelector:@selector(dropBox:tableView:viewForHeaderInSection:)]) {
        return ([self.delegate dropBox:self tableView:tableView viewForHeaderInSection:section]);
    }
    UIView *headerView = [[UIView alloc] init];
    SOAUTORELEASE(headerView);
    return (headerView);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(self.delegate && [self.delegate respondsToSelector:@selector(dropBox:tableView:viewForFooterInSection:)]) {
        return ([self.delegate dropBox:self tableView:tableView viewForFooterInSection:section]);
    }
    UIView *footerView = [[UIView alloc] init];
    SOAUTORELEASE(footerView);
    return (footerView);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.delegate && [self.delegate respondsToSelector:@selector(dropBox:tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate dropBox:self tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.delegate && [self.delegate respondsToSelector:@selector(dropBox:tableView:didDeselectRowAtIndexPath:)]) {
        [self.delegate dropBox:self tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}
#pragma mark -

@end
