//
//  SOOverlayImageView.h
//  SOKit
//
//  Created by soso on 15-2-8.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseView.h"

typedef NS_OPTIONS(NSUInteger, SOOverlayImageViewSubArrowTypes) {
    SOOverlayImageViewSubArrowTypeUp   = 0,        //升序
    SOOverlayImageViewSubArrowTypeDown,            //降序
};

typedef NS_OPTIONS(NSUInteger, SOOverlayImagesAlwaysBounce) {
    SOOverlayImagesAlwaysBounceVertical,     //竖直方向多个排列
    SOOverlayImagesAlwaysBounceHorizontal    //水平方向多个排列
};


@interface SOOverlayImageView : SOBaseView

/**
 *  @brief  单一图片大小
 */
@property (assign, nonatomic) CGSize unitImageSize;

/**
 *  @brief  单一图片的间距
 */
@property (assign, nonatomic) CGFloat unitImageSpace;

/**
 *  @brief  图片数量，多个排列时为images数量
 */
@property (assign, nonatomic) NSUInteger unitCount;

/**
 *  @brief  单一图片的圆角
 */
@property (assign, nonatomic) CGFloat imageCorner;

/**
 *  @brief  图片的重叠方式
 */
@property (assign, nonatomic) SOOverlayImageViewSubArrowTypes arrowType;

/**
 *  @brief  图片的对齐方式
 */
@property (assign, nonatomic) SOOverlayImagesAlwaysBounce alwaysBounce;


/**
 *  @brief  多个排列的图片数组（成员为本地图片named，非UIImage)
 */
@property (strong, nonatomic) NSArray *images;

/**
 *  @brief  重新刷新所有图片的内容和布局
 *
 *  @return 无返回值
 */
- (void)displayAllImageView;

@end
