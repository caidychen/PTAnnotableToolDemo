//
//  CCPopupButtonGroupView.h
//  CreditCard
//
//  Created by soso on 15/5/14.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SOBaseView.h"
#import "SOPopupButtonItem.h"

@class SOPopupButtonGroupView;
typedef void(^SOPopupButtonGroupViewSelectedItemBlock)(SOPopupButtonGroupView *groupView, NSInteger index);

@interface SOPopupButtonGroupView : SOBaseView 
@property (strong, nonatomic, readonly) UICollectionView *collectionView;
@property (assign, nonatomic) NSInteger selectedIndex;
@property (strong, nonatomic) NSArray *items;
@property (copy, nonatomic) SOPopupButtonGroupViewSelectedItemBlock selectedBlock;
@end
