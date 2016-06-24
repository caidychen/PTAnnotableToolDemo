//
//  UIButton+SOButton.m
//  SOKit
//
//  Created by soso on 15-05-05.
//  Copyright (c) 2014-2015 soso All rights reserved.
//

#import "UIButton+SOButton.h"
#import <objc/runtime.h>

@implementation UIButton(SOButton)

+ (instancetype)buttonWithImage:(UIImage *)image {
    return ([self buttonWithImage:image selectedImage:nil highlightImage:nil disableImage:nil]);
}

+ (instancetype)buttonWithImage:(UIImage *)nImage
                  selectedImage:(UIImage *)sImage {
    return ([self buttonWithImage:nImage selectedImage:sImage highlightImage:nil disableImage:nil]);
}

+ (instancetype)buttonWithImage:(UIImage *)nImage
                  selectedImage:(UIImage *)sImage
                hightlightImage:(UIImage *)hImage {
    return ([self buttonWithImage:nImage selectedImage:sImage highlightImage:hImage disableImage:nil]);
}

+ (instancetype)buttonWithImage:(UIImage *)nImage
                  selectedImage:(UIImage *)sImage
                 highlightImage:(UIImage *)hImage
                   disableImage:(UIImage *)dImage {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if(nImage && [nImage isKindOfClass:[UIImage class]]) {
        [button setImage:nImage forState:UIControlStateNormal];
    }
    if(sImage && [sImage isKindOfClass:[UIImage class]]) {
        [button setImage:sImage forState:UIControlStateSelected];
    }
    if(hImage && [hImage isKindOfClass:[UIImage class]]) {
        [button setImage:hImage forState:UIControlStateHighlighted];
    }
    if(dImage && [dImage isKindOfClass:[UIImage class]]) {
        [button setImage:dImage forState:UIControlStateDisabled];
    }
    return (button);
}

- (instancetype)initWithImage:(UIImage *)image {
    return ([self initWithImage:image selectedImage:nil highlightImage:nil disableImage:nil]);
}

- (instancetype)initWithImage:(UIImage *)nImage
                selectedImage:(UIImage *)sImage {
    return ([self initWithImage:nImage selectedImage:sImage highlightImage:nil disableImage:nil]);
}

- (instancetype)initWithImage:(UIImage *)nImage
                selectedImage:(UIImage *)sImage
              hightlightImage:(UIImage *)hImage {
    return ([self initWithImage:nImage selectedImage:sImage highlightImage:hImage disableImage:nil]);
}

- (instancetype)initWithImage:(UIImage *)nImage
                selectedImage:(UIImage *)sImage
               highlightImage:(UIImage *)hImage
                 disableImage:(UIImage *)dImage {
    self = [super init];
    if(self) {
        if(nImage && [nImage isKindOfClass:[UIImage class]]) {
            [self setImage:nImage forState:UIControlStateNormal];
        }
        if(sImage && [sImage isKindOfClass:[UIImage class]]) {
            [self setImage:sImage forState:UIControlStateSelected];
        }
        if(hImage && [hImage isKindOfClass:[UIImage class]]) {
            [self setImage:hImage forState:UIControlStateHighlighted];
        }
        if(dImage && [dImage isKindOfClass:[UIImage class]]) {
            [self setImage:dImage forState:UIControlStateDisabled];
        }
    }
    return (self);
}

@end



#define KEY_ANIMATIONBUTTON_ANIMATION       @"keyAnimationButtonAnimation"
#define ANIMATIONBUTTON_ANIMATION_DURATION  0.5f

static NSString * const _KeySOAnimationButtonAnimating;
static NSString * const _KeySOAnimationButtonTimeInt;

@implementation UIButton (SORotationAnimatiion)

- (void)startAnimating {
    if([self isAnimating]) {
        return;
    }
    self.animating = YES;
    CAKeyframeAnimation *ani = [[CAKeyframeAnimation alloc] init];
    ani.keyPath = @"transform.rotation.z";
    ani.values = @[[NSNumber numberWithFloat:0],
                   [NSNumber numberWithFloat:M_PI_2],
                   [NSNumber numberWithFloat:M_PI],
                   [NSNumber numberWithFloat:M_PI + M_PI_2],
                   [NSNumber numberWithFloat:M_PI + M_PI]];
    ani.repeatCount = NSUIntegerMax;
    ani.duration = ANIMATIONBUTTON_ANIMATION_DURATION;
    [self.imageView.layer addAnimation:ani forKey:KEY_ANIMATIONBUTTON_ANIMATION];
    self.timeInt = [NSDate timeIntervalSinceReferenceDate];
}

- (void)stopAnimating {
    if(![self isAnimating]) {
        return;
    }
    //刚好转整数圈
    NSTimeInterval timeInt = [NSDate timeIntervalSinceReferenceDate];
    NSTimeInterval dis = (timeInt - self.timeInt);
    double offset = dis / ANIMATIONBUTTON_ANIMATION_DURATION;
    offset -= ((NSInteger)offset);
    NSTimeInterval delay = (1.0f - offset) * ANIMATIONBUTTON_ANIMATION_DURATION;
    [self.imageView.layer performSelector:@selector(removeAnimationForKey:) withObject:KEY_ANIMATIONBUTTON_ANIMATION afterDelay:delay];
    self.animating = NO;
}

- (BOOL)isAnimating {
    return ([self animating]);
}

#pragma mark -
- (BOOL)animating {
    id aObj = objc_getAssociatedObject(self, &_KeySOAnimationButtonAnimating);
    return ([aObj boolValue]);
}

- (void)setAnimating:(BOOL)animating {
    objc_setAssociatedObject(self, &_KeySOAnimationButtonAnimating, @(animating), OBJC_ASSOCIATION_RETAIN);
}

- (NSTimeInterval)timeInt {
    id aObj = objc_getAssociatedObject(self, &_KeySOAnimationButtonTimeInt);
    return ([aObj doubleValue]);
}

- (void)setTimeInt:(NSTimeInterval)timeInt {
    objc_setAssociatedObject(self, &_KeySOAnimationButtonTimeInt, @(timeInt), OBJC_ASSOCIATION_RETAIN);
}
#pragma mark -

@end

