//
//  SOTextFieldListView.m
//  SOKit
//
//  Created by Soal on 13-11-4.
//  Copyright (c) 2013-2015 chinaPnr. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SOTextFieldListView.h"
#import "SOGlobal.h"
#import "NSObject+SOObject.h"

@implementation SOTextFieldItem

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text {
    return ([self itemWithTitle:title
                           text:text
                    placeholder:nil]);
}

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder {
    return ([self itemWithTitle:title
                           text:text
                    placeholder:placeholder
                           font:[UIFont systemFontOfSize:14]]);
}

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font {
    return ([self itemWithTitle:title
                           text:text
                    placeholder:placeholder
                           font:font
                          image:nil]);
}

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image {
    return ([self itemWithTitle:title
                           text:text
                    placeholder:placeholder
                           font:font
                          image:image
                    borderColor:nil
                    borderWidth:0]);
}

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth {
    return ([self itemWithTitle:title
                           text:text
                    placeholder:placeholder
                           font:font
                          image:image
                    borderColor:borderColor
                    borderWidth:borderWidth
                   cornerRadius:0]);
}

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 cornerRadius:(CGFloat)cornerRadius {
    return ([self itemWithTitle:title
                           text:text
                    placeholder:placeholder
                           font:font
                          image:image
                    borderColor:borderColor
                    borderWidth:borderWidth
                   cornerRadius:cornerRadius
                   keyboardType:UIKeyboardTypeDefault
                         enable:YES]);
}

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 cornerRadius:(CGFloat)cornerRadius
                 keyboardType:(UIKeyboardType)keyboardType {
    return ([self itemWithTitle:title
                           text:text
                    placeholder:placeholder
                           font:font
                          image:image
                    borderColor:borderColor
                    borderWidth:borderWidth
                   cornerRadius:cornerRadius
                   keyboardType:keyboardType
                         enable:YES]);
}

+ (instancetype)itemWithTitle:(NSString *)title
                         text:(NSString *)text
                  placeholder:(NSString *)placeholder
                         font:(UIFont *)font
                        image:(UIImage *)image
                  borderColor:(UIColor *)borderColor
                  borderWidth:(CGFloat)borderWidth
                 cornerRadius:(CGFloat)cornerRadius
                 keyboardType:(UIKeyboardType)keyboardType
                       enable:(BOOL)enable {
    SOTextFieldItem *item = [self item];
    item.title = title;
    item.text = text;
    item.placeholder = placeholder;
    item.font = font;
    item.image = image;
    item.borderColor = borderColor;
    item.borderWidth = borderWidth;
    item.cornerRadius = cornerRadius;
    item.keyboardType = keyboardType;
    item.enable = enable;
    return (item);
}

- (void)dealloc {
    SORELEASE(_image);
    SORELEASE(_font);
    SORELEASE(_borderColor);
    SORELEASE(_title);
    SORELEASE(_placeholder);
    SORELEASE(_text);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    self = [super init];
    if(self) {
        _image = nil;
        self.font = [UIFont systemFontOfSize:14];
        self.borderColor = [UIColor clearColor];
        _title = _placeholder = _text = nil;
        _keyboardType = UIKeyboardTypeDefault;
        _borderWidth = 0;
        _cornerRadius = 0;
        _enable = YES;
    }
    return (self);
}

- (NSString *)description {
    return ([[super description] stringByAppendingFormat:@"< %@; image = %@; font = %@; borderColor = %@; title = %@; placeholder = %@; text = %@; keyboardType = %@; borderWidth = %@; cornerRadius = %@; enable = %@; >", NSStringFromClass([self class]), self.image, self.font, self.borderColor, self.title, self.placeholder, self.text, @(self.keyboardType), @(self.borderWidth), @(self.cornerRadius), @(self.enable)]);
}

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    SOTextFieldItem *item = [super copyWithZone:zone];
    item.image = self.image;
    item.font = self.font;
    item.borderColor = self.borderColor;
    item.title = self.title;
    item.placeholder = self.placeholder;
    item.text = self.text;
    item.keyboardType = self.keyboardType;
    item.borderWidth = self.borderWidth;
    item.cornerRadius = self.cornerRadius;
    item.enable = self.enable;
    return (item);
}
#pragma mark -

@end



@interface SOTextFieldListView () <UITextFieldDelegate, UIGestureRecognizerDelegate> {
    CGFloat _keyboardHeight;
}
@property (strong, nonatomic) NSMutableArray *textFieldArray;
@end

@implementation SOTextFieldListView
@synthesize scrView = _scrView;

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    SORELEASE(_scrView);
    SORELEASE(_textFieldArray);
    SOSUPERDEALLOC();
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _indenWidth = 10.0f;
        _lineHeight = 40.0f;
        _lineSpace = 5.0f;
        
        _titleWidth = 80.0f;
        _textWidth = 160.0f;
        _keyboardHeight = 216.0f;
        
        _autoScroll = YES;
        _delegate = nil;
        
        [self addSubview:self.scrView];
        
        _textFieldArray = [[NSMutableArray alloc] initWithCapacity:0];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
        SORELEASE(tapGesture);
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.scrView.frame = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
    self.scrView.contentSize = CGSizeMake(CGRectGetWidth(self.scrView.bounds), _lineSpace + (_lineSpace + _lineHeight) * _textFieldArray.count);
    CGFloat width = self.bounds.size.width - _indenWidth * 2.0f;
    for(NSInteger index = 0; index < _textFieldArray.count; index ++) {
        CGFloat positionY = _lineSpace + (_lineSpace + _lineHeight) * index;
        SOScrollTextCellView *cell = (SOScrollTextCellView *)[_textFieldArray safeObjectAtIndex:index];
        cell.horizontalSpace = self.horizontalSpace;
        cell.titleWidth = _titleWidth;
        cell.textWidth = _textWidth;
        cell.frame = CGRectMake(_indenWidth, positionY, width, _lineHeight);
    }
}

