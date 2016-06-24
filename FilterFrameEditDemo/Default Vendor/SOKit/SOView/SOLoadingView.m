//
//  SOLoadingView.m
//  SOKit
//
//  Created by soso on 15/6/10.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOLoadingView.h"
#import "SOGlobal.h"

NSTimeInterval const SOLoadingViewDuration  = 1.0f;
CGSize SOLoadingSubViewSize  = (CGSize){.width = 38, .height = 38};


/**
 *  @brief  CALayer动画的key
 */
static NSString * const _KeySOLoadingAnimation  = @"KeyCCLoadingAnimation";

/**
 *  @brief  传入字符串text和大小size
 *
 *  @return 返回属性统一的UILable对象，返回的对象的引用计数为自动管理
 */
UILabel *SOCreateLoadingTextLabel(NSString *text, CGSize size) {
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    lb.backgroundColor = UIColorFromRGB(0xdf302f);
    lb.textColor = [UIColor whiteColor];
    lb.font = [UIFont boldSystemFontOfSize:16];
    lb.textAlignment = NSTextAlignmentCenter;
    lb.text = text;
    SOAUTORELEASE(lb);
    return (lb);
}


@interface SOLoadingView () {
    BOOL _animating;
}
@property (strong, nonatomic) NSMutableArray *textViews;
@end


@implementation SOLoadingView

- (void)dealloc {
    SORELEASE(_textViews);
    SORELEASE(_text);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithText:(NSString *)text {
    _text = [text copy];
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.userInteractionEnabled = NO;
        _hidesWhenStopped = YES;
        if(!_text || [_text length] == 0) {
            _text = [@"Loading" copy];
        }
        _textViews = [[NSMutableArray alloc] initWithCapacity:_text.length];
        for(NSUInteger index = 0; index < _text.length; index ++) {
            NSString *substring = [_text substringWithRange:NSMakeRange(index, 1)];
            UILabel *lb = SOCreateLoadingTextLabel(substring, CGSizeMake(SOLoadingSubViewSize.width * 0.6f, SOLoadingSubViewSize.height * 1.2f));
            lb.center = CGPointMake(SOLoadingSubViewSize.width * (0.5f + index), SOLoadingSubViewSize.height * 0.5f);
            lb.layer.transform = CATransform3DMakeScale(1, 0.6, 1);
            [_textViews addObject:lb];
            [self addSubview:lb];
        }
        self.size = CGSizeMake(SOLoadingSubViewSize.width * _text.length, SOLoadingSubViewSize.height);
    }
    return (self);
}

- (BOOL)isAnimating {
    return (_animating);
}

- (void)startAnimating {
    if(_animating) {
        return;
    }
    
    self.hidden = NO;
    
    CGSize size = self.bounds.size;
    CGFloat startTotalWidth = self.textViews.count * SOLoadingSubViewSize.width;
    CGFloat startSX = (size.width - startTotalWidth) / 2.0f;
    
    CGFloat of1 = 0.38f;
    CGFloat of2 = 0.6f;
    CGFloat of3 = 0.8f;
    
    for(NSUInteger index = 0; index < self.textViews.count; index ++) {
        UILabel *lb = self.textViews[index];
        
        CGPoint p0 = CGPointMake((size.width - self.textViews.count * SOLoadingSubViewSize.width * of1) / 2.0f + SOLoadingSubViewSize.width * 0.5f * of1 + SOLoadingSubViewSize.width * of1 * index, size.height * 0.5f);
        CGPoint p1 = CGPointMake((size.width - self.textViews.count * SOLoadingSubViewSize.width * of2) / 2.0f + SOLoadingSubViewSize.width * 0.5f * of2 + SOLoadingSubViewSize.width * of2 * index, size.height * 0.5f);
        CGPoint p2 = CGPointMake((size.width - self.textViews.count * SOLoadingSubViewSize.width * of3) / 2.0f + SOLoadingSubViewSize.width * 0.5f * of3 + SOLoadingSubViewSize.width * of3 * index, size.height * 0.5f);
        CGPoint p3 = CGPointMake(startSX + SOLoadingSubViewSize.width * 0.5f + SOLoadingSubViewSize.width * index, size.height * 0.5f);
        
        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.values = @[[NSValue valueWithCGPoint:p0],
                                     [NSValue valueWithCGPoint:p1],
                                     [NSValue valueWithCGPoint:p2],
                                     [NSValue valueWithCGPoint:p3],
                                     [NSValue valueWithCGPoint:p2],
                                     [NSValue valueWithCGPoint:p1],
                                     [NSValue valueWithCGPoint:p0]];
        
        CATransform3D t0 = CATransform3DMakeScale(1, 1, 1);
        CATransform3D t1 = CATransform3DMakeScale(0.9, 0.9, 1);
        CATransform3D t2 = CATransform3DMakeScale(0.75, 0.4, 1);
        CATransform3D t3 = CATransform3DMakeScale(0.8, 0.5, 1);
        
        CAKeyframeAnimation *scaleAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        scaleAnimation.values = @[[NSValue valueWithCATransform3D:t0],
                                  [NSValue valueWithCATransform3D:t1],
                                  [NSValue valueWithCATransform3D:t2],
                                  [NSValue valueWithCATransform3D:t3],
                                  [NSValue valueWithCATransform3D:t2],
                                  [NSValue valueWithCATransform3D:t1],
                                  [NSValue valueWithCATransform3D:t0]];
        
        CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
        animationGroup.repeatCount = NSUIntegerMax;
        animationGroup.duration = SOLoadingViewDuration;
        animationGroup.animations = @[positionAnimation, scaleAnimation];
        animationGroup.removedOnCompletion = NO;
        [lb.layer addAnimation:animationGroup forKey:_KeySOLoadingAnimation];
    }
    _animating = YES;
}

- (void)stopAnimating {
    if(self.hidesWhenStopped) {
        self.hidden = YES;
    }
    for(UILabel *lb in self.textViews) {
        [lb.layer removeAnimationForKey:_KeySOLoadingAnimation];
    }
    _animating = NO;
}

@end
