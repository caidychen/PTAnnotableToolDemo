//
//  FilterManager.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterManager : NSObject
+(UIImage *)IOS7BlurredEffectWithImage:(UIImage *)image;
+(UIImage *)pixellateEffectWithImage:(UIImage *)image;
@end
