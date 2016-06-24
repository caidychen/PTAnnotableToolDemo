//
//  FilterManager.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "FilterManager.h"

@implementation FilterManager

+(UIImage *)IOS7BlurredEffectWithImage:(UIImage *)image{
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    GPUImageiOSBlurFilter *iOSBlurFilter = [[GPUImageiOSBlurFilter alloc] init];
    iOSBlurFilter.downsampling = 5.0;               //The higher value, The faster process
    iOSBlurFilter.blurRadiusInPixels = 3.0;
    iOSBlurFilter.rangeReductionFactor = 0.0;
    [stillImageSource addTarget:iOSBlurFilter];
    GPUImageOutput *output = iOSBlurFilter;
    [output useNextFrameForImageCapture];
    [stillImageSource processImage];
    return [output imageFromCurrentFramebuffer];
}

+(UIImage *)pixellateEffectWithImage:(UIImage *)image{
    GPUImagePicture *stillImageSource = [[GPUImagePicture alloc] initWithImage:image];
    GPUImagePixellateFilter *pixellateFilter = [[GPUImagePixellateFilter alloc] init];
    pixellateFilter.fractionalWidthOfAPixel = 0.03;
    [stillImageSource addTarget:pixellateFilter];
    GPUImageOutput *output = pixellateFilter;
    [output useNextFrameForImageCapture];
    [stillImageSource processImage];
    return [output imageFromCurrentFramebuffer];
}

@end
