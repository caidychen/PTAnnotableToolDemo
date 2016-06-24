//
//  NOERefreshTableView.m
//  SlimeRefresh
//
//  Created by soso on 14-8-11.
//  Copyright (c) 2014-2015 soso. All rights reserved.
//

#import "SORefreshTableView.h"
#import "UIView+Additions.h"
#import "SOGlobal.h"

@interface SORefreshTableView () <UITableViewDelegate, SRRefreshDelegate>
@property (weak, nonatomic) id<UITableViewDelegate>tbDelegate;
@end


@implementation SORefreshTableView

@synthesize refreshView = _refreshView;

- (instancetype)init {
    return ([self initWithFrame:CGRectZero style:UITableViewStylePlain]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    return ([self initWithFrame:frame style:UITableViewStylePlain]);
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if(self) {
        [self addSubview:self.refreshView];
        self.showRefreshView = YES;
    }
    return (self);
}

- (void)awakeFromNib {
    [self addSubview:self.refreshView];
    self.showRefreshView = YES;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.refreshView.width = CGRectGetWidth(self.bounds);
}

- (void)setShowRefreshView:(BOOL)showRefreshView{
    _showRefreshView = showRefreshView;
    self.refreshView.hidden = !showRefreshView;
}

- (void)setDelegate:(id<UITableViewDelegate>)delegate {
    _tbDelegate = delegate;
    [super setDelegate:self];
}

- (void)endRefreshSuccess:(BOOL)success {
    [_refreshView endRefreshSuccess:success];
}

- (SRRefreshView *)refreshView {
    if(!_refreshView) {
        _refreshView = [[SRRefreshView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), 60.0f)];
        _refreshView.delegate = self;
        _refreshView.upInset = 0;
        _refreshView.slime.bodyColor = _refreshView.slime.skinColor = _refreshView.activityIndicationView.color = UIColorFromRGB(0xdf302f);
        _refreshView.slimeMissWhenGoingBack = YES;
    }
    return (_refreshView);
}

#pragma mark - SRRefreshDelegate
- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView {
    SEL selector = @selector(refreshStartInDefaultRunloop);
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:selector object:nil];
    [self performSelector:selector withObject:nil afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
}

- (void)refreshStartInDefaultRunloop {
    if(self.startRefreshBlock) {
        self.startRefreshBlock(self);
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.showRefreshView) {
        [_refreshView scrollViewDidScroll];
        
        /*   解决正在加载时tableviewheader停留位置受contentInset的影响，往上滑动时header停在cell的下方了   */
        CGFloat cty = scrollView.contentOffset.y;
        if([_refreshView loading] && cty > -SR_SlimeView_Default_Height) {
            scrollView.contentInset = UIEdgeInsetsMake(MAX(0, MIN(SR_SlimeView_Default_Height, -cty)), scrollView.contentInset.left, scrollView.contentInset.bottom, scrollView.contentInset.right);
        }
    }
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewDidScroll:)]) {
        [_tbDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (self.showRefreshView) {
        [_refreshView scrollViewDidEndDraging];
    }
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)]) {
        [_tbDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [_tbDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset NS_AVAILABLE_IOS(5_0) {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewWillEndDragging:withVelocity:targetContentOffset:)]) {
        [_tbDelegate scrollViewWillEndDragging:scrollView withVelocity:velocity targetContentOffset:targetContentOffset];
    }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)]) {
        [_tbDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)]) {
        [_tbDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)]) {
        [_tbDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(viewForZoomingInScrollView:)]) {
        return ([_tbDelegate viewForZoomingInScrollView:scrollView]);
    }
    return (nil);
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view NS_AVAILABLE_IOS(3_2) {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)]) {
        [_tbDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)]) {
        [_tbDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)]) {
        return ([_tbDelegate scrollViewShouldScrollToTop:scrollView]);
    }
    return (YES);
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(scrollViewDidScrollToTop:)]) {
        [_tbDelegate scrollViewDidScrollToTop:scrollView];
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:willDisplayCell:forRowAtIndexPath:)]) {
        [_tbDelegate tableView:tableView willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:accessoryButtonTappedForRowWithIndexPath:)]) {
        [_tbDelegate tableView:tableView accessoryButtonTappedForRowWithIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:willBeginEditingRowAtIndexPath:)]) {
        [_tbDelegate tableView:tableView willBeginEditingRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView*)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:didEndEditingRowAtIndexPath:)]) {
        [_tbDelegate tableView:tableView didEndEditingRowAtIndexPath:indexPath];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return ([_tbDelegate tableView:tableView heightForRowAtIndexPath:indexPath]);
    }
    return (self.rowHeight);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return ([_tbDelegate tableView:tableView heightForHeaderInSection:section]);
    }
    return (0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return ([_tbDelegate tableView:tableView heightForFooterInSection:section]);
    }
    return (0);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return ([_tbDelegate tableView:tableView viewForHeaderInSection:section]);
    }
    return (nil);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return ([_tbDelegate tableView:tableView viewForFooterInSection:section]);
    }
    return (nil);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_tbDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath NS_AVAILABLE_IOS(3_0) {
    if(_tbDelegate && [_tbDelegate respondsToSelector:@selector(tableView:didDeselectRowAtIndexPath:)]) {
        [_tbDelegate tableView:tableView didDeselectRowAtIndexPath:indexPath];
    }
}

@end
