//
//  PTMovebleTextView.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 28/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTMovebleTextView.h"

@implementation PTMovebleTextView

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.movebleDelegate && [self.movebleDelegate respondsToSelector:@selector(movebleTextView:touchesBegan:withEvent:)]) {
        [self.movebleDelegate movebleTextView:self touchesBegan:touches withEvent:event];
    }
}

-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"Moving textview");
    if (self.movebleDelegate && [self.movebleDelegate respondsToSelector:@selector(movebleTextView:touchesMoved:withEvent:)]) {
        [self.movebleDelegate movebleTextView:self touchesMoved:touches withEvent:event];
    }
    self.userInteractionEnabled = NO;
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.userInteractionEnabled = YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    return self.userInteractionEnabled;
    
}
@end
