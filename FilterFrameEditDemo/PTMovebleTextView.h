//
//  PTMovebleTextView.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 28/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PTMovebleTextView;
@protocol PTMovebleTextViewDelegate;

@interface PTMovebleTextView : UITextView

@property (nonatomic, assign) id<PTMovebleTextViewDelegate>movebleDelegate;

@end

@protocol PTMovebleTextViewDelegate <NSObject>

@required
-(void)movebleTextView:(PTMovebleTextView *)textView touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;
-(void)movebleTextView:(PTMovebleTextView *)textView touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event;

@end