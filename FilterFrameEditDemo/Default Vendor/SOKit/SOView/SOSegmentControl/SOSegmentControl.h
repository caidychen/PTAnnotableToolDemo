//
//  SOSegmentControl.h
//  SOKit
//
//  Created by soso on 13-2-21.
//  Copyright (c) 2013-2015 soso. All rights reserved.
//

#import "SOBaseScrollView.h"
#import "SOSegmentButton.h"
#import "SOGlobal.h"

/**
 *  @brief  默认标题个数
 */
#define DEFAULT_TITLE_COUNT 5

/**
 *  @brief  分段选项动画周期
 */
extern NSTimeInterval const SOSegmentAnimationDuration;

@class SOSegmentControl;
/**
 *  @brief  回调协议
 */
@protocol SOSegmentControlDelegate <NSObject>

/**
 *  @brief  回调选中的button和对应的索引
 *
 *  @return 无返回值
 */
- (void)segmentControl:(SOSegmentControl *)segmentControl didSelectButton:(SOSegmentButton *)button atIndex:(NSInteger)index;
@end

/**
 *  @brief  分段选项视图
 */
@interface SOSegmentControl : SOBaseScrollView
/**
 *  @brief  选中的索引
 */
@property (nonatomic, readonly) NSInteger selectedIndex;

/**
 *  @brief  能展示的item个数，items超过这个数字就会解锁自动滚动，contentCount大于items个数时会自动修正为[items count]
 */
@property (nonatomic, assign) CGFloat contentCount;

/**
 *  @brief  响应回调的对象
 */
@property (nonatomic, PROPERTYWEAK) id<SOSegmentControlDelegate> segmentDelegate;

/**
 *  @brief  下方进度条的高
 */
@property (assign, nonatomic) CGFloat currentOffsetViewHeight;

/**
 *  @brief  下方进度条的颜色
 */
@property (strong, nonatomic) UIColor *currentOffsetViewColor;

/**
 *  @brief  是否一直显示下方进度条
 */
@property (assign, nonatomic, getter=isShowCurrentOffsetViewAlways) BOOL showCurrentOffsetViewAlways;

@property (assign, nonatomic, getter=isCurrentOffsetViewAutoReSize) BOOL currentOffsetViewAutoReSize;

/**
 *  @brief  get方法
 *
 *  @return 返回当前item数组
 */
- (NSArray <SOSegmentControlItem *> *)items;

/**
 *  @brief  get方法
 *
 *  @return 返回索引为index的button
 */
- (SOSegmentButton *)buttonAtIndex:(NSInteger)index;

/**
 *  @brief  get方法
 *
 *  @return 显示进度的视图
 */
- (UIView *)showCurrentOffsetView;

/**
 *  @brief  set方法，设置当前item数组
 *
 *  @return 无返回值
 */
- (void)setItems:(NSArray <SOSegmentControlItem *> *)items;

/**
 *  @brief  set方法，设置当前选中的索引
 *
 *  @return 无返回值
 */
- (void)setSelectedItemIndex:(NSInteger)index animated:(BOOL)animated;

/**
 *  @brief  set方法，设置当前进度
 *
 *  @return 无返回值
 */
- (void)setCurrentOffset:(CGPoint)offset animated:(BOOL)animated;

@end
