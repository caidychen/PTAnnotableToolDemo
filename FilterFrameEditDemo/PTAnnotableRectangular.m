//
//  PTAnnotableRectangular.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 27/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTAnnotableRectangular.h"

@interface PTAnnotableRectangular (){
    CGPoint touchStart;
    BOOL isDraggingTopLeft;
    BOOL isDraggingTopRight;
    BOOL isDraggingBottomLeft;
    BOOL isDraggingBottomRight;
    BOOL isDraggingMySelf;
}

@end

@implementation PTAnnotableRectangular

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.controlSurface];
        self.controlSurface.layer.borderWidth = 1;
        self.controlSurface.layer.borderColor = [UIColor clearColor].CGColor;
        [self addSubview:self.controlPointTopLeft];
        [self addSubview:self.controlPointTopRight];
        [self addSubview:self.controlPointBottomLeft];
        [self addSubview:self.controlPointBottomRight];
        [self updateAllControlPoints];
    }
    return self;
}

-(void)updateAllControlPoints{
    self.controlPointTopLeft.center = CGPointMake(self.controlSurface.left, self.controlSurface.top);
    self.controlPointTopRight.center = CGPointMake(self.controlSurface.right, self.controlSurface.top);
    self.controlPointBottomLeft.center = CGPointMake(self.controlSurface.left, self.controlSurface.bottom);
    self.controlPointBottomRight.center = CGPointMake(self.controlSurface.right, self.controlSurface.bottom);
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.controlPointTopLeft.hidden = !selected;
    self.controlPointTopRight.hidden = !selected;
    self.controlPointBottomLeft.hidden = !selected;
    self.controlPointBottomRight.hidden = !selected;
    if (selected) {
        self.controlSurface.layer.borderColor = kControlColor.CGColor;
    }else{
        self.controlSurface.layer.borderColor = [UIColor clearColor].CGColor;
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.controlSurface.frame = CGRectMake(kControlPointRadius/2, kControlPointRadius/2, self.width-kControlPointRadius, self.height-kControlPointRadius);
    [self updateAllControlPoints];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    touchStart = [[touches anyObject] locationInView:self];
    CGFloat distA = [self distanceBetweenPointA:touchStart andPointB:CGPointZero];
    CGFloat distB = [self distanceBetweenPointA:touchStart andPointB:CGPointMake(self.width,0)];
    CGFloat distC = [self distanceBetweenPointA:touchStart andPointB:CGPointMake(0, self.height)];
    CGFloat distD = [self distanceBetweenPointA:touchStart andPointB:CGPointMake(self.width, self.height)];
    isDraggingTopLeft = NO;
    isDraggingTopRight = NO;
    isDraggingBottomLeft = NO;
    isDraggingBottomRight = NO;
    isDraggingMySelf = NO;
    
    if (distA<kCornerTouchThreshold) {
        isDraggingTopLeft = YES;
    }else if(distB<kCornerTouchThreshold){
        isDraggingTopRight = YES;
    }else if(distC<kCornerTouchThreshold){
        isDraggingBottomLeft = YES;
    }else if(distD<kCornerTouchThreshold){
        isDraggingBottomRight = YES;
    }else{
        isDraggingMySelf = YES;
    }
    
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint touchPoint = [[touches anyObject] locationInView:self];
    CGPoint previous = [[touches anyObject] previousLocationInView:self];
    float deltaWidth = touchPoint.x - previous.x;
    float deltaHeight = touchPoint.y - previous.y;
    CGFloat originX = self.left;
    CGFloat originY = self.top;
    
    if (self.width<=kCornerTouchThreshold) {
        self.width = kCornerTouchThreshold;
    }
    if (self.height<=kCornerTouchThreshold){
        self.height = kCornerTouchThreshold;
    }
    
    if (self.width>kCornerTouchThreshold) {
        originX = self.left +deltaWidth;
    }
    
    if (self.height>kCornerTouchThreshold){
        originY = self.top + deltaHeight;
    }
    
    if (self.width<=0) {
        self.left -=deltaWidth;
        deltaWidth = -deltaWidth;
    }
    if (self.height<=0) {
        self.height -=deltaHeight;
        deltaHeight = -deltaHeight;
    }
    if (isDraggingTopLeft) {
        self.frame = CGRectMake(originX, originY, self.width-deltaWidth, self.height-deltaHeight);
    }else if (isDraggingTopRight) {
        self.frame = CGRectMake(self.left, originY, self.width+deltaWidth, self.height-deltaHeight);
    }else if (isDraggingBottomLeft) {
        self.frame = CGRectMake(originX, self.top, self.width-deltaWidth, self.height+deltaHeight);
    }else if (isDraggingBottomRight) {
        self.frame = CGRectMake(self.left, self.top, self.width+deltaWidth, self.height+deltaHeight);
    }else{
        self.center = CGPointMake(self.center.x+deltaWidth, self.center.y+deltaHeight);
    }
    NSLog(@"%@",NSStringFromCGRect(self.frame));
    self.controlSurface.frame = CGRectMake(kControlPointRadius/2, kControlPointRadius/2, self.width-kControlPointRadius, self.height-kControlPointRadius);
    [self updateAllControlPoints];
}

-(CGFloat)distanceBetweenPointA:(CGPoint)pointA andPointB:(CGPoint)pointB{
    CGFloat dx = (pointB.x-pointA.x);
    CGFloat dy = (pointB.y-pointA.y);
    CGFloat dist = sqrt(dx*dx + dy*dy);
    return dist;
}


-(UIView *)controlSurface{
    if (!_controlSurface) {
        _controlSurface = [[UIView alloc] initWithFrame:CGRectMake(kControlPointRadius/2, kControlPointRadius/2, self.width-kControlPointRadius, self.height-kControlPointRadius)];
        _controlSurface.backgroundColor = [UIColor clearColor];
        _controlSurface.clipsToBounds = YES;
    }
    return _controlSurface;
}

-(UIView *)controlPointTopLeft{
    if (!_controlPointTopLeft) {
        _controlPointTopLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kControlPointRadius, kControlPointRadius)];
        _controlPointTopLeft.layer.cornerRadius = kControlPointRadius/2;
        _controlPointTopLeft.layer.masksToBounds = YES;
        _controlPointTopLeft.backgroundColor = kControlColor;
        _controlPointTopLeft.layer.borderColor = [UIColor whiteColor].CGColor;
        _controlPointTopLeft.layer.borderWidth = 3;
        _controlPointTopLeft.userInteractionEnabled = NO;
    }
    return _controlPointTopLeft;
}

