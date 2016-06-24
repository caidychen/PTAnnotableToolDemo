//
//  SoPopoverView.m
//  SOKit
//
//  Created by Soal on 13-11-5.
//  Copyright (c) 2013-2015 chinaPnr. All rights reserved.
//

#import "SOPopoverView.h"
#import <QuartzCore/QuartzCore.h>
#import "SOTextFieldListView.h"

#define SO_POPOVERVIEW_BUTTON_START_TAG 1000

CGSize const SOPopoverViewDefaultSize           = (CGSize){.width = 200.0f, .height = 140.0f};
CGSize const SOPopoverViewButtonDefaultSize     = (CGSize){.width = 50.0f, .height = 30.0f};
NSTimeInterval const SOPopoverViewAnimationDuration = 0.15f;

typedef NS_OPTIONS(NSUInteger, SkPopoverAnimationCtrl){
    SkPopoverAnimationCtrlIn = 0,   //弹出
    SkPopoverAnimationCtrlOut = 1   //收起
};

@interface SOPopoverView () <UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *contentView;

@property (strong, nonatomic) UIView *currentView;

@property (copy, nonatomic) NSString *title;
@property (copy, nonatomic) NSString *message;
@property (copy, nonatomic) NSArray *buttonArray;

@property (assign, nonatomic) CGSize buttonSize;
@property (assign, nonatomic) CGFloat ctHeight;

@end


@implementation SOPopoverView

- (void)dealloc {
    SORELEASE(_titleLabel);
    SORELEASE(_currentView);
    SORELEASE(_contentView);
    SORELEASE(_title);
    SORELEASE(_message);
    SORELEASE(_buttonArray);
    SORELEASE(_contentFont);
    SOSUPERDEALLOC();
}

- (instancetype)initWithStyle:(SOPopoverViewStyle)style {
    self = [super initWithFrame:CGRectMake(0, 0, SOPopoverViewDefaultSize.width, SOPopoverViewDefaultSize.height)];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2f];
        
        _borderRadius = 0;
        _borderColor = [UIColor clearColor].CGColor;
        _borderSpace = 5.0f;
        
        self.contentSize = SOPopoverViewDefaultSize;
        _contentBackgroundColor = [UIColor whiteColor].CGColor;
        _contentTitleBackgroundColor = [UIColor clearColor].CGColor;
        _contentTitleColor = [UIColor grayColor].CGColor;
        _contentTextBackgroundColor = [UIColor clearColor].CGColor;
        _contentTextColor = [UIColor grayColor].CGColor;
        _contentFont = SORETAIN([UIFont systemFontOfSize:14.0f]);
        
        _positionOffset = CGPointMake(0.5f, 0.5f);
        _animation = SOPopoverViewAnimationNone;
        
        _buttonSize = SOPopoverViewButtonDefaultSize;
        _ctHeight = 0.0f;
        
        _style = style;
        _title = nil;
        _message = nil;
        _buttonArray = nil;
        
        _currentView = nil;
        
        _contentView = [[UIView alloc] init];
        self.contentView.clipsToBounds = YES;
        [self addSubview:self.contentView];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureDidTouched:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        SORELEASE(tapGesture);
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.contentView.size = self.contentSize;
    self.contentView.center = CGPointMake(CGRectGetWidth(self.bounds) * _positionOffset.x, CGRectGetHeight(self.bounds) * _positionOffset.y);
    self.contentView.backgroundColor = [UIColor colorWithCGColor:_contentBackgroundColor];
    self.contentView.layer.borderColor = _borderColor;
    self.contentView.layer.borderWidth = 0.5f;
    self.contentView.layer.cornerRadius = _borderRadius;
    if(self.currentView) {
        self.currentView.center = CGPointMake(CGRectGetWidth(self.contentView.bounds) / 2.0f, CGRectGetHeight(self.contentView.bounds) / 2.0f);
    }
}

#pragma mark - getters
- (NSDate *)date {
    if(self.currentView && [self.currentView isKindOfClass:[UIDatePicker class]]) {
        return (((UIDatePicker *)self.currentView).date);
    }
    return (nil);
}

- (NSDate *)minimumDate {
    if(self.currentView && [self.currentView isKindOfClass:[UIDatePicker class]]) {
        return (((UIDatePicker *)self.currentView).minimumDate);
    }
    return (nil);
}

