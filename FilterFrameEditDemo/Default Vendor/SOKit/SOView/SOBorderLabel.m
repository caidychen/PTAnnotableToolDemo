//
//  SOBorderLabel.m
//  SOKit
//
//  Created by soso on 14-7-25.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBorderLabel.h"
#import "SOGlobal.h"

UIBezierPath * borderLinePathWithSize(CGSize size, SOBorderLineStyle style, UIRectCorner corner, CGSize radii) {
    UIBezierPath *path = [UIBezierPath bezierPath];
    if(SOBorder_Line_Top == (SOBorder_Line_Top & style)) {
        [path moveToPoint:CGPointMake(0, 0)];
        [path addLineToPoint:CGPointMake(size.width, 0)];
    }
    if(SOBorder_Line_Right == (SOBorder_Line_Right & style)) {
        [path moveToPoint:CGPointMake(size.width, 0)];
        [path addLineToPoint:CGPointMake(size.width, size.height)];
    }
    if(SOBorder_Line_Bottom == (SOBorder_Line_Bottom & style)) {
        [path moveToPoint:CGPointMake(size.width, size.height)];
        [path addLineToPoint:CGPointMake(0, size.height)];
    }
    if(SOBorder_Line_Left == (SOBorder_Line_Left & style)) {
        [path moveToPoint:CGPointMake(0, size.height)];
        [path addLineToPoint:CGPointMake(0, 0)];
    }
    
    if(corner == 0) {
        return (path);
    }
    
    if((UIRectCornerTopLeft == (UIRectCornerTopLeft & corner)) && (SOBorder_Line_Top == (SOBorder_Line_Top & style)) && (SOBorder_Line_Left == (SOBorder_Line_Left & style))) {
        [path moveToPoint:CGPointMake(0, radii.height)];
        [path addQuadCurveToPoint:CGPointMake(radii.width, 0) controlPoint:CGPointMake(0.5, 0.5)];
    }
    
    if((UIRectCornerTopRight == (UIRectCornerTopRight & corner)) && (SOBorder_Line_Top == (SOBorder_Line_Top & style)) && (SOBorder_Line_Right == (SOBorder_Line_Right & style))) {
        [path moveToPoint:CGPointMake(size.width - radii.width, 0)];
        [path addQuadCurveToPoint:CGPointMake(size.width, radii.height) controlPoint:CGPointMake(size.width - 0.5, 0.5)];
    }
    
    if((UIRectCornerBottomLeft == (UIRectCornerBottomLeft & corner)) && (SOBorder_Line_Bottom == (SOBorder_Line_Bottom & style)) && (SOBorder_Line_Left == (SOBorder_Line_Left & style))) {
        [path moveToPoint:CGPointMake(radii.width, size.height)];
        [path addQuadCurveToPoint:CGPointMake(0, size.height - radii.height) controlPoint:CGPointMake(0.5, size.height - 0.5)];
    }
    
    if((UIRectCornerBottomRight == (UIRectCornerBottomRight & corner)) && (SOBorder_Line_Bottom == (SOBorder_Line_Bottom & style)) && (SOBorder_Line_Right == (SOBorder_Line_Right & style))) {
        [path moveToPoint:CGPointMake(size.width, size.height - radii.height)];
        [path addQuadCurveToPoint:CGPointMake(size.width - radii.width, size.height) controlPoint:CGPointMake(size.width - 0.5, size.height - 0.5)];
    }
    return (path);
}

@implementation SOBorderLabel

- (void)dealloc {
    SORELEASE(_borderColor);
    SOSUPERDEALLOC();
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.01];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    UIBezierPath *linePath = borderLinePathWithSize(self.bounds.size, _borderStyle, _corner, _radii);
    linePath.lineWidth = _borderLineWidth;
    if(_borderColor && linePath && !CGPathIsEmpty(linePath.CGPath)) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        UIGraphicsPushContext(context);
        CGContextSetLineWidth(context, _borderLineWidth);
        CGContextSetFillColorWithColor(context, [self backgroundColor].CGColor);
        CGContextSetStrokeColorWithColor(context, _borderColor.CGColor);
        CGContextAddPath(context, linePath.CGPath);
        CGContextStrokePath(context);
        UIGraphicsPopContext();
    }
    
    if(_radii.width == 0 || _radii.height == 0) {
        return;
    }
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:_corner cornerRadii:_radii];
    if(![maskPath isEmpty]) {
        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

@end
