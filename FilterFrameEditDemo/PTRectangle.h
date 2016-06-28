//
//  FilterMaskView.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTAnnotableRectangular.h"
#import "PTMovebleTextView.h"

typedef void(^DidUpdateFrame)(NSInteger index);
typedef void(^Focused)();

typedef NS_ENUM(NSInteger, PTRectangleType){
    PTRectangleTypeFilterMask,
    PTRectangleTypeStandardRect,
    PTRectangleTypeRoundedRect,
    PTRectangleTypeOval,
    PTRectangleTypeTextView
};

@interface PTRectangle : PTAnnotableRectangular

@property (nonatomic, assign) PTRectangleType rectangleType;
@property (nonatomic, strong) PTMovebleTextView *textView;
@property (nonatomic, copy) DidUpdateFrame didUpdateFrame;
@property (nonatomic, copy) Focused tapFocused;
-(void)updateTextViewBoundingBoxWithTextView:(UITextView *)textView;
-(void)setImage:(UIImage *)image;
@end
