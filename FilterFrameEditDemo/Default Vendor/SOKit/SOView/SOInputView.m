//
//  NOENowScoreDiscussInputView.m
//  Lottery
//
//  Created by soso on 15/3/17.
//  Copyright (c) 2015年 9188-MacPro1. All rights reserved.
//

#import "SOInputView.h"
#import "UIView+Additions.h"
#import "NSString+SOAdditions.h"
#import "SOGlobal.h"

@interface SOPlaceHolderTextView () {
    @private
    UIImageView *_holderImageView;
    UILabel *_holderLabel;
}
@end


@implementation SOPlaceHolderTextView
@synthesize placeHolder = _placeHolder;
@synthesize placeHolderImage = _placeHolderImage;
@synthesize placeHolderFrame = _placeHolderFrame;
@synthesize placeHolderImageFrame = _placeHolderImageFrame;
@synthesize placeHolderAutoFirstLineCenter = _placeHolderAutoFirstLineCenter;
@synthesize holderImageView = _holderImageView;
@synthesize holderLabel = _holderLabel;

- (void)dealloc {
    SORELEASE(_placeHolder);
    SORELEASE(_placeHolderImage);
    SORELEASE(_holderLabel);
    SORELEASE(_holderImageView);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _placeHolder = nil;
        _placeHolderImage = nil;
        _placeHolderFrame = CGRectZero;
        _placeHolderImageFrame = CGRectZero;
        _placeHolderAutoFirstLineCenter = YES;
        [self addSubview:self.holderLabel];
        [self addSubview:self.holderImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if(_placeHolderAutoFirstLineCenter) {
        CGRect inFrame = UIEdgeInsetsInsetRect(self.bounds, self.contentInset);
        if([self respondsToSelector:@selector(textContainerInset)]) {
            inFrame = UIEdgeInsetsInsetRect(inFrame, [self textContainerInset]);
        }
        self.holderImageView.centerY = self.holderLabel.centerY = CGRectGetMidY(inFrame);
    }
}

//#pragma mark - actions
//- (BOOL)becomeFirstResponder {
//    [self checkText];
//    BOOL f = NO;
//    if(![self isFirstResponder]) {
//        f = [super becomeFirstResponder];
//    }
//    self.holderLabel.hidden = self.holderImageView.hidden = YES;
//    return (f);
//}
//
//- (BOOL)resignFirstResponder {
//    BOOL f = NO;
//    if([self isFirstResponder]) {
//        f = [super resignFirstResponder];
//    }
//    [self checkText];
//    return (f);
//}
//
//- (void)checkText {
//    BOOL haveText = (BOOL)(self.text && [self.text length] > 0);
//    self.holderLabel.hidden = self.holderImageView.hidden = haveText;
//}
//#pragma mark -

#pragma mark - getter
- (UIImageView *)holderImageView {
    if(!_holderImageView) {
        _holderImageView = [[UIImageView alloc] init];
        _holderImageView.backgroundColor = [UIColor clearColor];
    }
    return (_holderImageView);
}

- (UILabel *)holderLabel {
    if(!_holderLabel) {
        _holderLabel = [[UILabel alloc] init];
        _holderLabel.font = self.font;
        _holderLabel.textAlignment = self.textAlignment;
        _holderLabel.textColor = [UIColor lightGrayColor];
    }
    return (_holderLabel);
}
#pragma mark -

#pragma mark - setter
- (void)setPlaceHolderFrame:(CGRect)placeHolderFrame {
    _placeHolderFrame = placeHolderFrame;
    self.holderLabel.frame = placeHolderFrame;
}

- (void)setPlaceHolderImageFrame:(CGRect)placeHolderImageFrame {
    _placeHolderImageFrame = placeHolderImageFrame;
    self.holderImageView.frame = _placeHolderImageFrame;
}

- (void)setText:(NSString *)text {
    [super setText:text];
    //[self checkText];
}

- (void)setFont:(UIFont *)font {
    [super setFont:font];
    self.holderLabel.font = font;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    [super setTextAlignment:textAlignment];
    self.holderLabel.textAlignment = textAlignment;
}

- (void)setPlaceHolderColor:(UIColor *)placeHolderColor {
    self.holderLabel.textColor = placeHolderColor;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    NSString *cpPlaceholder = [placeHolder copy];
    SORELEASE(_placeHolder);
    _placeHolder = cpPlaceholder;
    self.holderLabel.text = _placeHolder;
    self.holderLabel.width = CGRectGetWidth(self.bounds) - CGRectGetMaxX(_placeHolderImageFrame);
    [self.holderLabel sizeToFit];
    self.holderLabel.hidden = (BOOL)(!_placeHolder || [_placeHolder length] == 0);
}

- (void)setPlaceHolderImage:(UIImage *)placeHolderImage {
    SORELEASE(_placeHolderImage);
    if(!placeHolderImage) {
        return;
    }
    _placeHolderImage = SORETAIN(placeHolderImage);
    self.holderImageView.image = _placeHolderImage;
    self.holderImageView.hidden = (BOOL)!_placeHolderImage;
}
#pragma mark -

@end


@interface SOInputView () <UITextViewDelegate>
@end

@implementation SOInputView
@synthesize lineNumber = _lineNumber;
@synthesize textViewInsets = _textViewInsets;
@synthesize textView = _textView;
@synthesize doneButton = _doneButton;
@synthesize delegate = _delegate;

- (void)dealloc {
    SORELEASE(_textView);
    SORELEASE(_doneButton);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    return ([self initWithFrame:CGRectZero]);
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        _lineNumber = 1;
        _textViewInsets = UIEdgeInsetsZero;
        _delegate = nil;
        [self addSubview:self.textView];
        [self addSubview:self.doneButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat space = 10.0f;
    CGRect inFrame = UIEdgeInsetsInsetRect(self.bounds, _textViewInsets);
    self.textView.frame = CGRectMake(CGRectGetMinX(inFrame), CGRectGetMinY(inFrame), CGRectGetWidth(inFrame) - space - CGRectGetWidth(self.doneButton.bounds), CGRectGetHeight(inFrame));
    self.textView.layer.cornerRadius = 5.0f;
    self.doneButton.frame = CGRectMake(CGRectGetMaxX(self.textView.frame) + space, 0, CGRectGetWidth(self.doneButton.bounds), CGRectGetHeight(self.doneButton.bounds));
    self.doneButton.centerY = CGRectGetHeight(self.bounds) - (_textViewInsets.bottom + NOENowScoreDiscussInputTextViewMinHeight / 2.0f);
}

#pragma mark - getter
- (NSString *)text {
    return ([self.textView text]);
}

- (UITextView *)textView {
    if(!_textView) {
        _textView = [[SOPlaceHolderTextView alloc] initWithFrame:UIEdgeInsetsInsetRect(self.bounds, _textViewInsets)];
        _textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _textView.layer.borderWidth = 1.0f / SODeviceScale();
        _textView.backgroundColor = [UIColor whiteColor];
        _textView.textColor = [UIColor blackColor];
        _textView.font = [UIFont systemFontOfSize:14];
        _textView.clipsToBounds = YES;
        _textView.returnKeyType = UIReturnKeyDefault;
        _textView.placeHolderImage = [UIImage imageNamed:@"ns_discuss_edit"];
        _textView.placeHolder = @"写评论";
        CGSize imageSize = CGSizeMake(14.0f, 13.0f);
        CGFloat textToTopAndBottom = floorf((NOENowScoreDiscussInputTextViewMinHeight - imageSize.height) / 2.0f);
        _textView.placeHolderImageFrame = CGRectMake(5.0f, textToTopAndBottom, imageSize.width, imageSize.height);
        _textView.placeHolderFrame = CGRectMake(CGRectGetMaxX(_textView.placeHolderImageFrame) + 3.0f, (NOENowScoreDiscussInputTextViewMinHeight - _textView.font.lineHeight) / 2.0f, 80.0f, _textView.font.lineHeight);
        _textView.contentInset = UIEdgeInsetsZero;
        _textView.delegate = self;
    }
    return (_textView);
}

- (UIButton *)doneButton {
    if(!_doneButton) {
        _doneButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50.0f, 25.0f)];
        [_doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_doneButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_doneButton setTitle:@"Done" forState:UIControlStateNormal];
        _doneButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _doneButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _doneButton.layer.borderWidth = 1.0f / SODeviceScale();
        _doneButton.layer.cornerRadius = 2.0f;
        [_doneButton addTarget:self action:@selector(doneButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    }
    return (_doneButton);
}
#pragma mark -

#pragma mark - setter
- (void)setText:(NSString *)text {
    [self.textView setText:text];
}
#pragma mark -

#pragma mark - actions
- (void)doneButtonTouched:(id)sender {
    if(_delegate && [_delegate respondsToSelector:@selector(discussInputView:doneButtonTouched:)]) {
        [_delegate discussInputView:self doneButtonTouched:sender];
    }
}
#pragma mark -

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if(_delegate && [_delegate respondsToSelector:@selector(discussInputView:textViewDidBeginEditing:)]) {
        [_delegate discussInputView:self textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if(_delegate && [_delegate respondsToSelector:@selector(discussInputView:textViewDidEndEditing:)]) {
        [_delegate discussInputView:self textViewDidEndEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    
    if(textView.text && [textView.text length] > NOENowScoreDiscussInputTextMaxLength) {
        textView.text = [textView.text substringToIndex:NOENowScoreDiscussInputTextMaxLength];
    }
    
//    self.doneButton.enabled = (textView && [textView text] && [[textView text] length] > 0);
    
    [self resetInputViewFrame];
    //[self.textView checkText];
    
    if(_delegate && [_delegate respondsToSelector:@selector(discussInputView:textViewDidChange:)]) {
        [_delegate discussInputView:self textViewDidChange:textView];
    }
}

- (void)resetInputViewFrame {
    CGFloat width = CGRectGetWidth(self.textView.bounds) - self.textView.contentInset.left - self.textView.contentInset.right;
    CGSize textSize = [[self.textView text] soSizeWithFont:self.textView.font constrainedToWidth:width lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat textHeight = ceilf(MAX(NOENowScoreDiscussInputTextViewMinHeight, MIN(self.textView.font.lineHeight * _lineNumber, textSize.height)));
    textHeight += ((_textViewInsets.top + _textViewInsets.bottom) + (self.textView.contentInset.top + self.textView.contentInset.bottom));
    self.height = ceilf(textHeight);
    [self setNeedsLayout];
}
#pragma mark -

@end
