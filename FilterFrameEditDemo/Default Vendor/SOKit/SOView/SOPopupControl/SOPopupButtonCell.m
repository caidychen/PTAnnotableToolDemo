//
//  CCPopupButtonCell.m
//  CreditCard
//
//  Created by soso on 15/5/14.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SOPopupButtonCell.h"
#import "UIView+Additions.h"

@interface SOPopupButtonCell ()
@property (strong, nonatomic, readonly) UIView *bgView;
@property (strong, nonatomic, readonly) UIView *separatorLineView;
@end

@implementation SOPopupButtonCell
@synthesize bgView = _bgView;
@synthesize separatorLineView = _separatorLineView;
@synthesize textLabel = _textLabel;
@synthesize imageView = _imageView;

- (void)dealloc {
    
}

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.backgroundColor = [UIColor clearColor];
        _contentInsets = UIEdgeInsetsMake(2, 2, 2, 2);
        _space = 3.0f;
        _imageSize = CGSizeMake(14, 14);
        _textSize = CGSizeMake(60, 20);
        _bounceType = CCPopupButtonCellBounceTypeHorizontal;
        _separatorInset = UIEdgeInsetsZero;
        self.separatorColor = [UIColor lightGrayColor];
        
        [self addSubview:self.bgView];
        [self.bgView addSubview:self.imageView];
        [self.bgView addSubview:self.textLabel];
        [self addSubview:self.separatorLineView];
        
        //self.bgView.layer.borderWidth = self.textLabel.layer.borderWidth = self.imageView.layer.borderWidth = 1;
    }
    return (self);
}

- (void)layoutSubviews {
    CGRect inFrame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    [self.textLabel sizeToFit];
    self.bgView.frame = CGRectMake(0, 0, ceilf(CGRectGetWidth(self.textLabel.bounds) + self.space + CGRectGetWidth(self.imageView.bounds)), ceilf(MAX(CGRectGetHeight(self.textLabel.bounds), CGRectGetHeight(self.imageView.bounds))));
    self.bgView.center = CGPointMake(CGRectGetMidX(inFrame), CGRectGetMidY(inFrame));
    self.textLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.textLabel.bounds), CGRectGetHeight(self.textLabel.bounds));
    self.imageView.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) + self.space, 0, self.imageSize.width, self.imageSize.height);
    self.textLabel.centerY = self.imageView.centerY = CGRectGetHeight(self.bgView.bounds) / 2.0f;
    
    CGRect separatorFrame = UIEdgeInsetsInsetRect(self.bounds, self.separatorInset);
    CGFloat lineWidth = 1.0f / [[UIScreen mainScreen] scale];
    self.separatorLineView.frame = CGRectMake(0, CGRectGetMinY(separatorFrame), lineWidth, CGRectGetHeight(separatorFrame));
}

#pragma mark - setter
- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self setNeedsLayout];
}

- (void)setSpace:(CGFloat)space {
    _space = space;
    [self setNeedsLayout];
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset {
    _separatorInset = separatorInset;
    [self setNeedsLayout];
}

- (void)setSeparatorColor:(UIColor *)separatorColor {
    _separatorColor = separatorColor;
    self.separatorLineView.backgroundColor = self.separatorColor;
}
#pragma mark -

#pragma mark - getter
- (UIView *)bgView {
    if(!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:self.bounds];
        _bgView.backgroundColor = [UIColor clearColor];
    }
    return (_bgView);
}

- (UIView *)separatorLineView {
    if(!_separatorLineView) {
        _separatorLineView = [[UIView alloc] init];
        _separatorLineView.backgroundColor = self.separatorColor;
    }
    return (_separatorLineView);
}

- (UILabel *)textLabel {
    if(!_textLabel) {
        _textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.imageView.frame) + self.space, 0, self.textSize.width, self.textSize.height)];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.font = [UIFont systemFontOfSize:14];
    }
    return (_textLabel);
}

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.imageSize.width, self.imageSize.height)];
    }
    return (_imageView);
}
#pragma mark -

@end
