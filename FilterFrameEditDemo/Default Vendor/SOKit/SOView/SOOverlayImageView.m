//
//  SOOverlayImageView.m
//  SOKit
//
//  Created by soso on 15-2-8.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOOverlayImageView.h"
#import "UIView+Additions.h"
#import "NSObject+SOObject.h"
#import "SOGlobal.h"

@interface SOOverlayImageView ()
@property (strong, nonatomic) NSMutableArray *imageViews;
@end


@implementation SOOverlayImageView

- (void)dealloc {
    [self.imageViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    SORELEASE(_imageViews);
    SORELEASE(_images);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _arrowType = SOOverlayImageViewSubArrowTypeDown;
        _unitImageSize = CGSizeMake(10, 10);
        _unitImageSpace = 2.0f;
        _imageCorner = 0;
        _images = nil;
        _imageViews = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if(!_imageViews || [_imageViews count] == 0) {
        return;
    }
    NSUInteger imageViewsCount = _imageViews.count;
    switch (_alwaysBounce) {
        case SOOverlayImagesAlwaysBounceVertical:{
            for(NSUInteger index = 0; index < imageViewsCount; index ++) {
                UIImageView *imgVw = [_imageViews safeObjectAtIndex:index];
                if(!imgVw || ![imgVw isKindOfClass:[UIImageView class]]) {
                    continue;
                }
                CGFloat y = index * (_unitImageSize.height + _unitImageSpace);
                imgVw.frame = CGRectMake(0, y, _unitImageSize.width, _unitImageSize.height);
                imgVw.centerX = CGRectGetWidth(self.bounds) / 2.0f;
            }
        }break;
            
        case SOOverlayImagesAlwaysBounceHorizontal:{
            for(NSInteger index = imageViewsCount - 1; index >= 0; index --) {
                UIImageView *imgVw = [_imageViews safeObjectAtIndex:index];
                if(!imgVw || ![imgVw isKindOfClass:[UIImageView class]]) {
                    continue;
                }
                CGFloat x = index * (_unitImageSize.width + _unitImageSpace);
                imgVw.frame = CGRectMake(x, 0, _unitImageSize.width, _unitImageSize.height);
                imgVw.centerY = CGRectGetHeight(self.bounds) / 2.0f;
            }
        }break;
            
        default:
            break;
    }
    switch (_arrowType) {
        case SOOverlayImageViewSubArrowTypeUp:{
            for(NSUInteger index = 0; index < imageViewsCount; index ++) {
                UIImageView *imgVw = [_imageViews safeObjectAtIndex:index];
                if(!imgVw || ![imgVw isKindOfClass:[UIImageView class]]) {
                    continue;
                }
                [self bringSubviewToFront:imgVw];
            }
        }break;
        case SOOverlayImageViewSubArrowTypeDown:{
            for(NSInteger index = imageViewsCount - 1; index >= 0; index --) {
                UIImageView *imgVw = [_imageViews safeObjectAtIndex:index];
                if(!imgVw || ![imgVw isKindOfClass:[UIImageView class]]) {
                    continue;
                }
                [self bringSubviewToFront:imgVw];
            }
        }break;
        default:break;
    }
}

- (void)displayAllImageView {
    
    [_imageViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_imageViews removeAllObjects];
    
    NSUInteger imagesCount = _images.count;
    for(NSUInteger index = 0; index < _unitCount; index ++) {
        @autoreleasepool {
            UIImageView *imgVw = [[UIImageView alloc] init];
            imgVw.layer.cornerRadius = self.imageCorner;
            imgVw.clipsToBounds = YES;
            imgVw.image = [UIImage imageNamed:[_images safeObjectAtIndex:(index % imagesCount)]];
            [self addSubview:imgVw];
            [_imageViews addObject:imgVw];
        }
    }
    [self setNeedsLayout];
}

- (void)setImages:(NSArray *)images {
    NSArray *cpImages = [images copy];
    SORELEASE(_images);
    _images = cpImages;
    _unitCount = [_images count];
    [self displayAllImageView];
}

@end
