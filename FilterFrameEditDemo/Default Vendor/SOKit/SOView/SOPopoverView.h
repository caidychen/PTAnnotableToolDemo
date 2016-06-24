
#import "SOBaseView.h"
#import "SOGlobal.h"

/**
 *  @brief  弹出视图的默认大小
 */
extern CGSize const SOPopoverViewDefaultSize;

/**
 *  @brief  弹出视图的button的默认大小
 */
extern CGSize const SOPopoverViewButtonDefaultSize;

/**
 *  @brief  弹出视图的动画周期
 */
extern NSTimeInterval const SOPopoverViewAnimationDuration;


typedef NS_OPTIONS(NSUInteger, SOPopoverViewStyle) {
    SOPopoverViewStyleDefault = 0,              //默认样式，标题＋文本＋按钮
    SOPopoverViewStylePicker = 1,               //选择器样式
    SOPopoverViewStyleDatePicker = 2,           //日期选择器样式
    SOPopoverViewStyleTableList = 3,            //列表样式
    SOPopoverViewStyleTitleAndTableList = 4,    //标题＋列表样式
    SOPopoverViewStyleInputList = 5,            //列表输入框样式
};

typedef NS_OPTIONS(NSUInteger, SOPopoverViewAnimation) {
    SOPopoverViewAnimationNone = 0,     //无动画
    SOPopoverViewAnimationFade = 1,     //渐变
    SOPopoverViewAnimationZoom = 2,     //缩放
};

@class SOPopoverView;

@protocol SOPopoverViewDataSource <NSObject>
@optional

#pragma mark - style is SOPopoverViewStyleDefault
/**
 *  @brief  默认弹出视图的资源委托协议
 *
 *  @return 返回标题文本
 */
- (NSString *)popoutViewTitle:(SOPopoverView *)view;

/**
 *  @brief  默认弹出视图的资源委托协议
 *
 *  @return 返回内容文本
 */
- (NSString *)popoutViewMessage:(SOPopoverView *)view;

/**
 *  @brief  默认弹出视图的资源委托协议
 *
 *  @return 返回按钮标题文本数组
 */
- (NSArray *)popoutViewButtonTitleArray:(SOPopoverView *)view;

#pragma mark - style is SOPopoverViewStylePicker
/**
 *  @brief  选择器弹出视图的资源委托协议
 *
 *  @return 返回component数量
 */
- (NSInteger)popoutView:(SOPopoverView *)view numberOfComponentsInPickerView:(UIPickerView *)pickerView;

/**
 *  @brief  选择器弹出视图的资源委托协议
 *
 *  @return 返回row数量
 */
- (NSInteger)popoutView:(SOPopoverView *)view pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;


#pragma mark - style is SOPopoverViewStyleTableList
/**
 *  @brief  列表弹出视图的资源委托协议
 *
 *  @return 返回section数量
 */
- (NSInteger)popoutView:(SOPopoverView *)view numberOfSectionsInTableView:(UITableView *)tableView;

/**
 *  @brief  列表弹出视图的资源委托协议
 *
 *  @return 返回对应section的row数量
 */
- (NSInteger)popoutView:(SOPopoverView *)view tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

/**
 *  @brief  列表弹出视图的资源委托协议
 *
 *  @return 返回对应indexPath的cell
 */
- (UITableViewCell *)popoutView:(SOPopoverView *)view tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

#pragma mark - style is SOPopoverViewStyleInputList
/**
 *  @brief  输入列表弹出视图的资源委托协议
 *
 *  @return 返回输入item的数组
 */
- (NSArray *)popoutViewInputList:(SOPopoverView *)view;

@end


@protocol SOPopoverViewDelegate <NSObject, UIPickerViewDelegate, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate>
@optional
/**
 *  @brief  弹出视图的响应委托协议，触摸点在内容以外的区域
 *
 *  @return 无返回值
 */
- (void)popoutViewDidTouchedOutOfContentSize:(SOPopoverView *)popoutView;

/**
 *  @brief  弹出视图的响应委托协议，触摸的点坐标
 *
 *  @return 无返回值
 */
- (void)popoutView:(SOPopoverView *)popoutView tapedPosition:(CGPoint)position;

/**
 *  @brief  弹出视图的响应委托协议，触摸的按钮的index
 *
 *  @return 无返回值
 */
- (void)popoutView:(SOPopoverView *)view buttonDidTouchedAtIndex:(NSInteger)index;


/**
 *  @brief  弹出视图的响应委托协议，将要做弹出动画
 *
 *  @return 无返回值
 */
- (void)popoutView:(SOPopoverView *)view willPopoutAnimate:(BOOL)animate;

/**
 *  @brief  弹出视图的响应委托协议，刚刚完成弹出
 *
 *  @return 无返回值
 */
- (void)popoutViewDidPopout:(SOPopoverView *)view;

/**
 *  @brief  弹出视图的响应委托协议，将要消失
 *
 *  @return 无返回值
 */
- (void)popoutViewWillDismiss:(SOPopoverView *)view;