- (NSDate *)maximumDate {
    if(self.currentView && [self.currentView isKindOfClass:[UIDatePicker class]]) {
        return (((UIDatePicker *)self.currentView).maximumDate);
    }
    return (nil);
}

- (UIDatePickerMode)datePickerMode {
    if(self.currentView && [self.currentView isKindOfClass:[UIDatePicker class]]) {
        return (((UIDatePicker *)self.currentView).datePickerMode);
    }
    return (UIDatePickerModeDateAndTime);
}

- (UIButton *)buttonAtIndex:(NSInteger)index {
    id vw = [self.contentView viewWithTag:SO_POPOVERVIEW_BUTTON_START_TAG + index];
    if(vw && [vw isKindOfClass:[UIButton class]]) {
        return ((UIButton *)vw);
    }
    return (nil);
}
#pragma mark -

#pragma mark - setters
- (void)setBorderSpace:(CGFloat)borderSpace {
    NSInteger count = MIN(_buttonArray.count, 3);
    if(count && count > 0) {
        _ctHeight = self.buttonSize.height + _borderSpace;
        self.buttonSize = CGSizeMake((self.contentSize.width - _borderSpace) / count - _borderSpace, self.buttonSize.height);
    }
}

- (void)setDate:(NSDate *)date animated:(BOOL)animated {
    if(self.currentView && [self.currentView isKindOfClass:[UIDatePicker class]]) {
        [(UIDatePicker *)self.currentView setDate:date animated:animated];
    }
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    if(self.currentView && [self.currentView isKindOfClass:[UIDatePicker class]]) {
        [((UIDatePicker *)self.currentView) setMinimumDate:minimumDate];
    }
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    if(self.currentView && [self.currentView isKindOfClass:[UIDatePicker class]]) {
        [((UIDatePicker *)self.currentView) setMaximumDate:maximumDate];
    }
}

- (void)setDatePickerMode:(UIDatePickerMode)datePickerMode {
    if(self.currentView && [self.currentView isKindOfClass:[UIDatePicker class]]) {
        [((UIDatePicker *)self.currentView) setDatePickerMode:datePickerMode];
    }
}

- (void)setDelegate:(id<SOPopoverViewDelegate>)delegate {
    _delegate = delegate;
    if(_dataSource) {
        [self reloadData];
    }
}

- (void)setDataSource:(id<SOPopoverViewDataSource>)dataSource {
    _dataSource = dataSource;
    if(_delegate) {
        [self reloadData];
    }
}
#pragma mark -

#pragma mark - actions
- (void)popoutFromView:(UIView *)view Animation:(SOPopoverViewAnimation)animation {
    if(!view || ![view isKindOfClass:[UIView class]]) {
        view = [[UIApplication sharedApplication] keyWindow];
    }
    if(!view || ![view isKindOfClass:[UIView class]]) {
        return;
    }
    _animation = animation;
    self.frame = view.bounds;
    [view addSubview:self];
    if(_delegate && [_delegate respondsToSelector:@selector(popoutView:willPopoutAnimate:)]) {
        [_delegate popoutView:self willPopoutAnimate:animation];
    }
    [self doAnimationCtrl:SkPopoverAnimationCtrlIn popoutAnimation:_animation];
}

- (void)dismiss {
    if(_delegate && [_delegate respondsToSelector:@selector(popoutViewWillDismiss:)]) {
        [_delegate popoutViewWillDismiss:self];
    }
    [self doAnimationCtrl:SkPopoverAnimationCtrlOut popoutAnimation:_animation];
}

- (void)tapGestureDidTouched:(UITapGestureRecognizer *)gesture {
    if(_delegate && [_delegate respondsToSelector:@selector(popoutView:tapedPosition:)]) {
        CGPoint point = [gesture locationInView:self];
        [_delegate popoutView:self tapedPosition:point];
    }
    if(_delegate && [_delegate respondsToSelector:@selector(popoutViewDidTouchedOutOfContentSize:)]) {
        CGPoint point = [gesture locationInView:self];
        if(!CGRectContainsPoint(self.contentView.frame, point)) {
            [_delegate popoutViewDidTouchedOutOfContentSize:self];
        }
    }
}
#pragma mark -

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *touchView = [touch view];
    if([touchView isKindOfClass:[UIControl class]]) {
        return (NO);
    }
    return (YES);
}
#pragma mark -

