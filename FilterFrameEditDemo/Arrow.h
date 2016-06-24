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
#define kArrowControlWidth 16
@interface Arrow : UIView

@property (nonatomic, assign) CGPoint parentStartPoint;
@property (nonatomic, assign) CGPoint parentEndPoint;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint endPoint;
@property (nonatomic, assign) CGFloat bearingDegrees;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, assign) BOOL isDraggingTail;
@property (nonatomic, assign) BOOL isDraggingHead;
@property (nonatomic, assign) BOOL isDraggingSelf;
@property (nonatomic, strong) UIView *controlHead;
@property (nonatomic, strong) UIView *controlTail;

-(void)updateBoundingBox;
@end
