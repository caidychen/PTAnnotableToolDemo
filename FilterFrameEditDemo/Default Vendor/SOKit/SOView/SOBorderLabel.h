//
//  SOBorderLabel.h
//  SOKit
//
//  Created by soso on 14-7-25.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseLabel.h"

//边框、圆角类型
typedef NS_OPTIONS(NSUInteger, SOBorderLineStyle) {
    SOBorder_Line_None      =   0UL,          //无边框
    SOBorder_Line_Top       =   1UL << 0,     //仅上边框
    SOBorder_Line_Bottom    =   1UL << 1,     //仅下边框
    SOBorder_Line_Left      =   1UL << 2,     //仅左边框
    SOBorder_Line_Right     =   1UL << 3,     //仅右边框
    SOBorder_Line_All       =   SOBorder_Line_Top | SOBorder_Line_Bottom | SOBorder_Line_Left | SOBorder_Line_Right,    //四周边框
};

/**
 *  @brief  C方法，传入大小size，样式style，圆角corner，圆角大小radii
 *
 *  @return 返回路径
 */
UIBezierPath * borderLinePathWithSize(CGSize size, SOBorderLineStyle style, UIRectCorner corner, CGSize radii);

//自定边框及圆角的label
@interface SOBorderLabel : SOBaseLabel

/**
 *  @brief  边线颜色
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 *  @brief  边线线宽
 */
@property (assign, nonatomic) CGFloat borderLineWidth;

/**
 *  @brief  边线style
 */
@property (assign, nonatomic) SOBorderLineStyle borderStyle;

/**
 *  @brief  圆角
 */
@property (assign, nonatomic) UIRectCorner corner;

/**
 *  @brief  圆角大小
 */
@property (assign, nonatomic) CGSize radii;

@end
