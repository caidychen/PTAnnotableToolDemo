//
//  Arrow.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTAnnotableShapes.h"
#import "PTAnnotableLine.h"

#define kArrowTailWith 4
#define kArrowHeadWidth 12
#define kArrowHeadLength 22

typedef NS_ENUM(NSInteger, PTArrowType){
    PTArrowTypeStandardArrow,
    PTArrowTypeSolidLine
};

@interface PTArrow : PTAnnotableLine
@property (nonatomic, assign) PTArrowType arrowType;

@end
