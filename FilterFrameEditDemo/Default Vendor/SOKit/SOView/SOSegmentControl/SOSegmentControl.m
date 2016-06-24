//
//  SOSegmentControl.m
//  SOKit
//
//  Created by soso on 13-2-21.
//  Copyright (c) 2013-2015 soso. All rights reserved.
//

#import "SOSegmentControl.h"
#import "UIView+Additions.h"
#import "NSObject+SOObject.h"
#import "SOGlobal.h"

NSTimeInterval const SOSegmentAnimationDuration     = 0.25f;

@interface SOSegmentControl ()

@property (strong, nonatomic) NSArray <SOSegmentControlItem *> *items;

@property (strong, nonatomic) NSMutableArray <SOSegmentButton *> *segments;

@property (strong, nonatomic) UIView *showCurrentOffsetView;

@end


@implementation SOSegmentControl
@synthesize segmentDelegate;
@synthesize selectedIndex = _selectedIndex;
@synthesize contentCount = _contentCount;
@synthesize showCurrentOffsetView = _showCurrentOffsetView;
@synthesize items = _items;

- (void)dealloc {
    SORELEASE(_showCurrentOffsetView);
    SORELEASE(_segments);
    SORELEASE(_items);
    SOSUPERDEALLOC();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self) {
        self.bounces = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        _currentOffsetViewHeight = 3.0f;
        _showCurrentOffsetViewAlways = NO;
        _currentOffsetViewAutoReSize = NO;
        _selectedIndex = 0;
        _contentCount = DEFAULT_TITLE_COUNT;
        _items = nil;
        _segments = [[NSMutableArray alloc] init];
        
        [self addSubview:self.showCurrentOffsetView];
        [self bringSubviewToFront:self.showCurrentOffsetView];
        
        [self setCurrentOffsetViewColor:UIColorFromRGB(0xdf302f)];
    }
    return (self);
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGSize size = self.bounds.size;
    NSInteger itemsCount = [_items count];
    
    CGSize buttonSize = CGSizeMake(size.width / MAX(1, self.contentCount), size.height);
    
    self.contentSize = CGSizeMake(buttonSize.width * itemsCount, buttonSize.height);
    
    for(NSInteger ix = 0; ix < [[self segments] count]; ix++) {
        SOSegmentButton *button = [[self segments] safeObjectAtIndex:ix];
        if(button && [button isKindOfClass:[SOSegmentButton class]]) {
            button.frame = CGRectMake(buttonSize.width * ix, 0, buttonSize.width, buttonSize.height);
        }
    }
    [self showCurrentOffsetView].bottom = size.height;
    [self setCurrentOffset:CGPointMake(self.selectedIndex, 1.0f) animated:NO];
}

#pragma mark - setter
- (void)setContentSize:(CGSize)contentSize {
    CGSize oldSize = self.contentSize;
    [super setContentSize:contentSize];
    if (CGSizeEqualToSize(oldSize, CGSizeZero) && !CGSizeEqualToSize(self.contentSize, CGSizeZero)) {
        [self setSelectedItemIndex:_selectedIndex animated:NO];
    }
}

- (void)setContentCount:(CGFloat)contentCount {
    _contentCount = contentCount;
    [self setNeedsLayout];
}

- (void)setItems:(NSArray *)items {
    NSArray *rtItems = SORETAIN(items);
    SORELEASE(_items);
    _items = rtItems;
    
    if(self.segments) {
        [self.segments makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self.segments removeAllObjects];
    }
    
    for (SOSegmentControlItem *item in items) {
        SOSegmentButton *button = [[SOSegmentButton alloc] initWithFrame:CGRectZero];
        button.backgroundColor = [UIColor clearColor];
        button.item = item;
        [button addTarget:self action:@selector(segmentButtonDidTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.segments addObject:button];
        SORELEASE(button);
    }
    
    [self setNeedsLayout];
}

- (void)setSelectedItemIndex:(NSInteger)index animated:(BOOL)animated {
    _selectedIndex = index;
    CGSize size = self.bounds.size;
    CGFloat ct_x = MIN(self.contentSize.width - size.width, MAX(0, (_selectedIndex + 0.5f) * size.width / MAX(1, self.contentCount) - size.width / 2.0f));
    [self setContentOffset:CGPointMake(ct_x, self.contentOffset.y) animated:animated];
    
    for(NSInteger ix = 0; ix < [[self segments] count]; ix++) {
        SOSegmentButton *button = (SOSegmentButton *)[[self segments] safeObjectAtIndex:ix];
        [button setDidHighlighted:(index == ix)];
        if(![self isShowCurrentOffsetViewAlways]) {
            self.showCurrentOffsetView.hidden = YES;
        }
    }
}

- (void)setCurrentOffset:(CGPoint)offset animated:(BOOL)animated {
    self.showCurrentOffsetView.hidden = NO;
    [self bringSubviewToFront:self.showCurrentOffsetView];
    
    SOSegmentButton *selectedButton = [self.segments safeObjectAtIndex:self.selectedIndex];
    [UIView animateWithDuration:(animated ? SOSegmentAnimationDuration : 0) animations:^{
        if(selectedButton && [self isCurrentOffsetViewAutoReSize]) {
            self.showCurrentOffsetView.width = [selectedButton.titleLabel.text soSizeWithFont:selectedButton.titleLabel.font constrainedToSize:selectedButton.size].width;
        } else {
            self.showCurrentOffsetView.size = CGSizeMake(self.contentSize.width / MAX(1, [[self items] count]), self.currentOffsetViewHeight);
        }
        self.showCurrentOffsetView.centerX = selectedButton.centerX;
    }];
}

- (void)setCurrentOffsetViewColor:(UIColor *)currentOffsetViewColor {
    self.showCurrentOffsetView.backgroundColor = currentOffsetViewColor;
}
#pragma mark -

#pragma mark - getter
- (UIView *)showCurrentOffsetView {
    if(!_showCurrentOffsetView) {
        _showCurrentOffsetView = [[UIView alloc] init];
        _showCurrentOffsetView.backgroundColor = self.currentOffsetViewColor;
        _showCurrentOffsetView.size = CGSizeMake(self.width / MAX(1, [[self items] count]), self.currentOffsetViewHeight);
    }
    _showCurrentOffsetView.height = self.currentOffsetViewHeight;
    return (_showCurrentOffsetView);
}

- (NSArray *)items {
    return ([NSArray arrayWithArray:_items]);
}

- (NSInteger)indexOfObject:(SOSegmentButton *)object {
    return ([[self segments] indexOfObject:object]);
}

- (SOSegmentButton *)buttonAtIndex:(NSInteger)index {
    return ([[self segments] safeObjectAtIndex:index]);
}

- (UIColor *)currentOffsetViewColor {
    return (self.showCurrentOffsetView.backgroundColor);
}
#pragma mark -

#pragma mark - actions
- (void)segmentButtonDidTouched:(SOSegmentButton *)button {
    if (self.segmentDelegate && [self.segmentDelegate respondsToSelector:@selector(segmentControl:didSelectButton:atIndex:)]) {
        NSInteger index = [self indexOfObject:button];
        [self.segmentDelegate segmentControl:self didSelectButton:button atIndex:index];
    }
}
#pragma mark -

@end
