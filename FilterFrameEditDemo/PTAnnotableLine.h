//
//  PTAnnotableLine.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 27/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTAnnotableShapes.h"
#define kArrowControlWidth 16

@interface PTAnnotableLine : PTAnnotableShapes

@property (nonatomic, strong) UIView *controlHead;
@property (nonatomic, strong) UIView *controlTail;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) BOOL isDraggingTail;
@property (nonatomic, assign) BOOL isDraggingHead;
@property (nonatomic, assign) BOOL isDraggingSelf;
@property (nonatomic, assign) CGPoint parentStartPoint;
@property (nonatomic, assign) CGPoint parentEndPoint;
-(void)updateBoundingBox;

@end
