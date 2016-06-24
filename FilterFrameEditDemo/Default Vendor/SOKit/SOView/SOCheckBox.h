
#import "SOBaseControl.h"

typedef NS_OPTIONS(NSUInteger, SOCheckBoxState) {
    SOCheckBoxStateDeSelected      = 0,     //未选中
    SOCheckBoxStateSelected       = 1,      //选中
};

@interface SOCheckBox : SOBaseControl

/**
 *  @brief  标题标签
 */
@property (retain, nonatomic, readonly) UILabel *titleLabel;

/**
 *  @brief  是否选中
 */
@property (assign, nonatomic) BOOL isSelected;

/**
 *  @brief  图片大小
 */
@property (assign, nonatomic) CGSize imageSize;

/**
 *  @brief  set方法，设置标题文本和标题字体
 *
 *  @return 无返回值
 */
- (void)setTitle:(NSString *)title font:(UIFont *)font;

/**
 *  @brief  get方法
 *
 *  @return 返回标题文本
 */
- (NSString *)title;

/**
 *  @brief  set方法，设置对应state的图片image
 *
 *  @return 无返回值
 */
- (void)setImage:(UIImage *)image forState:(SOCheckBoxState)state;

/**
 *  @brief  get方法
 *
 *  @return 返回对应state的图片
 */
- (UIImage *)imageForState:(SOCheckBoxState)state;

@end
