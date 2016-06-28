//
//  PTAnnotableCanvasView.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 24/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTAnnotableCanvasView.h"
#import "PTArrow.h"

#import "UIImage+PTImage.h"

#define kArrowChangeThreshold 32

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface PTAnnotableCanvasView (){
    CGPoint startPoint;
    CGPoint endPoint;
    
    PTAnnotableShapes *selectedShape;
    NSInteger shapeTag;
    
    BOOL drawing;
}

@property (nonatomic, strong) NSMutableArray *shapeGroup;
//@property (nonatomic, strong) Arrow *activeArrow;

@end

@implementation PTAnnotableCanvasView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.borderWidth = 2;
        
    }
    return self;
}

-(void)dropFilterMaskWithSourceImage:(UIImage *)sourceImage initialFrame:(CGRect)initialFrame type:(PTRectangleType)rectangleType{
    PTRectangle *maskView = [[PTRectangle alloc] initWithFrame:initialFrame];
    maskView.rectangleType = rectangleType;
    [self addSubview:maskView];
    maskView.clampSize = self.bounds.size;
    maskView.tag = shapeTag;
    
    maskView.didUpdateFrame = ^(NSInteger index){
        [self deselectEveryShapeExceptSelectedShape:NO];
        for(PTRectangle *maskView in self.shapeGroup){
            if (maskView.tag == index) {
                [maskView setImage:[sourceImage croppIngimageToRect:maskView.frame relativeToImageFrame:self.frame]];
                [self bringSubviewToFront:maskView];
                selectedShape = maskView;
                maskView.selected = YES;
            }
        }
    };
    maskView.tapFocused = ^(){
        selectedShape = maskView;
        
        [self deselectEveryShapeExceptSelectedShape:YES];
    };
    [self.shapeGroup safeAddObject:maskView];
    maskView.didUpdateFrame(maskView.tag);
    shapeTag++;
}

-(void)deselectEveryShapeExceptSelectedShape:(BOOL)exceptSelected{
    for(PTAnnotableShapes * currentShape in self.shapeGroup){
        if (currentShape != selectedShape) {
            currentShape.selected = NO;
        }else{
            if (!exceptSelected) {
                currentShape.selected = NO;
                if ([currentShape isKindOfClass:[PTRectangle class]]) {
                    PTRectangle *rectangle = (PTRectangle *)currentShape;
                    if (rectangle.rectangleType == PTRectangleTypeTextView) {
                        [rectangle.textView resignFirstResponder];
                    }
                }
            }
        }
    }
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //[self startDrawingArrow:touches withEvent:event];
    [self startDrawingRectangle:touches withEvent:event];
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //[self continueDrawingArrow:touches withEvent:event];
    [self continueDrawingRectangle:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    //[self endDrawingArrow:touches withEvent:event];
    BOOL drawingSuccess;
    drawingSuccess = [self endDrawingRectangle:touches withEvent:event];
    if (!drawingSuccess) {
        [self deselectEveryShapeExceptSelectedShape:NO];
    }
}

-(void)startDrawingRectangle:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    startPoint = touchPoint;
    [self dropFilterMaskWithSourceImage:nil initialFrame:CGRectZero type:PTRectangleTypeTextView];
    PTRectangle *activeRectangle = [self.shapeGroup lastObject];
    activeRectangle.hidden = NO;
    if (activeRectangle.rectangleType == PTRectangleTypeTextView) {
        activeRectangle.selected = YES;
    }
    
    activeRectangle.frame = CGRectMake(startPoint.x, startPoint.y, 20, 20);
}

-(void)continueDrawingRectangle:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    PTAnnotableRectangular *activeRectangle = [self.shapeGroup lastObject];
    activeRectangle.userInteractionEnabled = NO;
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    CGPoint previous = [[touches anyObject] previousLocationInView:self];
    float deltaWidth = touchPoint.x - previous.x;
    float deltaHeight = touchPoint.y - previous.y;
    drawing = YES;
    
    activeRectangle.frame = CGRectMake(startPoint.x, startPoint.y, activeRectangle.width+deltaWidth, activeRectangle.height+deltaHeight);
    NSLog(@"%@",NSStringFromCGRect(activeRectangle.frame));
}

