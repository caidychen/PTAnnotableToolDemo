//
//  SRRefreshView.m
//  SlimeRefresh
//
//  Created by zrz on 12-6-15.
//  Copyright (c) 2012年 zrz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SRRefreshView.h"
#import "SRSlimeView.h"
#import "SRDefine.h"
#import "UIView+Additions.h"

@interface SRRefreshView()

@property (nonatomic, assign)   BOOL    broken;
@property (nonatomic, assign)   UIScrollView    *scrollView;

@property (nonatomic, strong) UIButton *imgTitleButton;

@end

@implementation SRRefreshView {
    UIActivityIndicatorView *_activityIndicatorView;
    CGFloat     _oldLength;
    BOOL        _unmissSlime;
    CGFloat     _dragingHeight;
}

@synthesize delegate = _delegate, broken = _broken;
@synthesize loading = _loading, scrollView = _scrollView;
@synthesize slime = _slime, refleshView = _refleshView;
@synthesize block = _block, upInset = _upInset;
@synthesize slimeMissWhenGoingBack = _slimeMissWhenGoingBack;
@synthesize activityIndicationView = _activityIndicatorView;


- (instancetype)initWithFrame:(CGRect)frame {
    self = [self initWithHeight:SR_SlimeView_Default_Height];
    return self;
}

- (instancetype)initWithHeight:(CGFloat)height {
    CGRect frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), height);
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.slime];
        [self addSubview:self.refleshView];
        [self addSubview:self.imgTitleButton];
        [self addSubview:self.activityIndicatorView];
        
        [_slime setPullApartTarget:self action:@selector(pullApart:)];
        _dragingHeight = height;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.slime.centerX = CGRectGetWidth(self.bounds) / 2.0f;
}

#pragma mark - setters
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    if (_slime.state == SRSlimeStateNormal) {
        _slime.frame = CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height);
        _slime.startPoint = CGPointMake(frame.size.width / 2, _dragingHeight / 2);
    }
    _refleshView.center = _slime.startPoint;
    _activityIndicatorView.center = _slime.startPoint;
}

- (void)setUpInset:(CGFloat)upInset {
    _upInset = upInset;
    UIEdgeInsets inset = _scrollView.contentInset;
    inset.top = _upInset;
    _scrollView.contentInset = inset;
    
}

- (void)setSlimeMissWhenGoingBack:(BOOL)slimeMissWhenGoingBack {
    _slimeMissWhenGoingBack = slimeMissWhenGoingBack;
//    if (!slimeMissWhenGoingBack) {
//        _slime.alpha = 1;
//    }else {
//        CGPoint p = _scrollView.contentOffset;
//        self.alpha = -(p.y + _upInset) / _dragingHeight;
//    }
}

- (void)setLoading:(BOOL)loading {
    if (_loading == loading) {
        return;
    }
    _loading = loading;
    if (_loading) {
        _slime.hidden = NO;
        _imgTitleButton.hidden = YES;
        [_activityIndicatorView startAnimating];
        CAKeyframeAnimation *aniamtion = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        aniamtion.values = [NSArray arrayWithObjects:
                            [NSValue valueWithCATransform3D:
                             CATransform3DRotate(CATransform3DMakeScale(0.1, 0.1, 0.1),
                             -M_PI, 0, 0, 1)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.3f, 1.3f, 1)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity],nil];
        aniamtion.keyTimes = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0],
                              [NSNumber numberWithFloat:0.6],
                              [NSNumber numberWithFloat:1], nil];
        aniamtion.timingFunctions = [NSArray arrayWithObjects:
                                     [CAMediaTimingFunction functionWithName:
                                      kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:
                                      kCAMediaTimingFunctionEaseInEaseOut],
                                      nil];
        aniamtion.duration = 0.7;
        _activityIndicatorView.layer.transform = CATransform3DIdentity;
        [_activityIndicatorView.layer addAnimation:aniamtion forKey:@""];
        //_slime.hidden = YES;
        _refleshView.hidden = YES;
        if (!_scrollView.isDragging) {
            UIEdgeInsets inset = _scrollView.contentInset;
            inset.top = _upInset + _dragingHeight;
            _scrollView.contentInset = inset;
        }
        if (!_unmissSlime){
            _slime.state = SRSlimeStateMiss;
        }else {
            _unmissSlime = NO;
        }
    }else {
        
        [_activityIndicatorView stopAnimating];
        _slime.hidden = _refleshView.hidden = YES;
        _refleshView.layer.transform = CATransform3DIdentity;
        
        _imgTitleButton.layer.transform = CATransform3DMakeScale(0.01f, 0.01f, 1);
        _imgTitleButton.hidden = NO;
        
        __block typeof(_imgTitleButton) block_imgTitleButton = _imgTitleButton;
        __block typeof(_scrollView) block_scrollView = _scrollView;
        
        [UIView transitionWithView:_imgTitleButton duration:0.1f options:UIViewAnimationOptionCurveEaseOut animations:^{
            block_imgTitleButton.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }completion:^(BOOL finished){
            if(block_scrollView && block_scrollView.superview) {
                [UIView transitionWithView:block_scrollView
                                  duration:0.3f
                                   options:UIViewAnimationOptionCurveEaseOut
                                animations:^{
                                    UIEdgeInsets inset = block_scrollView.contentInset;
                                    inset.top = _upInset;
                                    block_scrollView.contentInset = inset;
                                    if (block_scrollView.contentOffset.y == -_upInset &&
                                        _slimeMissWhenGoingBack) {
                                        //self.alpha = 0.0f;
                                    }
                                } completion:^(BOOL finished) {
                                    //_notSetFrame = NO;
                                }];
            }
        }];
    }
}

