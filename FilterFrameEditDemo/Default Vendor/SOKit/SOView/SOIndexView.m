//
//  SOIndexView.m
//  SOKit
//
//  Created by soso on 15/5/20.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOIndexView.h"
#import "SOGlobal.h"
#import "NSString+SOAdditions.h"

@interface SOIndexView ()
@property (copy, nonatomic) NSString *key;
@end

@implementation SOIndexView
@synthesize indexLabel = _indexLabel;

- (void)dealloc {
    SORELEASE(_indexLabel);
    SORELEASE(_titles);
    SORELEASE(_key);
    SORELEASEBLOCK(_indexingBlock);
    SOSUPERDEALLOC();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _key = nil;
        self.indexingBlock = nil;
        [self addSubview:self.indexLabel];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGRect inFrame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    self.indexLabel.center = CGPointMake(CGRectGetWidth(inFrame) / 2.0f, CGRectGetHeight(inFrame) / 2.0f);
}

#pragma mark - getter
- (UILabel *)indexLabel {
    if(!_indexLabel) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.font = [UIFont systemFontOfSize:12];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.numberOfLines = 0;
    }
    return (_indexLabel);
}

- (UIColor *)textColor {
    return (self.indexLabel.textColor);
}

- (UIFont *)font {
    return (self.indexLabel.font);
}
#pragma mark -

#pragma mark - setter
- (void)setTextColor:(UIColor *)textColor {
    self.indexLabel.textColor = textColor;
}

- (void)setFont:(UIFont *)font {
    self.indexLabel.font = font;
}

- (void)setTitles:(NSArray *)titles {
    NSArray *cpTitles = [titles copy];
    SORELEASE(_titles);
    _titles = cpTitles;
    NSMutableString *mtlStr = [[NSMutableString alloc] init];
    if(!self.titles || [self.titles count] == 0) {
        return;
    }
    NSInteger count = [self.titles count];
    for(NSInteger index = 0; index < count; index ++) {
        if(index == 0) {
            [mtlStr appendString:self.titles[index]];
        } else {
            [mtlStr appendFormat:@"\n%@", self.titles[index]];
        }
    }
    self.indexLabel.text = mtlStr;
    mtlStr = nil;
    
    CGSize boundSize = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets).size;
    CGSize size = [self.indexLabel.text soSizeWithFont:self.indexLabel.font constrainedToSize:boundSize lineBreakMode:self.indexLabel.lineBreakMode];
    self.indexLabel.size = CGSizeMake(ceilf(size.width), ceilf(size.height));
    [self setNeedsLayout];
}
#pragma mark -

#pragma mark - actions
- (void)touchAtPostion:(CGPoint)postion {
    CGFloat height = CGRectGetHeight(self.indexLabel.bounds);
    if(height <= 0 || postion.y < 0) {
        self.key = nil;
        return;
    }
    NSUInteger totalCount = [self.titles count];
    NSUInteger index = totalCount * (postion.y / height);
    if(index >= [self.titles count]) {
        self.key = nil;
        return;
    }
    NSString *key = self.titles[index];
    if(!key) {
        self.key = key;
        return;
    }
    if(self.key && [self.key isEqualToString:key]) {
        return;
    }
    self.key = key;
    self.indexingBlock(self, index, self.key);
}
#pragma mark -

#pragma mark - touches
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.indexLabel];
    [self touchAtPostion:point];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.indexLabel];
    [self touchAtPostion:point];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.key = nil;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    self.key = nil;
}
#pragma mark -

@end
