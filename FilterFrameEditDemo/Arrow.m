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
        [self addSubview:self.controlHead];
        [self addSubview:self.controlTail];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    if (!self.selected) {
        [[UIColor clearColor] setStroke];
        self.controlTail.hidden = YES;
        self.controlHead.hidden = YES;
    }else{
        [[[UIColor blueColor] colorWithAlphaComponent:0.6] setStroke];
        self.controlTail.hidden = NO;
        self.controlHead.hidden = NO;
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

-(void)setSelected:(BOOL)selected{
    _selected = selected;
    [self setNeedsDisplay];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.controlTail.center = self.startPoint;
    self.controlHead.center =self.endPoint;
}

-(void)updateBoundingBox{
    CGFloat f = [self pointPairToBearingDegrees:self.parentStartPoint secondPoint:self.parentEndPoint];
    CGFloat length = [self distanceBetweenPointA:self.parentStartPoint andPointB:self.parentEndPoint];
    self.frame = CGRectMake(self.parentStartPoint.x, self.parentStartPoint.y-15, length, 30);
    self.endPoint = CGPointMake(length, 15);
    
    self.bearingDegrees = f;
    self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(f));
    self.layer.anchorPoint = CGPointMake(0, 0.5);
    CGRect bounds = self.bounds;
    bounds.size.height = 30;
    bounds.size.width = length;
    self.bounds = bounds;
    
    NSLog(@"endPoint %@ %@",NSStringFromCGPoint(self.endPoint),NSStringFromCGPoint(self.controlHead.center));
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

-(UIView *)controlHead{
    if (!_controlHead) {
        _controlHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        _controlHead.layer.cornerRadius = 8;
        _controlHead.backgroundColor = [UIColor blueColor];
        _controlHead.layer.borderColor = [UIColor whiteColor].CGColor;
        _controlHead.layer.borderWidth = 4;
        _controlHead.layer.masksToBounds = YES;
    }
    return _controlHead;
}

-(UIView *)controlTail{
    if (!_controlTail) {
        _controlTail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        _controlTail.layer.cornerRadius = 8;
        _controlTail.backgroundColor = [UIColor blueColor];
        _controlTail.layer.borderColor = [UIColor whiteColor].CGColor;
        _controlTail.layer.borderWidth = 4;
        _controlTail.layer.masksToBounds = YES;
    }
    return _controlTail;
}

@end
