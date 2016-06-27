//
//  FilterMaskView.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTAnnotableRectangular.h"

typedef void(^DidUpdateFrame)(NSInteger index);

typedef NS_ENUM(NSInteger, PTRectangleType){
    PTRectangleTypeFilterMask,
    PTRectangleTypeStandardRect,
    PTRectangleTypeRoundedRect,
    PTRectangleTypeOval,
};

@interface PTRectangle : PTAnnotableRectangular

@property (nonatomic, assign) PTRectangleType rectangleType;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) DidUpdateFrame didUpdateFrame;
@end
