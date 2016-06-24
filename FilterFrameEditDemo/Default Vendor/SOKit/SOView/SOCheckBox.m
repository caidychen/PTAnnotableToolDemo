//
//  SoCheckBox.m
//  SOKit
//
//  Created by SoalHuang on 13-10-25.
//  Copyright (c) 2013-2015 chinaPnr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "SOCheckBox.h"
#import "NSString+SOAdditions.h"
#import "SOGlobal.h"

@interface SOCheckBox ()

/**
 *  @brief  原本的target
 */
@property (assign, nonatomic) id oldTarget;

/**
 *  @brief  原本的selector
 */
@property (assign, nonatomic) SEL oldAction;

/**
 *  @brief  选项的背景图片
 */
@property (retain, nonatomic) UIImageView *checkImgView;

@end

@implementation SOCheckBox
@synthesize checkImgView = _checkImgView;
@synthesize titleLabel = _titleLabel;

- (void)dealloc {
    SORELEASE(_titleLabel);
    SORELEASE(_checkImgView);
    SOSUPERDEALLOC();
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.horizontalSpace = 5.0f;
        self.contentInsets = UIEdgeInsetsMake(0, 5, 0, 5);
        self.imageSize = CGSizeMake(20, 20);
        [self addSubview:self.checkImgView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect inFrame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    self.checkImgView.frame = CGRectMake(self.contentInsets.left, 0, self.imageSize.width, self.imageSize.height);
    self.checkImgView.centerY = CGRectGetMidY(inFrame);
    CGFloat tlwd = CGRectGetWidth(inFrame) - (CGRectGetWidth(self.checkImgView.bounds) - self.horizontalSpace);
    CGSize lbSize = [self.titleLabel.text soSizeWithFont:self.titleLabel.font constrainedToWidth:tlwd lineBreakMode:NSLineBreakByCharWrapping];
    self.titleLabel.frame = CGRectMake(CGRectGetMaxX(self.checkImgView.frame) + self.horizontalSpace + self.contentInsets.right, CGRectGetMinY(inFrame), tlwd, MAX(lbSize.height, CGRectGetHeight(inFrame)));
    self.titleLabel.centerY = self.checkImgView.center.y;
}

#pragma mark - getter
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:self.checkImgView.bounds];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.numberOfLines = 0;
    }
    return (_titleLabel);
}

- (UIImageView *)checkImgView {
    if(!_checkImgView) {
        _checkImgView = [[UIImageView alloc] init];
        _checkImgView.backgroundColor = [UIColor clearColor];
    }
    return (_checkImgView);
}

- (UIImage *)imageForState:(SOCheckBoxState)state {
    switch(state) {
        case SOCheckBoxStateSelected:{
            return (self.checkImgView.highlightedImage);
        }break;
        case SOCheckBoxStateDeSelected:{
            return (self.checkImgView.image);
        }break;
        default:{
            return (nil);
        }break;
    }
}

- (NSString *)title {
    return (self.titleLabel.text);
}
#pragma mark -

#pragma mark - setter
- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.checkImgView.highlighted = _isSelected;
    self.titleLabel.highlighted = _isSelected;
}

- (void)setTitle:(NSString *)title font:(UIFont *)font {
    self.titleLabel.font = font;
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image forState:(SOCheckBoxState)state {
    switch(state) {
        case SOCheckBoxStateSelected:{
            self.checkImgView.highlightedImage = image;
        }break;
        case SOCheckBoxStateDeSelected:{
            self.checkImgView.image = image;
        }break;
        default:break;
    }
}
#pragma mark -

#pragma mark - actions
- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    SEL sl = @selector(exchangeAction:forControlEvents:);
    _oldTarget = target;
    _oldAction = action;
    [super addTarget:self action:sl forControlEvents:controlEvents];
}

- (void)exchangeAction:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    self.isSelected = !_isSelected;
    [self sendAction:_oldAction to:_oldTarget forEvent:nil];
}
#pragma mark -

@end