#pragma mark - contentView and subviews
- (void)reloadData {
    if(_dataSource && [_dataSource respondsToSelector:@selector(popoutViewTitle:)]) {
        self.title = [_dataSource popoutViewTitle:self];
    }
    if(_dataSource && [_dataSource respondsToSelector:@selector(popoutViewMessage:)]) {
        self.message = [_dataSource popoutViewMessage:self];
    }
    if(_dataSource && [_dataSource respondsToSelector:@selector(popoutViewButtonTitleArray:)]) {
        self.buttonArray = [_dataSource popoutViewButtonTitleArray:self];
        NSInteger count = MIN(_buttonArray.count, 3);
        if(count && count > 0) {
            _ctHeight = self.buttonSize.height + _borderSpace;
            self.buttonSize = CGSizeMake((self.contentSize.width - _borderSpace) / count - _borderSpace, self.buttonSize.height);
        }
    }
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch(_style) {
        case SOPopoverViewStylePicker: {
            [self setUpPickerView];
        }break;
        case SOPopoverViewStyleDatePicker: {
            [self setUpDatePickerView];
        }break;
        case SOPopoverViewStyleTableList: {
            [self setUpTableListView];
        }break;
        case SOPopoverViewStyleTitleAndTableList: {
            [self setUpTitleAndTableListView];
        }break;
        case SOPopoverViewStyleInputList: {
            [self setUpInputView];
        }break;
        case SOPopoverViewStyleDefault:
        default: {
            [self setUpDefaultView];
        }break;
    }
    self.contentView.size = self.contentSize;
    [self setNeedsLayout];
}

- (void)setUpDefaultView {
    [self setUpTopTitleLabel];
    UITextView *messageView = [[UITextView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), self.contentSize.height - CGRectGetHeight(_titleLabel.frame) - _borderSpace * 2.0f - _ctHeight)];
    messageView.backgroundColor = [UIColor colorWithCGColor:_contentTextBackgroundColor];
    messageView.textColor = [UIColor colorWithCGColor:_contentTextColor];
    messageView.editable = NO;
    messageView.textAlignment = NSTextAlignmentLeft;
    messageView.text = _message;
    [self.contentView addSubview:messageView];
    self.currentView = messageView;
    SORELEASE(messageView);
    [self setUpBottomButtons];
}

- (void)setUpPickerView {
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
    self.contentSize = pickerView.bounds.size;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self.contentView addSubview:pickerView];
    self.currentView = pickerView;
    SORELEASE(pickerView);
}

- (void)setUpDatePickerView {
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.contentSize.width, self.contentSize.height)];
    self.contentSize = datePicker.bounds.size;
    [datePicker addTarget:self action:@selector(datePickerValueDidChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:datePicker];
    self.currentView = datePicker;
    SORELEASE(datePicker);
}

- (void)setUpTableListView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(_borderSpace, _borderSpace, self.contentSize.width - _borderSpace * 2.0f, self.contentSize.height - _borderSpace * 2.0f) style:UITableViewStylePlain];
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.contentView addSubview:tableView];
    self.currentView = tableView;
    SORELEASE(tableView);
}

- (void)setUpTitleAndTableListView {
    [self setUpTopTitleLabel];
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), self.contentSize.height - CGRectGetHeight(_titleLabel.frame) - _borderSpace * 2.0f - _ctHeight) style:UITableViewStylePlain];
    tableView.backgroundView = nil;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.contentView addSubview:tableView];
    self.currentView = tableView;
    SORELEASE(tableView);
    [self setUpBottomButtons];
}

- (void)setUpTopTitleLabel {
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_borderSpace, _borderSpace, self.contentSize.width - _borderSpace * 2.0f, self.buttonSize.height)];
    _titleLabel.font = _contentFont;
    _titleLabel.textColor = [UIColor colorWithCGColor:_contentTitleColor];
    _titleLabel.backgroundColor = [UIColor colorWithCGColor:_contentTitleBackgroundColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.text = _title;
    [self.contentView addSubview:_titleLabel];
}