#pragma mark - getter
- (UIScrollView *)scrView {
    if(!_scrView) {
        _scrView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrView.scrollEnabled = YES;
        _scrView.pagingEnabled = NO;
        _scrView.backgroundColor = [UIColor clearColor];
    }
    return (_scrView);
}

- (NSArray *)textList {
    NSMutableArray *txArray = [NSMutableArray arrayWithCapacity:0];
    for(SOScrollTextCellView *cl in _textFieldArray) {
        id tx = cl.textField.text;
        if(tx && tx != [NSNull null]) {
            [txArray addObject:tx];
        } else {
            [txArray addObject:@""];
        }
    }
    return (txArray);
}

- (NSString *)cellTextAtIndex:(NSInteger)index {
    SOScrollTextCellView *cell = [self cellViewAtIndex:index];
    if(!cell) {
        return (nil);
    }
    return (cell.textField.text);
}

- (SOScrollTextCellView *)cellViewAtIndex:(NSUInteger)index {
    SOScrollTextCellView *cl = nil;
    if(index < _textFieldArray.count) {
        cl = (SOScrollTextCellView *)[_textFieldArray safeObjectAtIndex:index];
    }
    return (cl);
}

- (SOScrollTextCellView *)lastCellView {
    return ([_textFieldArray lastObject]);
}
#pragma mark -

#pragma mark - setter
- (void)setHorizontalSpace:(CGFloat)horizontalSpace {
    [super setHorizontalSpace:horizontalSpace];
    [self setNeedsLayout];
}

- (void)setTitleWidth:(CGFloat)titleWidth {
    _titleWidth = titleWidth;
    [self setNeedsLayout];
}

- (void)setIndenWidth:(CGFloat)indenWidth {
    _indenWidth = indenWidth;
    [self setNeedsLayout];
}

- (void)setLineHeight:(CGFloat)lineHeight {
    _lineHeight = lineHeight;
    [self setNeedsLayout];
}

- (void)setLineSpace:(CGFloat)lineSpace {
    _lineSpace = lineSpace;
    [self setNeedsLayout];
}

- (void)setCellItems:(NSArray *)items {
    [_textFieldArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [_textFieldArray removeAllObjects];
    for(SOTextFieldItem *item in items) {
        SOScrollTextCellView *cellView = [[SOScrollTextCellView alloc] init];
        cellView.imageView.image = item.image;
        cellView.titleLabel.text = item.title;
        cellView.textField.placeholder = item.placeholder;
        cellView.textField.text = item.text;
        cellView.textField.font = cellView.titleLabel.font = item.font;
        cellView.textField.keyboardType = item.keyboardType;
        cellView.textField.delegate = self;
        
        cellView.textField.layer.borderColor = item.borderColor.CGColor;
        cellView.textField.layer.borderWidth = item.borderWidth;
        cellView.textField.layer.cornerRadius = item.cornerRadius;
        
        cellView.textField.enabled = item.enable;
        
        [_textFieldArray addObject:cellView];
        [_scrView addSubview:cellView];
        SORELEASE(cellView);
    }
    [self setNeedsLayout];
}
#pragma mark -

#pragma mark - actions
- (void)hideKeyboard {
    [self endEditing:YES];
    if(self.delegate && [self.delegate respondsToSelector:@selector(textFieldListDidEndEditing:)]) {
        [self.delegate textFieldListDidEndEditing:self];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification {
    if(!notification || ![notification isKindOfClass:[NSNotification class]]) {
        return;
    }
    NSDictionary *userInfo = [notification userInfo];
    if(!userInfo || ![userInfo isKindOfClass:[NSDictionary class]]) {
        return;
    }
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    CGRect contentKeyboardFrame = [self convertRect:keyboardFrame fromView:keyWindow];
    CGRect contentFrame = UIEdgeInsetsInsetRect(self.scrView.frame, self.scrView.contentInset);
    CGFloat heightOffset = CGRectGetMaxY(contentFrame) - CGRectGetMinY(contentKeyboardFrame);
    UIEdgeInsets insets = self.scrView.contentInset;
    insets.bottom = heightOffset;
    [self.scrView setContentInset:insets];
}

- (void)keyboardWillHide:(NSNotification *)notification {
    self.scrView.contentInset = UIEdgeInsetsZero;
}
#pragma mark -

#pragma mark - <UIGestureRecognizerDelegate>
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    UIView *touchView = [touch view];
    if([touchView isKindOfClass:[UIControl class]]) {
        return (NO);
    }
    return (YES);
}
#pragma mark -

@end
