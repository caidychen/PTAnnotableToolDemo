//
//  UIImage+SOImage.m
//  SOKit
//
//  Created by soso on 14-12-17.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "UIImage+SOImage.h"

@implementation UIImage(SOImage)

+ (instancetype)imageWithColor:(UIColor *)color size:(CGSize)size {
    return ([self imageWithBackgroundColor:color foregroundColor:nil path:NULL size:size lineWidth:0]);
}

+ (instancetype)imageWithBackgroundColor:(UIColor *)backgroundColor
                         foregroundColor:(UIColor *)foregroundColor
                                    path:(CGPathRef)path
                                    size:(CGSize)size
                               lineWidth:(CGFloat)lineWidth {
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    if(backgroundColor) {
        CGContextSetFillColorWithColor(context, backgroundColor.CGColor);
        CGContextFillPath(context);
    }
    if(foregroundColor) {
        CGContextSetStrokeColorWithColor(context, foregroundColor.CGColor);
    }
    if(path) {
        CGContextAddPath(context, path);
        CGContextStrokePath(context);
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return (image);
}

@end