- (void)setLoadingWithexpansion {
    self.loading = YES;
    [_scrollView setContentOffset:CGPointMake(_scrollView.contentOffset.x, -_scrollView.contentInset.top) animated:YES];
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    if ([self.superview isKindOfClass:[UIScrollView class]]) {
        self.scrollView = (id)[self superview];
        CGRect rect = self.frame;
        rect.origin.y = rect.size.height?-rect.size.height:-_dragingHeight;
        rect.size.width = _scrollView.frame.size.width;
        self.frame = rect;
        self.slime.toPoint = self.slime.startPoint;
        
        UIEdgeInsets inset = self.scrollView.contentInset;
        inset.top = _upInset;
        self.scrollView.contentInset = inset;
    }else if (!self.superview) {
        self.scrollView = nil;
    }
}

#pragma mark - getter 
- (SRSlimeView *)slime {
    if(!_slime) {
        CGSize size = self.bounds.size;
        _slime = [[SRSlimeView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, size.width, size.height)];
        _slime.startPoint = CGPointMake(size.width / 2, size.height / 2);
    }
    return (_slime);
}

- (UIImageView *)refleshView {
    if(!_refleshView) {
        _refleshView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sr_refresh"]];
        _refleshView.center = _slime.startPoint;
        _refleshView.bounds = CGRectMake(0.0f, 0.0f, kRefreshImageWidth, kRefreshImageWidth);
    }
    return (_refleshView);
}

- (UIButton *)imgTitleButton {
    if(!_imgTitleButton) {
        _imgTitleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70.0f, CGRectGetHeight(self.bounds))];
        [_imgTitleButton setImageEdgeInsets:UIEdgeInsetsMake(9, 0, 9, CGRectGetWidth(_imgTitleButton.bounds) - 14)];
        [_imgTitleButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
        [_imgTitleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _imgTitleButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_imgTitleButton setTitle:@"刷新成功" forState:UIControlStateNormal];
        [_imgTitleButton setImage:[UIImage imageNamed:@"refreshSuccess"] forState:UIControlStateNormal];
        _imgTitleButton.center = _slime.startPoint;
        _imgTitleButton.hidden = YES;
    }
    return (_imgTitleButton);
}

- (UIActivityIndicatorView *)activityIndicatorView {
    if(!_activityIndicatorView) {
        _activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [_activityIndicatorView stopAnimating];
        _activityIndicatorView.center = _slime.startPoint;
    }
    return (_activityIndicatorView);
}
#pragma mark -

#pragma mark - action
- (void)pullApart:(SRRefreshView*)refreshView {
    //拉断了
    self.broken = YES;
    _unmissSlime = YES;
    self.loading = YES;
    if ([_delegate respondsToSelector:@selector(slimeRefreshStartRefresh:)]) {
        [(id)_delegate performSelector:@selector(slimeRefreshStartRefresh:)
                            withObject:self];
    }
    if (_block) {
        _block(self);
    }
}

