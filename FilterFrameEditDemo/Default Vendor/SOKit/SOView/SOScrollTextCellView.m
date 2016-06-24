//
//  SoScrollTextCellView.m
//  SOKit
//
//  Created by Soal on 13-11-4.
//  Copyright (c) 2013-2015 chinaPnr. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "SOScrollTextCellView.h"
#import "SOGlobal.h"

@implementation SOScrollTextCellView
@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;
@synthesize textField = _textField;

- (void)dealloc {
    SORELEASE(_imageView);
    SORELEASE(_titleLabel);
    SORELEASE(_textField);
    SOSUPERDEALLOC();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.horizontalSpace = 10.0f;
        _titleWidth = 80.0f;
        _textWidth = 160.0f;
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.textField];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize bdSize = self.bounds.size;
    CGFloat height = bdSize.height - self.horizontalSpace * 2.0f;
    self.imageView.frame = CGRectMake(self.horizontalSpace, self.horizontalSpace, 0, 0);
    if(self.imageView.image) {
        self.imageView.frame = CGRectMake(self.horizontalSpace, self.horizontalSpace, height, height);
    }
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.imageView.frame) + self.horizontalSpace, self.horizontalSpace, _titleWidth, height);
    self.textField.frame = CGRectMake(CGRectGetMaxX(self.titleLabel.frame) + self.horizontalSpace, self.horizontalSpace, _textWidth, height);
}

#pragma mark - getter
- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return (_imageView);
}

- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return (_titleLabel);
}

- (UITextField *)textField {
    if(!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.backgroundColor = [UIColor clearColor];
        _textField.textColor = [UIColor blackColor];
        _textField.textAlignment = NSTextAlignmentLeft;
        _textField.font = [UIFont systemFontOfSize:14];
        _textField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    }
    return (_textField);
}
#pragma mark -

@end

