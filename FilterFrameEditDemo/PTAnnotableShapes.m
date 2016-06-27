//
//  PTAnnotableShapes.m
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 27/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import "PTAnnotableShapes.h"

@implementation PTAnnotableShapes

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

-(void)setSelected:(BOOL)selected{
    _selected = selected;
}

@end