- (void)scrollViewDidScroll {
    CGPoint p = _scrollView.contentOffset;
    CGRect rect = self.frame;
    if (p.y <= - _dragingHeight - _upInset) {
        rect.origin.y = p.y + _upInset;
        rect.size.height = -p.y;
        rect.size.height = ceilf(rect.size.height);
        self.frame = rect;
        
        _slime.hidden = self.loading;
        _refleshView.hidden = self.loading;
        
        if (!self.loading) {
            _imgTitleButton.hidden = YES;
            [_slime setNeedsDisplay];
        }
        
        if (!_broken) {
            float l = -(p.y + _dragingHeight + _upInset);
            if (l <= _oldLength) {
                l = MIN(distansBetween(_slime.startPoint, _slime.toPoint), l);
                CGPoint ssp = _slime.startPoint;
                _slime.toPoint = CGPointMake(ssp.x, ssp.y + l);
                CGFloat pf = (1.0f - l / _slime.viscous) * (1.0f - kStartTo) + kStartTo;
                _refleshView.layer.transform = CATransform3DMakeScale(pf, pf, 1);
            }else if (self.scrollView.isDragging) {
                CGPoint ssp = _slime.startPoint;
                _slime.toPoint = CGPointMake(ssp.x, ssp.y + l);
                CGFloat pf = (1.0f - l / _slime.viscous) * (1.0f - kStartTo) + kStartTo;
                _refleshView.layer.transform = CATransform3DMakeScale(pf, pf, 1);
            }
            _oldLength = l;
        }
        if (self.alpha != 1.0f) self.alpha = 1.0f;
    } else if (p.y < -_upInset) {
        rect.origin.y = -_dragingHeight;
        rect.size.height = _dragingHeight;
        self.frame = rect;
        _slime.hidden = NO;
        if(![_activityIndicatorView isAnimating]) {
            _refleshView.hidden = NO;
        }
        _imgTitleButton.hidden = YES;
        [_slime setNeedsDisplay];
        _slime.toPoint = _slime.startPoint;
        //if (_slimeMissWhenGoingBack) self.alpha = -(p.y + _upInset) / _dragingHeight;
    }
}

- (void)scrollViewDidEndDraging {
    if (_broken) {
        if (_scrollView && self.loading) {
            __block typeof(_scrollView) block_scrollView = _scrollView;
            __block typeof(self) block_self = self;
            [UIView transitionWithView:_scrollView
                              duration:0.2
                               options:UIViewAnimationOptionCurveEaseOut
                            animations:^{
                                UIEdgeInsets inset = block_scrollView.contentInset;
                                inset.top = _upInset + _dragingHeight;
                                block_scrollView.contentInset = inset;
                            } completion:^(BOOL finished) {
                                block_self.broken = NO;
                            }];
            [UIView beginAnimations:nil context:NULL];
            [UIView setAnimationDuration:0.2f];
            [UIView commitAnimations];
        } else {
            [self performSelector:@selector(setBroken:) withObject:nil afterDelay:0.2];
            self.loading = NO;
        }
    }
}

- (void)endRefreshSuccess:(BOOL)success {
    if (self.loading) {
        [_imgTitleButton setTitle:(success ? @"刷新成功" : @"刷新失败") forState:UIControlStateNormal];
        [_imgTitleButton setImage:[UIImage imageNamed:(success ? @"refreshSuccess" : @"refreshFailed")] forState:UIControlStateNormal];
        [self restore];
    }
    _oldLength = 0;
}

- (void)restore {
    _slime.toPoint = _slime.startPoint;
    __block typeof(_activityIndicatorView) block_activityIndicatorView = _activityIndicatorView;
    __block typeof(self) block_self = self;
    __block typeof(_slime) block_slime = _slime;
    [UIView transitionWithView:_activityIndicatorView
                      duration:0.5f
                       options:UIViewAnimationOptionCurveEaseIn
                    animations:^ {
                        block_activityIndicatorView.layer.transform = CATransform3DMakeScale(1.0f, 1.0f, 1.0f);
     } completion:^(BOOL finished) {
         block_self.loading = NO;
         block_slime.state = SRSlimeStateNormal;
     }];
}

@end
