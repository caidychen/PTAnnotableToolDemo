//
//  SOTitleView.m
//  SOKit
//
//  Created by soso on 14-7-7.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOTitleControl.h"
#import "SOGlobal.h"
#import "NSString+SOAdditions.h"

NSTimeInterval const SOTitleControlAnimationDuration    = 0.2f;
static CGFloat space = 5.0f;

@implementation SOTitleControl
@synthesize titleLabel = _titleLabel;
@synthesize lastImgView = _lastImgView;

- (void)dealloc {
    SORELEASE(_titleLabel);
    SORELEASE(_lastImgView);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _didSelected = NO;
        [self addSubview:self.titleLabel];
        [self addSubview:self.lastImgView];
        [self bringSubviewToFront:self.lastImgView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    CGFloat tl_height = 20.0f;
    CGSize tl_size = [self.titleLabel.text soSizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(size.width, tl_height) lineBreakMode:NSLineBreakByTruncatingTail];
    tl_size.height = tl_height;
    CGSize img_size = CGSizeMake([self.lastImgView isHidden] ? 0 : 10.0f, 5.0f);
    CGFloat tl_x = (size.width - tl_size.width - img_size.width - space) / 2.0f;
    _titleLabel.frame = CGRectMake(tl_x, 0, tl_size.width, tl_size.height);
    _lastImgView.frame = CGRectMake(space + CGRectGetMaxX(_titleLabel.frame), 0, img_size.width, img_size.height);
    _titleLabel.center = CGPointMake(_titleLabel.center.x, CGRectGetHeight(self.bounds) / 2.0f);
    _lastImgView.center = CGPointMake(_lastImgView.center.x, CGRectGetHeight(self.bounds) / 2.0f);
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:18];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel sizeToFit];
    }
    return (_titleLabel);
}

- (UIImageView *)lastImgView {
    if(!_lastImgView) {
        _lastImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 5)];
        _lastImgView.image = [UIImage imageNamed:@"Head_down_arrow"];
    }
    return (_lastImgView);
}
#pragma mark -

#pragma mark - setter
- (void)setText:(NSString *)text {
    _titleLabel.text = text;
    [self setNeedsLayout];
}

- (void)setDidSelected:(BOOL)didSelected {
    _didSelected = didSelected;
    self.lastImgView.transform = CGAffineTransformMakeRotation(didSelected ? M_PI : 0);
}

- (void)setDidSelected:(BOOL)didSelected animation:(BOOL)animation {
    _didSelected = didSelected;
    [UIView animateWithDuration:animation ? SOTitleControlAnimationDuration : 0 animations:^{
        self.lastImgView.transform = CGAffineTransformMakeRotation(didSelected ? M_PI : 0);
    }];
}

- (void)setEnabled:(BOOL)enabled {
    [self setEnabled:enabled animation:NO];
}

- (void)setEnabled:(BOOL)enabled animation:(BOOL)animation {
    [super setEnabled:enabled];
    if(enabled) {
        [self showImageAnimation:animation];
    } else {
        [self hideImageAnimation:animation];
    }
}
#pragma mark -

#pragma mark - actions
- (void)showImageAnimation:(BOOL)animation {
    NSTimeInterval duration = animation ? SOTitleControlAnimationDuration : 0;
    __block typeof(self) block_self = self;
    [UIView animateWithDuration:duration animations:^(void){
        block_self.lastImgView.alpha = 1;
        block_self.titleLabel.center = CGPointMake((CGRectGetWidth(self.bounds) - (CGRectGetWidth(block_self.lastImgView.bounds) + space)) / 2.0f, CGRectGetHeight(self.bounds) / 2.0f);
    }completion:^(BOOL finished) {
        block_self.lastImgView.hidden = NO;
    }];
}

- (void)hideImageAnimation:(BOOL)animation {
    NSTimeInterval duration = animation ? SOTitleControlAnimationDuration : 0;
    __block typeof(self) block_self = self;
    [UIView animateWithDuration:duration animations:^(void){
        block_self.lastImgView.alpha = 0;
        block_self.titleLabel.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.0f, CGRectGetHeight(self.bounds) / 2.0f);
    } completion:^(BOOL finished) {
        block_self.lastImgView.hidden = YES;
    }];
}
#pragma mark -

@end