- (void)setUpBottomButtons {
    for(NSInteger index = 0; index < _buttonArray.count; index ++) {
        NSString *tl = [_buttonArray safeObjectAtIndex:index];
        UIButton *bt = [UIButton buttonWithType:UIButtonTypeCustom];
        bt.frame = CGRectMake(_borderSpace + (_borderSpace + self.buttonSize.width) * index, CGRectGetMaxY(self.currentView.frame) + _borderSpace, self.buttonSize.width, self.buttonSize.height);
        bt.layer.cornerRadius = 2.0f;
        [bt setBackgroundColor:[UIColor colorWithRed:0.8 green:0.8 blue:0.8 alpha:0.9]];
        [bt setTintColor:[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:0.8]];
        [bt setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [bt setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
        [bt setTitle:tl forState:UIControlStateNormal];
        bt.tag = SO_POPOVERVIEW_BUTTON_START_TAG + index;
        [bt addTarget:self action:@selector(buttonTouched:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:bt];
    }
}

- (void)setUpInputView {
    SOTextFieldListView *fieldListView = [[SOTextFieldListView alloc] initWithFrame:CGRectMake(_borderSpace, _borderSpace, self.contentSize.width - _borderSpace * 2.0f, self.contentSize.height - _borderSpace * 2.0f)];
    fieldListView.autoScroll = NO;
    if(_dataSource && [_dataSource respondsToSelector:@selector(popoutViewInputList:)]) {
        NSArray *arr = [_dataSource popoutViewInputList:self];
        [fieldListView setCellItems:arr];
    }
    [self.contentView addSubview:fieldListView];
    SORELEASE(fieldListView);
}

- (void)datePickerValueDidChanged:(UIDatePicker *)picker {
    if(_delegate && [_delegate respondsToSelector:@selector(popoutView:datePickerValueDidChanged:)]) {
        [_delegate popoutView:self datePickerValueDidChanged:picker];
    }
}
#pragma mark -

#pragma mark - animation
- (void)doAnimationCtrl:(SkPopoverAnimationCtrl)ctrl popoutAnimation:(SOPopoverViewAnimation)animation {
    switch(animation) {
        case SOPopoverViewAnimationFade: {
            if(ctrl == SkPopoverAnimationCtrlIn) {
                self.contentView.alpha = 0;
                [UIView animateWithDuration:SOPopoverViewAnimationDuration animations:^(void){
                    self.contentView.alpha = 1.0f;
                }completion:^(BOOL finished){
                    if(finished) {
                        self.contentView.alpha = 1.0f;
                        if(_delegate && [_delegate respondsToSelector:@selector(popoutViewDidPopout:)]) {
                            [_delegate popoutViewDidPopout:self];
                        }
                    }
                }];
            } else if(ctrl == SkPopoverAnimationCtrlOut){
                [UIView animateWithDuration:SOPopoverViewAnimationDuration animations:^(void){
                    self.contentView.alpha = 0;
                }completion:^(BOOL finished){
                    if(finished) {
                        if(_delegate && [_delegate respondsToSelector:@selector(popoutViewDidDismiss:)]){
                            [_delegate popoutViewDidDismiss:self];
                        }
                        [self removeFromSuperview];
                    }
                }];
            }
        }break;
        case SOPopoverViewAnimationZoom: {
            if(ctrl == SkPopoverAnimationCtrlIn) {
                self.contentView.transform = CGAffineTransformMakeScale(0.1f, 0.1f);
                self.contentView.alpha = 0.1f;
                [UIView animateWithDuration:SOPopoverViewAnimationDuration animations:^(void){
                    self.contentView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
                    self.contentView.alpha = 1.0f;
                }completion:^(BOOL finished){
                    if(finished) {
                        self.contentView.transform = CGAffineTransformMakeScale(1.05f, 1.05f);
                        [UIView animateWithDuration:SOPopoverViewAnimationDuration animations:^(void){
                            self.contentView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                        }completion:^(BOOL finished){
                            if(finished) {
                                self.contentView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
                                if(_delegate && [_delegate respondsToSelector:@selector(popoutViewDidPopout:)]) {
                                    [_delegate popoutViewDidPopout:self];
                                }
                            }
                        }];
                    }
                }];
            } else if(ctrl == SkPopoverAnimationCtrlOut) {
                [UIView animateWithDuration:SOPopoverViewAnimationDuration animations:^(void){
                    self.contentView.alpha = 0;
                }completion:^(BOOL finished){
                    if(finished) {
                        if(_delegate && [_delegate respondsToSelector:@selector(popoutViewDidDismiss:)]) {
                            [_delegate popoutViewDidDismiss:self];
                        }
                        [self removeFromSuperview];
                    }
                }];
            }
        }break;
        case SOPopoverViewAnimationNone:
        default: {
            if(_delegate && [_delegate respondsToSelector:@selector(popoutViewDidDismiss:)]) {
                [_delegate popoutViewDidDismiss:self];
            }
            [self removeFromSuperview];
        }break;
    }
}
#pragma mark -

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_dataSource && [_dataSource respondsToSelector:@selector(popoutView:tableView:cellForRowAtIndexPath:)]) {
        return ([_dataSource popoutView:self tableView:tableView numberOfRowsInSection:section]);
    }
    return (0);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(_dataSource && [_dataSource respondsToSelector:@selector(popoutView:tableView:cellForRowAtIndexPath:)]) {
        return ([_dataSource popoutView:self tableView:tableView cellForRowAtIndexPath:indexPath]);
    }
    return (nil);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(_dataSource && [_dataSource respondsToSelector:@selector(popoutView:numberOfSectionsInTableView:)]) {
        return ([_dataSource popoutView:self numberOfSectionsInTableView:tableView]);
    }
    return (1);
}
#pragma mark -

#pragma mark - <UITableViewDelegate>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.delegate && [self.delegate respondsToSelector:@selector(popoutView:tableView:heightForRowAtIndexPath:)]) {
        return ([self.delegate popoutView:self tableView:tableView heightForRowAtIndexPath:indexPath]);
    }
    return (tableView.rowHeight);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if(self.delegate && [self.delegate respondsToSelector:@selector(popoutView:tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate popoutView:self tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
#pragma mark -

#pragma mark - <UIPickerViewDelegate>
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if(self.delegate && [self.delegate respondsToSelector:@selector(popoutView:pickerView:widthForComponent:)]) {
        return ([self.delegate popoutView:self pickerView:pickerView widthForComponent:component]);
    }
    CGFloat width = floorf(CGRectGetWidth(pickerView.bounds) / MAX(1, [pickerView numberOfComponents]));
    return (width);
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    if(self.delegate && [self.delegate respondsToSelector:@selector(popoutView:pickerView:rowHeightForComponent:)]) {
        return ([self.delegate popoutView:self pickerView:pickerView rowHeightForComponent:component]);
    }
    return (40);
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(self.delegate && [self.delegate respondsToSelector:@selector(popoutView:pickerView:titleForRow:forComponent:)]) {
        return ([self.delegate popoutView:self pickerView:pickerView titleForRow:row forComponent:component]);
    }
    return (nil);
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if(self.delegate && [self.delegate respondsToSelector:@selector(popoutView:pickerView:attributedTitleForRow:forComponent:)]) {
        return ([self.delegate popoutView:self pickerView:pickerView attributedTitleForRow:row forComponent:component]);
    }
    return (nil);
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if(self.delegate && [self.delegate respondsToSelector:@selector(popoutView:pickerView:didSelectRow:inComponent:)]) {
        return([self.delegate popoutView:self pickerView:pickerView didSelectRow:row inComponent:component]);
    }
}
#pragma mark -

#pragma mark - buttons action
- (void)buttonTouched:(UIButton *)button {
    NSInteger index = button.tag - SO_POPOVERVIEW_BUTTON_START_TAG;
    if(_delegate && [_delegate respondsToSelector:@selector(popoutView:buttonDidTouchedAtIndex:)]) {
        [_delegate popoutView:self buttonDidTouchedAtIndex:index];
    }
}
#pragma mark -

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if(_dataSource && [_dataSource respondsToSelector:@selector(popoutView:numberOfComponentsInPickerView:)]) {
        return ([_dataSource popoutView:self numberOfComponentsInPickerView:pickerView]);
    }
    return (1);
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if(_dataSource && [_dataSource respondsToSelector:@selector(popoutView:pickerView:numberOfRowsInComponent:)]) {
        return ([_dataSource popoutView:self pickerView:pickerView numberOfRowsInComponent:component]);
    }
    return (1);
}
#pragma mark -

@end

