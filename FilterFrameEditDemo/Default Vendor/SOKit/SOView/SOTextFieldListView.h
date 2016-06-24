
#import "SOBaseView.h"
#import "SOScrollTextCellView.h"
#import "SOBaseItem.h"

@interface SOTextFieldItem : SOBaseItem <NSCopying>
/**
 *  @brief  图片
 */
@property (strong, nonatomic) UIImage *image;

/**
 *  @brief  标题文本
 */
@property (copy, nonatomic) NSString *title;

/**
 *  @brief  内容文本
 */
@property (copy, nonatomic) NSString *text;

/**
 *  @brief  标题占位文本
 */
@property (copy, nonatomic) NSString *placeholder;

/**
 *  @brief  字体
 */
@property (strong, nonatomic) UIFont *font;

/**
 *  @brief  边线颜色
 */
@property (strong, nonatomic) UIColor *borderColor;

/**
 *  @brief  边线宽
 */
@property (assign, nonatomic) CGFloat borderWidth;

/**
 *  @brief  圆角大小
 */
@property (assign, nonatomic) CGFloat cornerRadius;

/**
 *  @brief  键盘样式
 */
@property (assign, nonatomic) UIKeyboardType keyboardType;

/**
 *  @brief  是否激活
 */
@property (assign, nonatomic) BOOL enable;


/**
 *  @brief  一些初始化方法
 *
 *  @return 返回自身实例
 */
+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text;

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder;

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font;

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image;

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth;

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 cornerRadius:(CGFloat)cornerRadius;

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 cornerRadius:(CGFloat)cornerRadius
                 keyboardType:(UIKeyboardType)keyboardType;

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 cornerRadius:(CGFloat)cornerRadius
                 keyboardType:(UIKeyboardType)keyboardType
                       enable:(BOOL)enable;
@end


@class SOTextFieldListView;
@protocol SOTextFieldListViewDelegate <NSObject>
@optional
- (void)textFieldListDidEndEditing:(SOTextFieldListView *)textFieldList;
@end


@interface SOTextFieldListView : SOBaseView

@property (weak, nonatomic) id<SOTextFieldListViewDelegate>delegate;

/**
 *  @brief  缩进
 */
@property (assign, nonatomic) CGFloat indenWidth;

/**
 *  @brief  线宽
 */
@property (assign, nonatomic) CGFloat lineHeight;

/**
 *  @brief  线间距
 */
@property (assign, nonatomic) CGFloat lineSpace;

/**
 *  @brief  标题宽
 */
@property (assign, nonatomic) CGFloat titleWidth;

/**
 *  @brief  内容宽
 */
@property (assign, nonatomic) CGFloat textWidth;

/**
 *  @brief  是否自动滚动，默认YES
 */
@property (assign, nonatomic) BOOL autoScroll;

/**
 *  @brief  滚动视图
 */
@property (strong, nonatomic, readonly) UIScrollView *scrView;

/**
 *  @brief  set方法，设置元素集的数组，成员为SOTextFieldItem
 *
 *  @return 无返回值
 */
- (void)setCellItems:(NSArray *)items;

/**
 *  @brief  get方法
 *
 *  @return 返回输入框数组内的文本，成员为NSString，空值用@“”填充
 */
- (NSArray *)textList;

/**
 *  @brief  get方法
 *
 *  @return 返回索引为index的输入框内的文本
 */
- (NSString *)cellTextAtIndex:(NSInteger)index;

/**
 *  @brief  get方法
 *
 *  @return 返回索引为index的输入框视图
 */
- (SOScrollTextCellView *)cellViewAtIndex:(NSUInteger)index;

/**
 *  @brief  get方法
 *
 *  @return 返回最后一个输入框视图
 */
- (SOScrollTextCellView *)lastCellView;

@end
