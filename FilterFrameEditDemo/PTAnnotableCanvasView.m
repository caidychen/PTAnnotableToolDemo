//
//  PTAnnotableCanvasView.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 24/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTAnnotableCanvasView.h"
#import "Arrow.h"
#define kArrowChangeThreshold 20

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface PTAnnotableCanvasView (){
    CGPoint startPoint;
    CGPoint endPoint;
    Arrow *arrow;
    Arrow *selectedArrow;
    NSInteger arrowTag;
    BOOL drawing;
}

@property (nonatomic, strong) NSMutableArray *arrowGroup;


@end

@implementation PTAnnotableCanvasView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 2;
        arrow = [[Arrow alloc] initWithFrame:CGRectZero];
        [self addSubview:arrow];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UITouch* touchPoint = [touches anyObject];
    
    for(Arrow * currentArrow in self.arrowGroup){
        if (touchPoint.view == currentArrow) {
            NSLog(@"Arrow %ld touched",(long)currentArrow.tag);
            selectedArrow = currentArrow;
            //            selectedArrow.selected = !selectedArrow.selected;
            selectedArrow.isEditing = NO;
            arrow.hidden = YES;
            drawing = NO;
            CGPoint localPoint = [self convertPoint:[touchPoint locationInView:self] toView:selectedArrow];
            NSLog(@"local point %@",NSStringFromCGPoint(localPoint));
            CGFloat tailing = [self distanceBetweenPointA:localPoint andPointB:selectedArrow.endPoint];
            CGFloat leading = [self distanceBetweenPointA:localPoint andPointB:selectedArrow.startPoint];
            selectedArrow.isDraggingHead = NO;
            selectedArrow.isDraggingTail = NO;
            selectedArrow.isDraggingSelf = NO;
            if (tailing < kArrowChangeThreshold) {
                selectedArrow.isDraggingTail = YES;
            }else if (leading < kArrowChangeThreshold) {
                selectedArrow.isDraggingHead = YES;
            }else{
                selectedArrow.isDraggingSelf = YES;
            }
            
            return;
        }
    }
    
    startPoint = [touchPoint locationInView:self];
    endPoint = [touchPoint locationInView:self];
    arrow.parentStartPoint = startPoint;
    arrow.parentEndPoint = endPoint;
    arrow.startPoint = CGPointMake(0, 15);
    arrow.endPoint = CGPointMake(0, 15);
    arrow.hidden = NO;
    [arrow updateBoundingBox];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint = [touches anyObject];
    if (arrow.hidden) {
        CGPoint touchPoint = [[touches anyObject] locationInView:self];
        CGPoint previous = [[touches anyObject] previousLocationInView:self];
        float deltaWidth = touchPoint.x - previous.x;
        float deltaHeight = touchPoint.y - previous.y;
        
        if (selectedArrow.isDraggingTail) {
            selectedArrow.parentEndPoint = CGPointMake(selectedArrow.parentEndPoint.x+deltaWidth, selectedArrow.parentEndPoint.y+deltaHeight);
            [selectedArrow updateBoundingBox];
        }else if (selectedArrow.isDraggingHead) {
            selectedArrow.parentStartPoint = CGPointMake(selectedArrow.parentStartPoint.x+deltaWidth, selectedArrow.parentStartPoint.y+deltaHeight);
            [selectedArrow updateBoundingBox];
        }else{
            selectedArrow.center = CGPointMake(selectedArrow.center.x+deltaWidth, selectedArrow.center.y+deltaHeight);
            selectedArrow.parentStartPoint = CGPointMake(selectedArrow.parentStartPoint.x+deltaWidth, selectedArrow.parentStartPoint.y+deltaHeight);
            selectedArrow.parentEndPoint = CGPointMake(selectedArrow.parentEndPoint.x+deltaWidth, selectedArrow.parentEndPoint.y+deltaHeight);
        }
        
        
        
        selectedArrow.selected = YES;
        selectedArrow.isEditing = YES;
        
        return;
    }
    drawing = YES;
    endPoint = [touchPoint locationInView:self];
    arrow.parentStartPoint = startPoint;
    arrow.parentEndPoint = endPoint;
    [arrow updateBoundingBox];
    
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!drawing) {
        if (!selectedArrow.isEditing) {
            selectedArrow.selected = !selectedArrow.selected;
        }
        return;
    }
    drawing = NO;
    Arrow *copyOfView = [NSKeyedUnarchiver unarchiveObjectWithData:[NSKeyedArchiver archivedDataWithRootObject:arrow]];
    copyOfView.startPoint = arrow.startPoint;
    copyOfView.endPoint = arrow.endPoint;
    copyOfView.parentStartPoint = arrow.parentStartPoint;
    copyOfView.parentEndPoint = arrow.parentEndPoint;
    copyOfView.layer.anchorPoint = arrow.layer.anchorPoint;
    copyOfView.tag = arrowTag;
    copyOfView.bearingDegrees = arrow.bearingDegrees;
    [copyOfView setNeedsDisplay];
    [self.arrowGroup addObject:copyOfView];
    [self addSubview:copyOfView];
    arrow.hidden = YES;
    arrowTag++;
}

- (CGFloat) pointPairToBearingDegrees:(CGPoint)startingPoint secondPoint:(CGPoint) endingPoint
{
    CGPoint originPoint = CGPointMake(endingPoint.x - startingPoint.x, endingPoint.y - startingPoint.y); // get origin point to origin by subtracting end from start
    float bearingRadians = atan2f(originPoint.y, originPoint.x); // get bearing in radians
    float bearingDegrees = bearingRadians * (180.0 / M_PI); // convert to degrees
    bearingDegrees = (bearingDegrees > 0.0 ? bearingDegrees : (360.0 + bearingDegrees)); // correct discontinuity
    return bearingDegrees;
}

-(CGFloat)distanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB{
    CGFloat dx = (pointB.x-pointA.x);
    CGFloat dy = (pointB.y-pointA.y);
    CGFloat dist = sqrt(dx*dx + dy*dy);
    return dist;
}

-(NSMutableArray *)arrowGroup{
    if (!_arrowGroup) {
        _arrowGroup = [[NSMutableArray alloc] init];
    }
    return _arrowGroup;
}

@end
