//
//  SOSegmentButton.m
//  SOKit
//
//  Created by soso on 13-2-21.
//  Copyright (c) 2013-2015 soso. All rights reserved.
//

#import "SOSegmentButton.h"
#import "SOSegmentControlItem.h"
#import "UIView+Additions.h"
#import "SOGlobal.h"

@interface SOSegmentButton ()
@property (assign, nonatomic) UIEdgeInsets titleEdgeInset;
@end

@implementation SOSegmentButton
@synthesize item = _item;
@synthesize titleLabel = _titleLabel;
@synthesize imageView = _imageView;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.titleEdgeInset = UIEdgeInsetsZero;
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    self.titleLabel.frame = UIEdgeInsetsInsetRect(self.bounds, self.titleEdgeInset);
    self.titleLabel.centerY = self.frame.size.height/2;
}

#pragma mark - setter
- (void)setItem:(SOSegmentControlItem *)item {
    SOSegmentControlItem *rtItem = SORETAIN(item);
    SORELEASE(_item);
    _item = rtItem;
    self.imageView.image = item.image;
    self.imageView.highlightedImage = item.highlightedImage;
    self.titleLabel.text = item.text;
    self.titleLabel.textColor = item.textColor;
    self.titleLabel.highlightedTextColor = item.highlightedTextColor;
    [self setNeedsLayout];
}

- (void)setDidHighlighted:(BOOL)didHighlighted {
    _didHighlighted = didHighlighted;
    self.titleLabel.highlighted = self.didHighlighted;
    self.imageView.highlighted = self.didHighlighted;
    self.titleLabel.font = (self.didHighlighted ? self.item.highlightedFont : self.item.font);
}
#pragma mark -

#pragma mark - getter
- (UILabel *)titleLabel {
    if(!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:15];
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return (_titleLabel);
}

- (UIImageView *)imageView {
    if(!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    return (_imageView);
}
#pragma mark -

@end
