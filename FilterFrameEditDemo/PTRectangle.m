//
//  FilterMaskView.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTRectangle.h"


@interface PTRectangle ()<UITextViewDelegate,PTMovebleTextViewDelegate>{
    UIBezierPath *path;
}
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation PTRectangle

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.controlSurface addSubview:self.imageView];
        [self.controlSurface addSubview:self.textView];
        self.color = [UIColor redColor];
        
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    //    self.textView.userInteractionEnabled = selected;
}

-(void)setColor:(UIColor *)color{
    [super setColor:color];
    self.textView.textColor = color;
    [[UITextView appearance] setTintColor:color];
}

-(void)setImage:(UIImage *)image{
    self.imageView.image = image;
}

-(void)setRectangleType:(PTRectangleType)rectangleType{
    _rectangleType = rectangleType;
    if (rectangleType == PTRectangleTypeTextView) {
        self.textView.hidden = NO;
    }
}

-(void)drawRect:(CGRect)rect{
    [self.color setStroke];
    if (self.rectangleType == PTRectangleTypeStandardRect) {
        
        UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kControlPointRadius/2, kControlPointRadius/2, self.width-kControlPointRadius, self.height-kControlPointRadius) cornerRadius:0.0];
        aPath.lineWidth = 2;
        [aPath stroke];
    }else if (self.rectangleType == PTRectangleTypeRoundedRect) {
        UIBezierPath *aPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(kControlPointRadius/2, kControlPointRadius/2, self.width-kControlPointRadius, self.height-kControlPointRadius) cornerRadius:4.0];
        aPath.lineWidth = 2;
        [aPath stroke];
    }
    else if (self.rectangleType == PTRectangleTypeOval){
        UIBezierPath *aPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kControlPointRadius/2, kControlPointRadius/2, self.width-kControlPointRadius, self.height-kControlPointRadius)];
        aPath.lineWidth = 2;
        [aPath stroke];
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.textView.frame = CGRectMake(-kControlPointRadius/2, -kControlPointRadius/2, self.controlSurface.width-kControlPointRadius, self.controlSurface.height-kControlPointRadius);
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
    self.textView.frame = CGRectMake(-kControlPointRadius/2, -kControlPointRadius/2, self.controlSurface.width-kControlPointRadius, self.controlSurface.height-kControlPointRadius);
    if (self.didUpdateFrame) {
        self.didUpdateFrame(self.tag);
    }
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (!self.isEditing) {
        [self.textView becomeFirstResponder];
    }
    if (self.rectangleType == PTRectangleTypeTextView) {
        [self updateTextViewBoundingBoxWithTextView:self.textView];
    }
    
}

-(void)movebleTextView:(PTMovebleTextView *)textView touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];;
}

-(void)movebleTextView:(PTMovebleTextView *)textView touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self touchesMoved:touches withEvent:event];
}

-(void)textViewDidChange:(UITextView *)textView{
    [self updateTextViewBoundingBoxWithTextView:textView];
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    [self updateTextViewBoundingBoxWithTextView:textView];
    return YES;
}

-(void)updateTextViewBoundingBoxWithTextView:(UITextView *)textView{
    CGSize adjustSize = [self getStringRectInTextView:textView.text InTextView:textView];
    CGFloat deltaHeight = adjustSize.height-textView.height;
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = CGRectMake(self.left, self.top, self.width, self.height+deltaHeight);
        [self updateAllControlPoints];
    }];
    
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView{
    self.selected = YES;
    if (self.tapFocused) {
        self.tapFocused();
    }
}

- (CGSize)getStringRectInTextView:(NSString *)string InTextView:(UITextView *)textView {
    //实际textView显示时我们设定的宽
    CGFloat contentWidth = CGRectGetWidth(textView.frame);
    //但事实上内容需要除去显示的边框值
    CGFloat broadWith    = (textView.contentInset.left + textView.contentInset.right
                            + textView.textContainerInset.left
                            + textView.textContainerInset.right
                            + textView.textContainer.lineFragmentPadding/*左边距*/
                            + textView.textContainer.lineFragmentPadding/*右边距*/);
    
    CGFloat broadHeight  = (textView.contentInset.top
                            + textView.contentInset.bottom
                            + textView.textContainerInset.top
                            + textView.textContainerInset.bottom
                            + textView.textContainer.lineFragmentPadding
                            + textView.textContainer.lineFragmentPadding
                            );//+self.textview.textContainer.lineFragmentPadding/*top*//*+theTextView.textContainer.lineFragmentPadding*//*there is no bottom padding*/);
    
    //由于求的是普通字符串产生的Rect来适应textView的宽
    contentWidth -= broadWith;
    
    CGSize InSize = CGSizeMake(contentWidth, MAXFLOAT);
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = textView.textContainer.lineBreakMode;
    NSDictionary *dic = @{NSFontAttributeName:textView.font, NSParagraphStyleAttributeName:[paragraphStyle copy]};
    
    CGSize calculatedSize =  [string boundingRectWithSize:InSize options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    
    CGSize adjustedSize = CGSizeMake(ceilf(calculatedSize.width),calculatedSize.height + broadHeight);
    return adjustedSize;
}

-(UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-kControlPointRadius/2, -kControlPointRadius/2, self.width-kControlPointRadius, self.height-kControlPointRadius)];
    }
    return _imageView;
}

-(PTMovebleTextView *)textView{
    if (!_textView) {
        _textView = [[PTMovebleTextView alloc] initWithFrame:CGRectZero];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.contentInset = UIEdgeInsetsZero;
        _textView.font = [UIFont systemFontOfSize:16];
        _textView.hidden = YES;
        _textView.delegate = self;
        _textView.movebleDelegate = self;
        
    }
    return _textView;
}

@end
