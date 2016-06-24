//
//  SOTabBar.m
//  SOKit
//
//  Created by soso on 15/5/21.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOTabBar.h"
#import "SOGlobal.h"
#import "UIView+Additions.h"
#import "NSObject+SOObject.h"

@implementation SOTabBarItem
+ (instancetype)itemWithText:(NSString *)text
                       image:(NSString *)image
               selectedImage:(NSString *)selectedImage
                   textColor:(UIColor *)textColor
           selectedTextColor:(UIColor *)selectedTextColor
                   imageSize:(CGSize)imageSize
                        font:(UIFont *)font
                   alignment:(NSTextAlignment)alignment
                      insets:(UIEdgeInsets)insets {
    SOTabBarItem *item = [self item];
    item.text = text;
    item.imageName = image;
    item.selectedImageName = selectedImage;
    item.textColor = textColor;
    item.selectedTextColor = selectedTextColor;
    item.imageSize = imageSize;
    item.font = font;
    item.textAlignment = alignment;
    item.insets = insets;
    return (item);
}

- (void)dealloc {
    SORELEASE(_text);
    SORELEASE(_imageName);
    SORELEASE(_selectedImageName);
    SORELEASE(_textColor);
    SORELEASE(_selectedTextColor);
    SORELEASE(_font);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _text = nil;
        _imageName = nil;
        _selectedImageName = nil;
        _textColor = [UIColor blackColor];
        _selectedTextColor = [UIColor whiteColor];
        _imageSize = CGSizeMake(34, 25);
        _font = [UIFont systemFontOfSize:14];
        _textAlignment = NSTextAlignmentCenter;
        _insets = UIEdgeInsetsZero;
    }
    return (self);
}

- (NSString *)description {
    return ([[super description] stringByAppendingFormat:@"< %s; image = %@; selectedImage = %@; font = %@; text = %@; textAlignment = %@; >", object_getClassName(self), self.imageName, self.selectedImageName, self.font, self.text, [@(self.textAlignment) stringValue]]);
}

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    SOTabBarItem *item = [super copyWithZone:zone];
    item.text = self.text;
    item.imageName = self.imageName;
    item.selectedImageName = self.selectedImageName;
    item.textColor = self.textColor;
    item.selectedTextColor = self.selectedTextColor;
    item.imageSize = self.imageSize;
    item.font = self.font;
    item.textAlignment  = self.textAlignment;
    item.insets = self.insets;
    return (item);
}
#pragma mark -

@end


@interface SOTabBarItemView ()
@end

@implementation SOTabBarItemView
@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;

- (void)dealloc {
    SORELEASE(_imageView);
    SORELEASE(_titleLabel);
    SORELEASE(_item);
    SOSUPERDEALLOC();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        _didSelected = NO;
        _didHighlighted = NO;
        _item = nil;
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
    }
    return (self);
}

- (void)layoutSubviews {
    CGRect inFrame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    self.imageView.center = CGPointMake(CGRectGetMinX(inFrame) + CGRectGetWidth(inFrame) / 2.0f, CGRectGetMinY(inFrame) + (CGRectGetHeight(inFrame) * 0.6f) / 2.0f);
    self.titleLabel.frame = CGRectMake(CGRectGetMinX(inFrame), CGRectGetMaxY(self.imageView.frame), CGRectGetWidth(inFrame), CGRectGetHeight(inFrame) * 0.4f);
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
        _titleLabel.font = [UIFont systemFontOfSize:14];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return (_titleLabel);
}
#pragma mark -

#pragma mark - setter
- (void)setDidSelected:(BOOL)didSelected {
    _didSelected = didSelected;
    if(!self.item) {
        return;
    }
    self.titleLabel.textColor = [self isDidSelected] ? self.item.selectedTextColor : self.item.textColor;
    self.imageView.image = [UIImage imageNamed:([self isDidSelected] ? self.item.selectedImageName : self.item.imageName)];
}

- (void)setDidHighlighted:(BOOL)didHighlighted {
    _didHighlighted = didHighlighted;
    self.titleLabel.textColor = [self isDidHiglighted] ? self.item.selectedTextColor : self.item.textColor;
    self.imageView.image = [UIImage imageNamed:(self.didHighlighted ? self.item.selectedImageName : self.item.imageName)];
}

