//
//  FilterMaskView.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTRectangle.h"


@interface PTRectangle (){
    UIBezierPath *path;
}

@end

@implementation PTRectangle

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.controlSurface addSubview:self.imageView];
        self.color = [UIColor redColor];
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    
}

-(void)drawRect:(CGRect)rect{
    [self.color setStroke];
    if (self.rectangleType == PTRectangleTypeStandardRect) {
        
        UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kControlPointRadius/2, kControlPointRadius/2, self.width-kControlPointRadius, self.height-kControlPointRadius) cornerRadius:4.0];
        aPath.lineWidth = 2;
        [aPath stroke];
    }else if (self.rectangleType == PTRectangleTypeOval){
        UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kControlPointRadius/2, kControlPointRadius/2, self.width-kControlPointRadius, self.height-kControlPointRadius)];
        aPath.lineWidth = 2;
        [aPath stroke];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    [self setNeedsDisplay];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    if (self.didUpdateFrame) {
        self.didUpdateFrame(self.tag);
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];
    CGFloat topClamp = 0;
    CGFloat bottomClamp = 0;
    CGFloat leftClamp = 0;
    CGFloat rightClamp = 0;
    if (self.top<0) {
        topClamp = -self.top;
    }
    if (self.bottom>self.clampSize.height) {
        bottomClamp =self.bottom-self.clampSize.height;
    }
    if (self.left<0) {
        leftClamp = -self.left;
    }
    if (self.right>self.clampSize.width) {
        rightClamp = self.right-self.clampSize.width;
    }
    self.imageView.frame = CGRectMake(-kControlPointRadius/2+leftClamp, -kControlPointRadius/2+topClamp, self.width-leftClamp-rightClamp, self.height-bottomClamp-topClamp);
    if (self.didUpdateFrame) {
        self.didUpdateFrame(self.tag);
    }
}


-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-kControlPointRadius/2, -kControlPointRadius/2, self.width, self.height)];
    }
    return _imageView;
}


@end
