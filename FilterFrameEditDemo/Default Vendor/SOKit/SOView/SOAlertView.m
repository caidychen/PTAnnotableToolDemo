//
//  SOAlertView.m
//  SOKit
//
//  Created by soso on 15/6/10.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOAlertView.h"
#import "SOGlobal.h"

NSTimeInterval  const SOAlertAnimationDuration  = 0.2f;
CGFloat         const SOAlertSubViewSpace       = 10.0f;


/**
 *  @brief  CALayer动画的key
 */
static NSString * const _KeySOAlertZoomInAnimation      = @"KeySOAlertZoomInAnimation";


/**
 *  @brief  传入动画周期duration，单位秒
 *
 *  @return 返回一个CAKeyframeAnimation
 */
CAKeyframeAnimation *SOAlertZoomInAnimation(NSTimeInterval duration) {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 0.1)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1, 1.1, 1.0)],
                         [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.duration = duration;
    return (animation);
}

@implementation SOAlertContentView
@synthesize backgroundView = _backgroundView;
@synthesize titleLabel = _titleLabel;
@synthesize textView = _textView;
@synthesize button = _button;
@synthesize cancelButton = _cancelButton;

- (void)dealloc {
    SORELEASE(_backgroundView);
    SORELEASE(_titleLabel);
    SORELEASE(_textView);
    SORELEASE(_button);
    SORELEASE(_cancelButton);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:self.backgroundView];
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.textView];
        [self.contentView addSubview:self.button];
        [self.contentView addSubview:self.cancelButton];
    }
    return (self);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundView.frame = self.bounds;
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    CGSize size = self.contentView.bounds.size;
    self.titleLabel.frame = CGRectMake(0, 0, size.width, 20.0f);
    self.textView.frame = CGRectMake(0, CGRectGetMaxY(self.titleLabel.frame), size.width, size.height * 0.45f);
    
    self.button.center = CGPointMake(size.width / 2.0f, size.height * 0.7f);
    self.cancelButton.center = CGPointMake(size.width / 2.0f, size.height - CGRectGetHeight(self.cancelButton.bounds) * 0.8f);
}

#pragma mark - setter
- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self setNeedsLayout];
}
#pragma mark -

#pragma mark - getter
- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
    }
    return (_contentView);
}

- (UIImageView *)backgroundView {
    if(!_backgroundView) {
        _backgroundView = [[UIImageView alloc] init];
        _backgroundView.backgroundColor = [UIColor clearColor];
    }
    return (_backgroundView);
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        _titleLabel.font = [UIFont boldSystemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return (_titleLabel);
}

- (UITextView *)textView {
    if(!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.textColor = UIColorFromRGB(0x333333);
        _textView.font = [UIFont systemFontOfSize:13];
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.contentInset = UIEdgeInsetsMake(SOAlertSubViewSpace, 0, 0, 0);
        _textView.editable = NO;
        if([_textView respondsToSelector:@selector(setSelectable:)]) {
            _textView.selectable = NO;
        }
    }
    return (_textView);
}

- (UIButton *)button {
    if(!_button) {
        _button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 67, 67)];
        _button.backgroundColor = [UIColor clearColor];
    }
    return (_button);
}

- (UIButton *)cancelButton {
    if(!_cancelButton) {
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        _cancelButton.backgroundColor = [UIColor clearColor];
    }
    return (_cancelButton);
}
#pragma mark -
@end


@interface SOAlertView ()

@end

@implementation SOAlertView
@synthesize delegate = _delegate;
@synthesize contentView = _contentView;

- (void)dealloc {
    SORELEASE(_contentView);
    _delegate = nil;
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        [self addSubview:self.contentView];
        self.contentView.contentInsets = UIEdgeInsetsMake(20, 18, 20, 18);
        self.contentSize = CGSizeMake(200, 200);
    }
    return (self);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize size = self.bounds.size;
    self.contentView.center = CGPointMake(size.width / 2.0f, size.height / 2.0f);
}

#pragma mark - actions
- (void)show {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if(!window) {
        return;
    }
    self.frame = window.bounds;
    self.alpha = 1.0f;
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5f];
    [window addSubview:self];
    CAKeyframeAnimation *animation = SOAlertZoomInAnimation(SOAlertAnimationDuration);
    [self.contentView.layer addAnimation:animation forKey:_KeySOAlertZoomInAnimation];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    if(self.delegate && [self.delegate respondsToSelector:@selector(alertView:clickedButtonAtIndex:)]) {
        [self.delegate alertView:self clickedButtonAtIndex:buttonIndex];
    }
    if(!animated) {
        [self removeFromSuperview];
        return;
    }
    __weak typeof(self) weak_self = self;
    [UIView animateWithDuration:SOAlertAnimationDuration animations:^{
        weak_self.alpha = 0.1f;
    } completion:^(BOOL finished) {
        if(finished && weak_self) {
            [weak_self removeFromSuperview];
        }
    }];
}

- (void)buttonTouched:(id)sender {
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)cancelButtonTouched:(id)sender {
    [self dismissWithClickedButtonIndex:1 animated:YES];
}
#pragma mark -

#pragma mark - setter
- (void)setContentSize:(CGSize)size {
    self.contentView.size = size;
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title {
    self.contentView.titleLabel.text = title;
}

- (void)setAttTitle:(NSAttributedString *)attTitle {
    self.contentView.titleLabel.attributedText = attTitle;
}

- (void)setText:(NSString *)text {
    self.contentView.textView.text = text;
}

- (void)setAttText:(NSAttributedString *)attText {
    self.contentView.textView.attributedText = attText;
}
#pragma mark -

#pragma mark - getter
- (CGSize)contentSize {
    return (self.contentView.size);
}

- (NSString *)title {
    return (self.contentView.titleLabel.text);
}

- (NSAttributedString *)attTitle {
    return (self.contentView.titleLabel.attributedText);
}

- (NSString *)text {
    return (self.contentView.textView.text);
}

- (NSAttributedString *)attText {
    return (self.contentView.textView.attributedText);
}

- (SOAlertContentView *)contentView {
    if(!_contentView) {
        _contentView = [[SOAlertContentView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [_contentView.button addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [_contentView.cancelButton addTarget:self action:@selector(cancelButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return (_contentView);
}
#pragma mark -

@end
