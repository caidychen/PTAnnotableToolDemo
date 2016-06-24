//
//  CCPopupButtonGroupView.m
//  CreditCard
//
//  Created by soso on 15/5/14.
//  Copyright (c) 2015年 com.9188. All rights reserved.
//

#import "SOPopupButtonGroupView.h"
#import "SOPopupButtonCell.h"
#import "NSObject+SOObject.h"
#import "SOTitleControl.h"
#import "SOGlobal.h"

@interface SOPopupButtonGroupView () <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (strong, nonatomic, readonly) UICollectionViewFlowLayout *flowLayout;
@end

@implementation SOPopupButtonGroupView
@synthesize collectionView = _collectionView;
@synthesize flowLayout = _flowLayout;

- (void)dealloc {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.selectedIndex = -1;
        _contentInsets = UIEdgeInsetsZero;
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
}

#pragma mark - setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    [self.collectionView reloadData];
}

- (void)setItems:(NSArray *)items {
    _items = [items copy];
    [self.collectionView reloadData];
}
#pragma mark -

#pragma mark - getter
- (UICollectionView *)collectionView {
    if(!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, self.contentInsets) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundView = nil;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView setAlwaysBounceHorizontal:YES];
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
    }
    return (_collectionView);
}

- (UICollectionViewFlowLayout *)flowLayout {
    if(!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
    }
    return (_flowLayout);
}
#pragma mark -

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return ([self.items count]);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cellIdentifier";
    [collectionView registerClass:[SOPopupButtonCell class] forCellWithReuseIdentifier:cellIdentifier];
    SOPopupButtonCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    SOPopupButtonItem *item = (SOPopupButtonItem *)[self.items safeObjectAtIndex:indexPath.item];
    cell.separatorInset = UIEdgeInsetsMake(10, 0, 10, 0);
    cell.separatorColor = (item == [self.items firstObject]) ? [UIColor clearColor] : UIColorFromRGB(0xe4e4e4);
    cell.textLabel.text = item.text;
    cell.textLabel.textColor = [UIColor blackColor];
    cell.imageView.image = [UIImage imageNamed:([item isSelected] ? @"btn_article_gery_up" : @"btn_article_gery_down")];
    return (cell);
}
#pragma mark -

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.selectedIndex >= 0) {
        SOPopupButtonItem *item = (SOPopupButtonItem *)[self.items safeObjectAtIndex:self.selectedIndex];
        SOPopupButtonCell *cell = (SOPopupButtonCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0]];
        [UIView animateWithDuration:SOTitleControlAnimationDuration animations:^{
            // 箭头图标旋转 180 度
            cell.imageView.transform = CGAffineTransformMakeRotation(0);
        }];
        item.selected = NO;
    }
    _selectedIndex = indexPath.item;
    
    SOPopupButtonItem *item = (SOPopupButtonItem *)[self.items safeObjectAtIndex:self.selectedIndex];
    SOPopupButtonCell *cell = (SOPopupButtonCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [UIView animateWithDuration:SOTitleControlAnimationDuration animations:^{
        cell.imageView.transform = CGAffineTransformMakeRotation([item isSelected] ? 0 : M_PI);
    }];
    item.selected = ![item isSelected];
//    CL_DEBUG(@" item.selected  : %d ",item.selected);
    
    if(self.selectedBlock) {
        self.selectedBlock(self, self.selectedIndex);
    }
}
#pragma mark -

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    SOPopupButtonItem *item = (SOPopupButtonItem *)[self.items safeObjectAtIndex:indexPath.item];
    return (item.size);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return (UIEdgeInsetsZero);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return (0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return (0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return (CGSizeZero);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return (CGSizeZero);
}
#pragma mark -

@end
