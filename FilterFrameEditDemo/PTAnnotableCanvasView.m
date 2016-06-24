//
//  PTAnnotableCanvasView.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 24/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTAnnotableCanvasView.h"
#import "Arrow.h"
#define kArrowChangeThreshold 32

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface PTAnnotableCanvasView (){
    CGPoint startPoint;
    CGPoint endPoint;
    
    Arrow *selectedArrow;
    NSInteger arrowTag;
    BOOL drawing;
}

@property (nonatomic, strong) NSMutableArray *arrowGroup;
//@property (nonatomic, strong) Arrow *activeArrow;

@end

@implementation PTAnnotableCanvasView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 2;
        //        _activeArrow = [[Arrow alloc] initWithFrame:CGRectZero];
        //        [self addSubview:_activeArrow];
    }
    return self;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self startDrawingArrow:touches withEvent:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self continueDrawingArrow:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self endDrawingArrow:touches withEvent:event];
}

-(void)startDrawingArrow:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint = [touches anyObject];
    
    // Check if user is tapping on existing arrow on the canvas
    for(Arrow * currentArrow in self.arrowGroup){
        if (touchPoint.view == currentArrow) {
            NSLog(@"Arrow %ld touched",(long)currentArrow.tag);
            selectedArrow = currentArrow;
            selectedArrow.isEditing = NO;
            //            _activeArrow.hidden = YES;
            drawing = NO;
            CGPoint localPoint = [self convertPoint:[touchPoint locationInView:self] toView:selectedArrow];
            CGFloat tailing = [self distanceBetweenPointA:localPoint andPointB:selectedArrow.endPoint];
            CGFloat leading = [self distanceBetweenPointA:localPoint andPointB:selectedArrow.startPoint];
            selectedArrow.isDraggingHead = NO;
            selectedArrow.isDraggingTail = NO;
            selectedArrow.isDraggingSelf = NO;
            
            //check if user is dragging its head, tail or the body itself
            if (tailing < kArrowChangeThreshold) {
                selectedArrow.isDraggingTail = YES;
            }else if (leading < kArrowChangeThreshold) {
                selectedArrow.isDraggingHead = YES;
            }else{
                selectedArrow.isDraggingSelf = YES;
            }
            
            break;
        }else{
            selectedArrow = nil;
            
        }
    }
    for(Arrow * currentArrow in self.arrowGroup){
        if (currentArrow != selectedArrow) {
            currentArrow.selected = NO;
        }
    }
    if (selectedArrow) {
        return;
    }
    
    NSLog(@"Attempting to draw new arrow...");
    drawing = YES;
    Arrow * _activeArrow = [[Arrow alloc] initWithFrame:CGRectZero];
    _activeArrow.tag = arrowTag;
    // User is tapping on empty space, that means they are ready to draw a new arrow
    startPoint = [touchPoint locationInView:self];
    endPoint = [touchPoint locationInView:self];
    _activeArrow.parentStartPoint = startPoint;
    _activeArrow.parentEndPoint = endPoint;
    _activeArrow.startPoint = CGPointMake(kArrowControlWidth/2, 15);
    _activeArrow.endPoint = CGPointMake(kArrowControlWidth/2, 15);
    _activeArrow.hidden = NO;
    [_activeArrow updateBoundingBox];
    
    [self.arrowGroup addObject:_activeArrow];
    [self addSubview:_activeArrow];
}

-(void)continueDrawingArrow:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint = [touches anyObject];
    // If new arrow is not being drawn, that means user is editing selected arrow
    
    if (selectedArrow) {
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
    
    // Otherwise, draw a new arrow
    Arrow *_activeArrow = [self.arrowGroup lastObject];
    drawing = YES;
    endPoint = [touchPoint locationInView:self];
    _activeArrow.parentStartPoint = startPoint;
    _activeArrow.parentEndPoint = endPoint;
    [_activeArrow updateBoundingBox];
    
}

-(void)endDrawingArrow:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // If user finished editing current arrow, return.
    if (!drawing) {
        
        if (!selectedArrow.isEditing) {
            selectedArrow.selected = !selectedArrow.selected;
        }
        return;
    }
    
    // If the new arrow is too short, discard it.
    Arrow *_activeArrow = [self.arrowGroup lastObject];
    if (_activeArrow.endPoint.x < kArrowHeadLength) {
        [_activeArrow removeFromSuperview];
        [self.arrowGroup removeLastObject];
        NSLog(@"Arrow too short, abort drawing...");
        return;
    }
    _activeArrow.selected = YES;
    selectedArrow = _activeArrow;
    drawing = NO;
    arrowTag++;
}

-(void)deleteSelectedShape{
    if (selectedArrow) {
        [selectedArrow removeFromSuperview];
        [self.arrowGroup removeObject:selectedArrow];
        selectedArrow = nil;
    }
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
