//
//  FilterMaskView.h
//  FilterFrameEditDemo
//
//  Created by CHEN KAIDI on 23/6/2016.
//  Copyright © 2016 Putao. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^DidUpdateFrame)(NSInteger index);
@interface FilterMaskView : UIView
@property (nonatomic, assign) CGSize clampSize;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, copy) DidUpdateFrame didUpdateFrame;
@end
