
#import <UIKit/UIKit.h>
#import "SOGlobal.h"

@class SOScrollViewAutoView;
@protocol SOScrollViewAutoViewDelegate <NSObject>
@optional
/**
 *  @brief  响应委托协议，选中一个子视图时触发
 *
 *  @return 无返回值
 */
- (void)autoScrollViewDelegate:(SOScrollViewAutoView *)scrollView didSelectImageView:(NSInteger)index;

/**
 *  @brief  响应委托协议，滚动一个子视图时触发
 *
 *  @return 无返回值
 */
- (void)autoScrollViewDelegate:(SOScrollViewAutoView *)scrollView didScrollImageView:(NSInteger)index;
@end


@interface SOScrollViewAutoView : UIView {
    __SOWEAK id<SOScrollViewAutoViewDelegate>_delegate;
}
@property (strong, nonatomic, readonly) UIScrollView *scrollView;
@property (strong, nonatomic, readonly) UIPageControl *pageCtrl;

/**
 *  @brief  响应委托的对象
 */
@property (nonatomic, PROPERTYWEAK) id<SOScrollViewAutoViewDelegate>delegate;

/**
 *  @brief  是否自动滚动
 */
@property (nonatomic, assign) BOOL autoScroll;

/**
 *  @brief  自动滚动的间隔
 */
@property (nonatomic, assign) NSTimeInterval autoTimeInterval;

/**
 *  @brief  图片链接数组，成员为NSURL
 */
@property (nonatomic, strong) NSArray *imageUrls;

@end

