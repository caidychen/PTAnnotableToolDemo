
#import "SOAutoHideMessageView.h"
#import "SOGlobal.h"
#import "NSString+SOAdditions.h"
#import <objc/runtime.h>

CGFloat const SOAutoHideMessageDefaultHideDelay        = 1.0f;
static void * msgLabelKey = &msgLabelKey;

@implementation SOAutoHideMessageView

+ (void)showMessage:(NSString *)msg inView:(UIView *)view {
    [self showMessage:msg inView:view positionOffset:CGPointMake(0.5f, 0.5f)];
}

+ (void)showMessage:(NSString *)msg inView:(UIView *)view positionOffset:(CGPoint)offset {
    [self showMessage:msg inView:view positionOffset:offset hideDelay:SOAutoHideMessageDefaultHideDelay];
}

+ (void)showMessage:(NSString *)msg inView:(UIView *)view hideDelay:(NSTimeInterval)delay {
    [self showMessage:msg inView:view positionOffset:CGPointMake(0.5f, 0.5f) hideDelay:delay];
}

+ (void)showMessage:(NSString *)msg inView:(UIView *)view positionOffset:(CGPoint)offset hideDelay:(NSTimeInterval)delay {
    if(view && msg && delay > 0) {
        UILabel *lb = (UILabel *)objc_getAssociatedObject(view, msgLabelKey);
        if (lb) {
            [lb removeFromSuperview];
            lb = nil;
        }
        if(!lb) {
            lb = [[UILabel alloc] init];
            lb.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75f];
            lb.textColor = [UIColor whiteColor];
            lb.textAlignment = NSTextAlignmentCenter;
            lb.font = [UIFont boldSystemFontOfSize:14];
            lb.numberOfLines = 0;
            
            lb.layer.masksToBounds = YES;
            lb.layer.cornerRadius = 6.0;
            
            [view addSubview:lb];
            objc_setAssociatedObject(view, msgLabelKey, lb, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            __SOWEAK typeof(lb) weak_lb = lb;
            double delayInSeconds = delay;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [weak_lb removeFromSuperview];
                objc_setAssociatedObject(view, msgLabelKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            });
        }
        
        [view bringSubviewToFront:lb];
        
        CGSize vwSize = view.bounds.size;
        CGSize lbSize = [msg soSizeWithFont:[UIFont boldSystemFontOfSize:14] constrainedToSize:CGSizeMake(260.0f, 2000.0f) lineBreakMode:NSLineBreakByCharWrapping];
        lbSize.width = MIN(260.0f, MAX(60.0f, lbSize.width + 20.0f));
        lbSize.height = MIN(120.0f, MAX(30.0f, lbSize.height + 20.0f));
        lb.frame = CGRectMake(0, 0, lbSize.width, lbSize.height);
        lb.center = CGPointMake(vwSize.width * offset.x, vwSize.height * offset.y);
        lb.text = msg;
    }
}

@end
