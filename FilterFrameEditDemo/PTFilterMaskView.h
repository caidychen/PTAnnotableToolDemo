//
//  FilterMaskView.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PTAnnotableRectangular.h"

typedef void(^DidUpdateFrame)(NSInteger index);

@interface PTFilterMaskView : PTAnnotableRectangular


@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) DidUpdateFrame didUpdateFrame;
@end