- (void)setItem:(SOTabBarItem *)item {
    SOTabBarItem *rtItem = SORETAIN(item);
    SORELEASE(_item);
    _item = rtItem;
    self.imageView.image = [UIImage imageNamed:([self isDidSelected] ? self.item.selectedImageName : self.item.imageName)];
    self.imageView.size = _item.imageSize;
    self.titleLabel.text = _item.text;
    self.titleLabel.font = _item.font;
    self.titleLabel.textAlignment = _item.textAlignment;
    self.contentInsets = _item.insets;
    [self setNeedsLayout];
}
#pragma mark -
@end


@interface SOTabBar () {
    NSUInteger _selectedIndex;
}
@property (assign, nonatomic) NSUInteger selectedIndex;
@property (strong, nonatomic) UIImageView *backgroundImageView;
@property (strong, nonatomic) NSMutableArray *itemViews;
@end


@implementation SOTabBar
@synthesize selectedIndex = _selectedIndex;
@synthesize backgroundImageView = _backgroundImageView;

- (void)dealloc {
    [self.itemViews removeAllObjects];
    SORELEASE(_backgroundImageView);
    SORELEASE(_itemViews);
    SOSUPERDEALLOC();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _selectedIndex = 0;
        _delegate = nil;
        _itemViews = [[NSMutableArray alloc] init];
        [self addSubview:self.backgroundImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.backgroundImageView.frame = self.bounds;
    CGRect inFrame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    NSInteger count = self.itemViews.count;
    if(count <= 0) {
        return;
    }
    CGFloat width = floorf(CGRectGetWidth(inFrame) / count);
    for(NSUInteger index = 0; index < count; index ++) {
        SOTabBarItemView *v = self.itemViews[index];
        v.frame = CGRectMake(index * width, 0, width, CGRectGetHeight(inFrame));
    }
}

#pragma mark - geter
- (UIImageView *)backgroundImageView {
    if(!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        _backgroundImageView.backgroundColor = [UIColor clearColor];
    }
    return (_backgroundImageView);
}

- (NSArray *)items {
    NSMutableArray *arr = [NSMutableArray array];
    for(SOTabBarItemView *v in self.itemViews) {
        if(v.item) {
            [arr addObject:v.item];
        }
    }
    return ([arr copy]);
}

- (NSUInteger)selectedIndex {
    return (_selectedIndex);
}

- (SOTabBarItemView *)tabBarItemViewAtIndex:(NSUInteger)index {
    return ([self.itemViews safeObjectAtIndex:index]);
}

- (UIImage *)backgroundImage {
    return (self.backgroundImageView.image);
}

- (SOTabBarItem *)selectedItem {
    if(!self.items || [self.items count] <= self.selectedIndex) {
        return (nil);
    }
    return (self.items[self.selectedIndex]);
}
#pragma mark -

#pragma mark - setter
- (void)setItems:(NSArray *)items {
    [self.itemViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.itemViews removeAllObjects];
    
    if(!items || [items count] == 0) {
        return;
    }
    
    CGRect inFrame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    CGFloat width = floorf(CGRectGetWidth(inFrame) / [items count]);
    
    for(NSUInteger index = 0; index < items.count; index ++) {
        SOTabBarItem *item = items[index];
        SOTabBarItemView *v = [[SOTabBarItemView alloc] initWithFrame:CGRectMake(index * width, 0, width, CGRectGetHeight(inFrame))];
        v.item = item;
        v.tag = index;
        v.didSelected = (index == self.selectedIndex);
        [v addTarget:self action:@selector(controlTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:v];
        [self.itemViews addObject:v];
    }
    [self setNeedsLayout];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    if(!self.itemViews || [self.itemViews count] <= self.selectedIndex) {
        return;
    }
    for(NSUInteger index = 0; index < self.itemViews.count; index ++) {
        SOTabBarItemView *itemView = self.itemViews[index];
        itemView.didSelected = (index == self.selectedIndex);
    }
}

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    self.backgroundImageView.image = backgroundImage;
}
#pragma mark -

#pragma mark - actions
- (void)controlTouched:(SOTabBarItemView *)control {
    self.selectedIndex = control.tag;
    if(self.delegate && [self.delegate respondsToSelector:@selector(SOTabBar:didSelectItem:)]) {
        [self.delegate SOTabBar:self didSelectItem:control.item];
    }
}
#pragma mark -

@end
