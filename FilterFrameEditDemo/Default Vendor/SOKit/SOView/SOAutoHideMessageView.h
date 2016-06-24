
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  @brief  默认自动消失的延迟
 */
extern CGFloat const SOAutoHideMessageDefaultHideDelay;

@interface SOAutoHideMessageView : NSObject

/**
 *  @brief  在view中显示msg
 *
 *  @return 无返回值
 */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view;

/**
 *  @brief  在view中的offset相对位置处显示msg
 *
 *  @return 无返回值
 */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view positionOffset:(CGPoint)offset;

/**
 *  @brief  在view中显示msg，延时delay秒后消失
 *
 *  @return 无返回值
 */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view hideDelay:(NSTimeInterval)delay;

/**
 *  @brief  在view中的offset相对位置处显示msg，延时delay秒后消失
 *
 *  @return 无返回值
 */
+ (void)showMessage:(NSString *)msg inView:(UIView *)view positionOffset:(CGPoint)offset hideDelay:(NSTimeInterval)delay;

@end
