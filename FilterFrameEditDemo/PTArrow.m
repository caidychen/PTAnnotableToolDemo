//
//  Arrow.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTArrow.h"
#import "UIBezierPath+dqd_arrowhead.h"


@implementation PTArrow{
    CGFloat tailWidth;
    CGFloat headWidth;
    CGFloat headLength;
    UIBezierPath *path;
}

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.color = [UIColor redColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    [self.color setFill];
    tailWidth = kArrowTailWith;
    headWidth = kArrowHeadWidth;
    headLength = kArrowHeadLength;
    switch (self.arrowType) {
        case PTArrowTypeStandardArrow:
        {
            path = [UIBezierPath dqd_bezierPathWithArrowFromPoint:(CGPoint)self.startPoint
                                                          toPoint:(CGPoint)self.endPoint
                                                        tailWidth:(CGFloat)tailWidth
                                                        headWidth:(CGFloat)headWidth
                                                       headLength:(CGFloat)headLength];
        }
            break;
        case PTArrowTypeSolidLine:{
            path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(self.startPoint.x, self.startPoint.y-1)];
            [path addLineToPoint:CGPointMake(self.endPoint.x, self.endPoint.y-1)];
            [path addLineToPoint:CGPointMake(self.endPoint.x, self.endPoint.y+1)];
            [path addLineToPoint:CGPointMake(self.startPoint.x, self.endPoint.y+1)];
        }
            break;
        default:
            break;
    }
    
    
    [path setLineWidth:2.0];
    [path stroke];
    [path fill];
    
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    [self setNeedsDisplay];
}


@end
