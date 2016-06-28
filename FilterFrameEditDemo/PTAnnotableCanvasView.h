//
//  PTAnnotableCanvasView.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 24/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTRectangle.h"

@interface PTAnnotableCanvasView : UIView
-(void)deleteSelectedShape;
-(void)dropFilterMaskWithSourceImage:(UIImage *)sourceImage initialFrame:(CGRect)initialFrame type:(PTRectangleType)rectangleType;
@end
