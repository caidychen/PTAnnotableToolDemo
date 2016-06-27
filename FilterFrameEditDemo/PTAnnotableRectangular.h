//
//  PTAnnotableRectangular.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 27/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTAnnotableShapes.h"
#define kCornerTouchThreshold 30
#define kControlPointRadius 16

@interface PTAnnotableRectangular : PTAnnotableShapes

@property (nonatomic, strong) UIView *controlSurface;
@property (nonatomic, strong) UIView *controlPointTopLeft;
@property (nonatomic, strong) UIView *controlPointTopRight;
@property (nonatomic, strong) UIView *controlPointBottomLeft;
@property (nonatomic, strong) UIView *controlPointBottomRight;
@property (nonatomic, assign) CGSize clampSize;

-(void)updateAllControlPoints;
@end