/**
 *  @brief  弹出视图的响应委托协议，刚刚消失
 *
 *  @return 无返回值
 */
- (void)popoutViewDidDismiss:(SOPopoverView *)view;

#pragma mark - style is picker
- (CGFloat)popoutView:(SOPopoverView *)view pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component;
- (CGFloat)popoutView:(SOPopoverView *)view pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component;
- (NSString *)popoutView:(SOPopoverView *)view pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (NSAttributedString *)popoutView:(SOPopoverView *)view pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)popoutView:(SOPopoverView *)view pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;

#pragma mark - style is date picker
/**
 *  @brief  选择器弹出视图的响应委托协议，选择器的选项发生改变
 *
 *  @return 无返回值
 */
- (void)popoutView:(SOPopoverView *)view datePickerValueDidChanged:(UIDatePicker *)picker;

#pragma mark - style is tableView
- (CGFloat)popoutView:(SOPopoverView *)view tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)popoutView:(SOPopoverView *)view tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface SOPopoverView : SOBaseView

/**
 *  @brief  边线圆角
 */
@property (assign, nonatomic) CGFloat borderRadius;

/**
 *  @brief  边线颜色
 */
@property (assign, nonatomic) CGColorRef borderColor;

/**
 *  @brief  边线间距
 */
@property (assign, nonatomic) CGFloat borderSpace;

/**
 *  @brief  内容大小
 */
@property (assign, nonatomic) CGSize contentSize;

/**
 *  @brief  内容背景颜色
 */
@property (assign, nonatomic) CGColorRef contentBackgroundColor;

/**
 *  @brief  内容标题背景颜色
 */
@property (assign, nonatomic) CGColorRef contentTitleBackgroundColor;

/**
 *  @brief  内容标题文本颜色
 */
@property (assign, nonatomic) CGColorRef contentTitleColor;

/**
 *  @brief  内容文本背景颜色
 */
@property (assign, nonatomic) CGColorRef contentTextBackgroundColor;

/**
 *  @brief  内容文本颜色
 */
@property (assign, nonatomic) CGColorRef contentTextColor;

/**
 *  @brief  内容字体
 */
@property (retain, nonatomic) UIFont *contentFont;

/**
 *  @brief  整体相对位置(0.0f~1.0f)
 */
@property (assign, nonatomic) CGPoint positionOffset;

/**
 *  @brief  样式
 */
@property (assign, nonatomic, readonly) SOPopoverViewStyle style;

/**
 *  @brief  动画类型
 */
@property (assign, nonatomic, readonly) SOPopoverViewAnimation animation;

/**
 *  @brief  资源代理
 */
@property (PROPERTYWEAK, nonatomic) id<SOPopoverViewDataSource>dataSource;

/**
 *  @brief  响应代理
 */
@property (PROPERTYWEAK, nonatomic) id<SOPopoverViewDelegate>delegate;

/**
 *  @brief  初始化方法，根据样式初始化
 *
 *  @return 返回自身实例
 */
- (instancetype)initWithStyle:(SOPopoverViewStyle)style;

/**
 *  @brief  get方法
 *
 *  @return 如果样式为日期选择器，则返回当前选择器选中的日期，否则返回nil
 */
- (NSDate *)date;

/**
 *  @brief  get方法
 *
 *  @return 如果样式为日期选择器，则返回设定的最小日期
 */
- (NSDate *)minimumDate;

/**
 *  @brief  get方法
 *
 *  @return 如果样式为日期选择器，则返回设定的最大日期
 */
- (NSDate *)maximumDate;

/**
 *  @brief  get方法
 *
 *  @return 如果样式为日期选择器，则返回日期选择器的模式
 */
- (UIDatePickerMode)datePickerMode;

/**
 *  @brief  get方法
 *
 *  @return 返回索引为index的button
 */
- (UIButton *)buttonAtIndex:(NSInteger)index;

/**
 *  @brief  set方法
 *
 *  @return 如果样式为日期选择器，则设定日期选择器的日期为date
 */
- (void)setDate:(NSDate *)date animated:(BOOL)animated;

/**
 *  @brief  set方法
 *
 *  @return 如果样式为日期选择器，则设定日期选择器的最小日期为minimumDate
 */
- (void)setMinimumDate:(NSDate *)minimumDate;

/**
 *  @brief  set方法
 *
 *  @return 如果样式为日期选择器，则设定日期选择器的最大日期为maximumDate
 */
- (void)setMaximumDate:(NSDate *)maximumDate;

/**
 *  @brief  set方法
 *
 *  @return 如果样式为日期选择器，则设定日期选择器的模式为datePickerMode
 */
- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode;

/**
 *  @brief  在视图view上弹出视图
 *
 *  @return 无返回值
 */
- (void)popoutFromView:(UIView *)view Animation:(SOPopoverViewAnimation)animation;

/**
 *  @brief  让弹出视图消失
 *
 *  @return 无返回值
 */
- (void)dismiss;

/**
 *  @brief  刷新弹出视图
 *
 *  @return 无返回值
 */
- (void)reloadData;

@end
