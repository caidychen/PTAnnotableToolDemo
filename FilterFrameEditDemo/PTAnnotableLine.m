//
//  PTAnnotableLine.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 27/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTAnnotableLine.h"

#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)

@interface PTAnnotableLine ()

@property (nonatomic, assign) CGFloat bearingDegrees;

@end

@implementation PTAnnotableLine

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
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
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
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
    self.endPoint = CGPointMake(length-kArrowControlWidth, 15);
    
    self.bearingDegrees = f;
    self.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(f));
    self.layer.anchorPoint = CGPointMake(0, 0.5);
    CGRect bounds = self.bounds;
    bounds.size.height = 30;
    bounds.size.width = length;
    self.bounds = bounds;
    
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
        _controlHead = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kArrowControlWidth, kArrowControlWidth)];
        _controlHead.layer.cornerRadius = 8;
        _controlHead.backgroundColor = [UIColor blueColor];
        _controlHead.layer.borderColor = [UIColor whiteColor].CGColor;
        _controlHead.layer.borderWidth = 3;
        _controlHead.layer.masksToBounds = YES;
        _controlHead.hidden = YES;
        _controlHead.userInteractionEnabled = NO;
    }
    return _controlHead;
}

-(UIView *)controlTail{
    if (!_controlTail) {
        _controlTail = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kArrowControlWidth, kArrowControlWidth)];
        _controlTail.layer.cornerRadius = 8;
        _controlTail.backgroundColor = [UIColor blueColor];
        _controlTail.layer.borderColor = [UIColor whiteColor].CGColor;
        _controlTail.layer.borderWidth = 3;
        _controlTail.layer.masksToBounds = YES;
        _controlTail.hidden = YES;
        _controlTail.userInteractionEnabled = NO;
    }
    return _controlTail;
}

@end
