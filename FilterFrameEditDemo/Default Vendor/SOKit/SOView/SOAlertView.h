//
//  SOAlertView.h
//  SOKit
//
//  Created by soso on 15/6/10.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseView.h"


/**
 *  @brief  动画周期
 */
extern NSTimeInterval   const SOAlertAnimationDuration;

/**
 *  @brief  子视图的间距
 */
extern CGFloat          const SOAlertSubViewSpace;


@interface SOAlertContentView : SOBaseView {
    UIView      *_contentView;
    UIImageView *_backgroundView;
    UILabel     *_titleLabel;
    UITextView  *_textView;
    UIButton    *_button;
    UIButton    *_cancelButton;
}

/**
 *  @brief  内容视图，所有可视视图和子视图都应该放在它上面
 */
@property (strong, nonatomic, readonly) UIView *contentView;

/**
 *  @brief  背景视图，contentView上的最底层视图
 */
@property (strong, nonatomic, readonly) UIImageView *backgroundView;

/**
 *  @brief  标题label
 */
@property (strong, nonatomic, readonly) UILabel     *titleLabel;

/**
 *  @brief  文字视图
 */
@property (strong, nonatomic, readonly) UITextView  *textView;

/**
 *  @brief  按钮
 */
@property (strong, nonatomic, readonly) UIButton    *button;

/**
 *  @brief  取消按钮
 */
@property (strong, nonatomic, readonly) UIButton    *cancelButton;

@end


@class SOAlertView;
@protocol SOAlertViewDelegate <NSObject>
@optional
- (void)alertView:(SOAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface SOAlertView : SOBaseView {
    __weak id <SOAlertViewDelegate> _delegate;
    SOAlertContentView *_contentView;
}

/**
 *  @brief  代理，响应一些委托
 */
@property (weak, nonatomic) id <SOAlertViewDelegate>delegate;

/**
 *  @brief  内容view
 */
@property (strong, nonatomic, readonly) SOAlertContentView *contentView;

/**
 *  @brief  get方法
 *
 *  @return 返回内容视图大小
 */
- (CGSize)contentSize;

/**
 *  @brief  get方法
 *
 *  @return 返回标题文本
 */
- (NSString *)title;

/**
 *  @brief  get方法
 *
 *  @return 返回标题富文本
 */
- (NSAttributedString *)attTitle;

/**
 *  @brief  get方法
 *
 *  @return 返回内容文本
 */
- (NSString *)text;

/**
 *  @brief  get方法
 *
 *  @return 返回内容富文本
 */
- (NSAttributedString *)attText;

/**
 *  @brief  set方法，传入内容大小size
 *
 *  @return 无返回值
 */
- (void)setContentSize:(CGSize)size;

/**
 *  @brief  set方法，传入标题文本
 *
 *  @return 无返回值
 */
- (void)setTitle:(NSString *)title;

/**
 *  @brief  set方法，传入标题富文本
 *
 *  @return 无返回值
 */
- (void)setAttTitle:(NSAttributedString *)attTitle;

/**
 *  @brief  set方法，传入内容文本
 *
 *  @return 无返回值
 */
- (void)setText:(NSString *)text;

/**
 *  @brief  set方法，传入内容富文本
 *
 *  @return 无返回值
 */
- (void)setAttText:(NSAttributedString *)attText;

/**
 *  @brief  弹出自身
 *
 *  @return 无返回值
 */
- (void)show;

/**
 *  @brief  自身模拟响应buttonIndex按钮来退出，animated决定是否带动画
 *
 *  @return 无返回值
 */
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@end
