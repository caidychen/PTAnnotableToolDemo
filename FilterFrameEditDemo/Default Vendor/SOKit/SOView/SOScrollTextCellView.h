
#import "SOBaseView.h"

@interface SOScrollTextCellView : SOBaseView

/**
 *  @brief  标题宽
 */
@property (assign, nonatomic) CGFloat titleWidth;

/**
 *  @brief  内容宽
 */
@property (assign, nonatomic) CGFloat textWidth;

/**
 *  @brief  图片视图
 */
@property (strong, nonatomic, readonly) UIImageView *imageView;

/**
 *  @brief  标题标签
 */
@property (strong, nonatomic, readonly) UILabel *titleLabel;

/**
 *  @brief  输入视图
 */
@property (strong, nonatomic, readonly) UITextField *textField;

@end
