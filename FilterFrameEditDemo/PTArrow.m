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
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
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
    [super setSelected:selected];
    [self setNeedsDisplay];
}


@end