-(BOOL)endDrawingRectangle:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    drawing = NO;
    PTRectangle *activeRectangle = [self.shapeGroup lastObject];
    if (activeRectangle.width<kCornerTouchThreshold||activeRectangle.height<kCornerTouchThreshold) {
        [activeRectangle removeFromSuperview];
        [self.shapeGroup removeLastObject];
        NSLog(@"Rectangle too small, abort drawing...");
        return NO;
    }
    activeRectangle.userInteractionEnabled = YES;
    activeRectangle.selected = YES;
    selectedShape = activeRectangle;
    if (activeRectangle.rectangleType == PTRectangleTypeTextView) {
        activeRectangle.textView.hidden = NO;
        [activeRectangle.textView becomeFirstResponder];
    }
    return YES;
}

-(void)startDrawingArrow:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint = [touches anyObject];
    
    // Check if user is tapping on existing arrow on the canvas
    for(PTArrow * currentArrow in self.shapeGroup){
        if (touchPoint.view == currentArrow) {
            NSLog(@"Arrow %ld touched",(long)currentArrow.tag);
            selectedShape = currentArrow;
            selectedShape.isEditing = NO;
            PTArrow *selectedArrow = (PTArrow *)selectedShape;
            
            drawing = NO;
            CGPoint localPoint = [self convertPoint:[touchPoint locationInView:self] toView:selectedShape];
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
            selectedShape = nil;
            
        }
    }
    [self deselectEveryShapeExceptSelectedShape:YES];
    [self bringSubviewToFront:selectedShape];
    
    if (selectedShape) {
        // if user is about to edit exsiting shape, abort new shape creation...
        return;
    }
    
    NSLog(@"Attempting to draw new arrow...");
    drawing = YES;
    PTArrow * _activeArrow = [[PTArrow alloc] initWithFrame:CGRectZero];
    _activeArrow.arrowType = PTArrowTypeStandardArrow;
    _activeArrow.tag = shapeTag;
    // User is tapping on empty space, that means they are ready to draw a new arrow
    startPoint = [touchPoint locationInView:self];
    endPoint = [touchPoint locationInView:self];
    _activeArrow.parentStartPoint = startPoint;
    _activeArrow.parentEndPoint = endPoint;
    _activeArrow.startPoint = CGPointMake(kArrowControlWidth/2, 15);
    _activeArrow.endPoint = CGPointMake(kArrowControlWidth/2, 15);
    _activeArrow.hidden = NO;
    [_activeArrow updateBoundingBox];
    
    [self.shapeGroup addObject:_activeArrow];
    [self addSubview:_activeArrow];
}

-(void)continueDrawingArrow:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch* touchPoint = [touches anyObject];
    // If new arrow is not being drawn, that means user is editing selected arrow
    
    PTArrow *selectedArrow = (PTArrow *)selectedShape;
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
    PTAnnotableLine *_activeArrow = [self.shapeGroup lastObject];
    drawing = YES;
    endPoint = [touchPoint locationInView:self];
    _activeArrow.parentStartPoint = startPoint;
    _activeArrow.parentEndPoint = endPoint;
    [_activeArrow updateBoundingBox];
    
}

-(BOOL)endDrawingArrow:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    // If user finished editing current arrow, return.
    if (!drawing) {
        
        if (!selectedShape.isEditing) {
            if (!selectedShape.selected) {
                selectedShape.selected = !selectedShape.selected;
            }
        }
        return YES;
    }
    
    // If the new arrow is too short, discard it.
    PTAnnotableLine *_activeArrow = [self.shapeGroup lastObject];
    if (_activeArrow.endPoint.x < kArrowHeadLength) {
        [_activeArrow removeFromSuperview];
        [self.shapeGroup removeLastObject];
        NSLog(@"Arrow too short, abort drawing...");
        return NO;
    }
    _activeArrow.selected = YES;
    selectedShape = _activeArrow;
    drawing = NO;
    shapeTag++;
    return YES;
}

-(void)deleteSelectedShape{
    if (selectedShape) {
        [selectedShape removeFromSuperview];
        [self.shapeGroup removeObject:selectedShape];
        selectedShape = nil;
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

-(NSMutableArray *)shapeGroup{
    if (!_shapeGroup) {
        _shapeGroup = [[NSMutableArray alloc] init];
    }
    return _shapeGroup;
}

@end
