//
//  NOENowScoreDiscussInputView.h
//  Lottery
//
//  Created by soso on 15/3/17.
//  Copyright (c) 2015年 9188-MacPro1. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @brief  预定最大字数
 */
static NSUInteger const NOENowScoreDiscussInputTextMaxLength  = 500;

/**
 *  @brief  输入框高度
 */
static CGFloat const NOENowScoreDiscussInputTextViewMinHeight  = 30.0f;

@class SOInputView;
/**
 *  @brief  自定义输入框的一些回调协议
 */
@protocol NOENowScoreDiscussInputViewDelegate <UITextViewDelegate>
@optional
/**
 *  @brief  输入框回调，文本将要被编辑
 *
 *  @return 无返回值
 */
- (void)discussInputView:(SOInputView *)inputView textViewDidBeginEditing:(UITextView *)textView;

/**
 *  @brief  输入框回调，文本已经被编辑
 *
 *  @return 无返回值
 */
- (void)discussInputView:(SOInputView *)inputView textViewDidEndEditing:(UITextView *)textView;

/**
 *  @brief  输入框回调，能否被编辑
 *
 *  @return 返回YES则响应编辑，NO为不响应
 */
- (BOOL)discussInputView:(SOInputView *)inputView textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;

/**
 *  @brief  输入框回调，文本被修改
 *
 *  @return 无返回值
 */
- (void)discussInputView:(SOInputView *)inputView textViewDidChange:(UITextView *)textView;

/**
 *  @brief  输入框回调，done按钮被触发
 *
 *  @return 无返回值
 */
- (void)discussInputView:(SOInputView *)inputView doneButtonTouched:(id)sender;
@end


/**
 *  @brief  自定义占位文本视图
 */
@interface SOPlaceHolderTextView : UITextView {
@protected
    NSString *_placeHolder;
    UIImage *_placeHolderImage;
    CGRect _placeHolderFrame;
    CGRect _placeHolderImageFrame;
    BOOL _placeHolderAutoFirstLineCenter;
}

@property (strong, nonatomic, readonly) UIImageView *holderImageView;
@property (strong, nonatomic, readonly) UILabel *holderLabel;

/**
 *  @brief  占位字符串
 */
@property (copy, nonatomic) NSString *placeHolder;

/**
 *  @brief  占位图片
 */
@property (strong, nonatomic) UIImage *placeHolderImage;

/**
 *  @brief  占位字符串所占frame
 */
@property (assign, nonatomic) CGRect placeHolderFrame;

/**
 *  @brief  占位图片所占frame
 */
@property (assign, nonatomic) CGRect placeHolderImageFrame;

/**
 *  @brief  文本首行自动居中
 */
@property (assign, nonatomic) BOOL placeHolderAutoFirstLineCenter;

/**
 *  @brief  set方法，设置占位文本颜色
 *
 *  @return 无返回值
 */
- (void)setPlaceHolderColor:(UIColor *)placeHolderColor;
@end



/**
 *  @brief  自定义输入框
 */
@interface SOInputView : UIView {
@protected
    NSUInteger _lineNumber;
    UIEdgeInsets _textViewInsets;
    SOPlaceHolderTextView *_textView;
    UIButton *_doneButton;
    __weak id<NOENowScoreDiscussInputViewDelegate>_delegate;
}

/**
 *  @brief  预定文本显示行数
 */
@property (assign, nonatomic) NSUInteger lineNumber;

/**
 *  @brief  留边框
 */
@property (assign, nonatomic) UIEdgeInsets textViewInsets;

/**
 *  @brief  占位文本视图
 */
@property (strong, nonatomic, readonly) SOPlaceHolderTextView *textView;

/**
 *  @brief  完成按钮
 */
@property (strong, nonatomic, readonly) UIButton *doneButton;

/**
 *  @brief  回调对象
 */
@property (weak, nonatomic) id<NOENowScoreDiscussInputViewDelegate>delegate;

/**
 *  @brief  get方法
 *
 *  @return 返回输入框内的文本
 */
- (NSString *)text;

/**
 *  @brief  set方法
 *
 *  @return 设置输入框内的文本
 */
- (void)setText:(NSString *)text;

/**
 *  @brief  重置输入框的frame
 *
 *  @return 无返回值
 */
- (void)resetInputViewFrame;
@end
