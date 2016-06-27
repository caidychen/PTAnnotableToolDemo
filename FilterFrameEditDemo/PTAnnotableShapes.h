//
//  PTAnnotableShapes.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 27/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kControlColor [UIColor colorWithHexString:@"1b81f8"]

@interface PTAnnotableShapes : UIView

@property (nonatomic, strong) UIColor *color;
@property (nonatomic, assign) BOOL selected;
@property (nonatomic, assign) BOOL isEditing;


@end
