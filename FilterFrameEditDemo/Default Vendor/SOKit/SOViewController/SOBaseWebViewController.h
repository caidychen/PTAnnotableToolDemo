//
//  SOBaseWebViewController.h
//  SOKit
//
//  Created by soso on 15/6/4.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "SOBaseViewController.h"

@interface SOBaseWebViewController : SOBaseViewController
/**
 *  @brief  加载的地址，类型为NSURL
 */
@property (copy, nonatomic) NSURL *url;

/**
 *  @brief  是否自动更改标题为web标题(document.title)
 */
@property (assign, nonatomic) BOOL autoShowWebTitle;

@property (assign, nonatomic) NSTimeInterval timeoutInterval;

@end
