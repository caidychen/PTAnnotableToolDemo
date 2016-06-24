//
//  Arrow.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kArrowTailWith 4
#define kArrowHeadWidth 12
#define kArrowHeadLength 22

@interface Arrow : UIView

@property (nonatomic, assign) CGPoint parentStartPoint;
@property (nonatomic, assign) CGPoint parentEndPoint;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) CGFloat bearingDegrees;
-(void)updateBoundingBox;
@end
