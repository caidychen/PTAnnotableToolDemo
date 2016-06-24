//
//  SOImageTextControl.m
//  SOKit
//
//  Created by soso on 15/6/5.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOImageTextControl.h"
#import "NSString+SOAdditions.h"
#import "SOGlobal.h"

@implementation SOImageTextControl
@synthesize contentView = _contentView;
@synthesize textLabel = _textLabel;
@synthesize imageView = _imageView;

- (void)dealloc {
    SORELEASE(_textLabel);
    SORELEASE(_imageView);
    SORELEASE(_contentView);
    SOSUPERDEALLOC();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _contentInsets = UIEdgeInsetsZero;
        _imageSize = CGSizeMake(10, 10);
        _imageAndTextSpace = 2.0f;
        _imagePosition = SOImagePositionHorizontalBothCenter;
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.textLabel];
        [self.contentView addSubview:self.imageView];
    }
    return (self);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.frame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    CGSize size = self.contentView.bounds.size;
    switch (self.imagePosition) {
        case SOImagePositionTop:{
            self.imageView.center = CGPointMake(size.width / 2.0f, self.imageSize.height / 2.0f);
            self.textLabel.frame = CGRectMake(0, self.imageSize.height + self.imageAndTextSpace, size.width, size.height - (self.imageSize.height + self.imageAndTextSpace));
        }break;
        case SOImagePositionBottom:{
            self.imageView.center = CGPointMake(size.width / 2.0f, size.height - self.imageSize.height / 2.0f);
            self.textLabel.frame = CGRectMake(0, 0, size.width, size.height - (self.imageSize.height + self.imageAndTextSpace));
        }break;
        case SOImagePositionLeft:{
            self.imageView.center = CGPointMake(self.imageSize.width / 2.0f, size.height / 2.0f);
            self.textLabel.frame = CGRectMake(self.imageSize.width + self.imageAndTextSpace, 0, size.width - (self.imageSize.width + self.imageAndTextSpace), size.height);
        }break;
        case SOImagePositionRight:{
            self.imageView.center = CGPointMake(size.width - self.imageSize.width / 2.0f, size.height / 2.0f);
            self.textLabel.frame = CGRectMake(0, 0, size.width - (self.imageSize.width + self.imageAndTextSpace), size.height);
        }break;
        case SOImagePositionHorizontalBothCenter:{
            CGSize textSize = [self.textLabel.text soSizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.textLabel.bounds)) lineBreakMode:self.textLabel.lineBreakMode];
            textSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
            self.imageView.frame = CGRectMake((size.width - (self.imageSize.width + textSize.width + self.imageAndTextSpace)) / 2.0f, (size.height - MAX(self.imageSize.height, textSize.height)) / 2.0f, self.imageSize.width, self.imageSize.height);
            self.textLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + self.imageAndTextSpace, 0, textSize.width, textSize.height);
            self.textLabel.centerY = self.imageView.centerY;
        }break;
        case SOImagePositionVerticalBothCenter:{
            CGSize textSize = [self.textLabel.text soSizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.textLabel.bounds)) lineBreakMode:self.textLabel.lineBreakMode];
            textSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
            self.imageView.size = self.imageSize;
            self.textLabel.size = textSize;
            self.imageView.top = 0;
            self.textLabel.top = self.imageView.bottom + self.imageAndTextSpace;
            self.textLabel.centerX = self.imageView.centerX = self.contentView.width / 2.0f;
        }break;
        case SOImagePositionBothRight:{
            CGSize textSize = [self.textLabel.text soSizeWithFont:self.textLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGRectGetHeight(self.textLabel.bounds)) lineBreakMode:self.textLabel.lineBreakMode];
            textSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
            self.textLabel.frame = CGRectMake(size.width - textSize.width, 0, textSize.width, textSize.height);
            self.imageView.frame = CGRectMake(CGRectGetMinX(self.textLabel.frame) - self.imageAndTextSpace - self.imageSize.width, 0, self.imageSize.width, self.imageSize.height);
            self.textLabel.centerY = self.imageView.centerY = size.height / 2.0f;
        }break;
        default:break;
    }
}

#pragma mark - setter
- (void)setContentInsets:(UIEdgeInsets)contentInsets {
    _contentInsets = contentInsets;
    [self setNeedsLayout];
}

- (void)setImageSize:(CGSize)imageSize {
    _imageSize = imageSize;
    self.imageView.frame = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
    [self setNeedsLayout];
}

- (void)setImagePosition:(SOImagePosition)imagePosition {
    _imagePosition = imagePosition;
    [self setNeedsLayout];
}
#pragma mark -

#pragma mark - getter
- (UIView *)contentView {
    if(!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.userInteractionEnabled = NO;
    }
    return (_contentView);
}

- (UILabel *)textLabel {
    if(!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.backgroundColor = [UIColor clearColor];
        _textLabel.textColor = [UIColor blackColor];
        _textLabel.font = [UIFont systemFontOfSize:14];
        _textLabel.textAlignment = NSTextAlignmentLeft;
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
