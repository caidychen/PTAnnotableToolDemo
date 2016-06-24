//
//  CCPopupButtonCell.h
//  CreditCard
//
//  Created by soso on 15/5/14.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SOPopupButtonCell;
typedef NS_OPTIONS(NSUInteger, CCPopupButtonCellBounceType) {
    CCPopupButtonCellBounceTypeHorizontal     = 0,
    CCPopupButtonCellBounceTypeVertical
};

@interface SOPopupButtonCell : UICollectionViewCell
@property (assign, nonatomic) CGFloat space;
@property (assign, nonatomic) CGSize imageSize;
@property (assign, nonatomic) CGSize textSize;
@property (assign, nonatomic) UIEdgeInsets contentInsets;
@property (assign, nonatomic) UIEdgeInsets separatorInset;
@property (assign, nonatomic) CCPopupButtonCellBounceType bounceType;
@property (strong, nonatomic) UIColor *separatorColor;
@property (strong, nonatomic, readonly) UILabel *textLabel;
@property (strong, nonatomic, readonly) UIImageView *imageView;
@end
