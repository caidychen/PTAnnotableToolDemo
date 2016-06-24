//
//  Arrow.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "Arrow.h"
#import "UIBezierPath+dqd_arrowhead.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface Arrow ()
@property (nonatomic, assign) BOOL selected;

@end

@implementation Arrow{
    CGFloat tailWidth;
    CGFloat headWidth;
    CGFloat headLength;
    UIBezierPath *path;
}

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self setMultipleTouchEnabled:NO];
        [self setBackgroundColor:[UIColor clearColor]];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if (!self.selected) {
        [[UIColor clearColor] setStroke];
    }else{
        [[[UIColor blueColor] colorWithAlphaComponent:0.6] setStroke];
    }
    [[UIColor redColor] setFill];
    tailWidth = kArrowTailWith;
    headWidth = kArrowHeadWidth;
    headLength = kArrowHeadLength;
    path = [UIBezierPath dqd_bezierPathWithArrowFromPoint:(CGPoint)self.startPoint
                                                  toPoint:(CGPoint)self.endPoint
                                                tailWidth:(CGFloat)tailWidth
                                                headWidth:(CGFloat)headWidth
                                               headLength:(CGFloat)headLength];
    [path setLineWidth:2.0];
    [path stroke];
    [path fill];
    
}

//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"Tapped on arrow with tag %ld",(long)self.tag);
//    self.selected = YES;
//    [self setNeedsDisplay];
//}
//
////(x + r*sin(a), y + r*cos(a))
//
//-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    
//    CGPoint touchPoint = [[touches anyObject] locationInView:self];
//    
//    CGPoint previous = [[touches anyObject] previousLocationInView:self];
//    float deltaWidth = touchPoint.x - previous.x;
//    float deltaHeight = touchPoint.y - previous.y;
//        float radius = sqrtf(deltaWidth*deltaWidth+deltaHeight*deltaHeight);
//        NSLog(@"radius %f",radius);
//        CGPoint translatedPoint = CGPointMake(touchPoint.x+radius*sinf(self.bearingDegrees), touchPoint.y+radius*cosf(self.bearingDegrees));
//        float translatedDeltaWidth = translatedPoint.x - previous.x;
//        float translatedDeltaHeight = translatedPoint.y - previous.y;
//        NSLog(@"delta width %f, delta height %f",translatedDeltaWidth, translatedDeltaHeight);
//    NSLog(@"%@ %@",NSStringFromCGPoint(touchPoint),NSStringFromCGPoint(previous));
//    self.center = CGPointMake(self.center.x+deltaWidth, self.center.y+deltaHeight);
//        self.parentEndPoint = CGPointMake(self.parentEndPoint.x+deltaWidth, self.parentEndPoint.y+deltaHeight);
//        [self updateBoundingBox];
//    
//}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

-(void)updateBoundingBox{
    CGFloat f = [self pointPairToBearingDegrees:self.parentStartPoint secondPoint:self.parentEndPoint];
    CGFloat length = [self distanceBetweenPointA:self.parentStartPoint andPointB:self.parentEndPoint];
    self.frame = CGRectMake(self.parentStartPoint.x, self.parentStartPoint.y-15, length, 30);
    self.bearingDegrees = f;
    self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(f));
    self.layer.anchorPoint = CGPointMake(0, 0.5);
    CGRect bounds = self.bounds;
    bounds.size.height = 30;
    bounds.size.width = length;
    self.bounds = bounds;
    self.endPoint = CGPointMake(length, 15);
    [self setNeedsDisplay];
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

@end