-(UIView *)controlPointTopRight{
    if (!_controlPointTopRight) {
        _controlPointTopRight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kControlPointRadius, kControlPointRadius)];
        _controlPointTopRight.layer.cornerRadius = kControlPointRadius/2;
        _controlPointTopRight.layer.masksToBounds = YES;
        _controlPointTopRight.backgroundColor = kControlColor;
        _controlPointTopRight.layer.borderColor = [UIColor whiteColor].CGColor;
        _controlPointTopRight.layer.borderWidth = 3;
        _controlPointTopRight.userInteractionEnabled = NO;
    }
    return _controlPointTopRight;
}

-(UIView *)controlPointBottomLeft{
    if (!_controlPointBottomLeft) {
        _controlPointBottomLeft = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kControlPointRadius, kControlPointRadius)];
        _controlPointBottomLeft.layer.cornerRadius = kControlPointRadius/2;
        _controlPointBottomLeft.layer.masksToBounds = YES;
        _controlPointBottomLeft.backgroundColor = kControlColor;
        _controlPointBottomLeft.layer.borderColor = [UIColor whiteColor].CGColor;
        _controlPointBottomLeft.layer.borderWidth = 3;
        _controlPointBottomLeft.userInteractionEnabled = NO;
    }
    return _controlPointBottomLeft;
}

-(UIView *)controlPointBottomRight{
    if (!_controlPointBottomRight) {
        _controlPointBottomRight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kControlPointRadius, kControlPointRadius)];
        _controlPointBottomRight.layer.cornerRadius = kControlPointRadius/2;
        _controlPointBottomRight.layer.masksToBounds = YES;
        _controlPointBottomRight.backgroundColor = kControlColor;
        _controlPointBottomRight.layer.borderColor = [UIColor whiteColor].CGColor;
        _controlPointBottomRight.layer.borderWidth = 3;
        _controlPointBottomRight.userInteractionEnabled = NO;
    }
    return _controlPointBottomRight;
}

@end
