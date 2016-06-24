//
//  SOSegmentControlItem.m
//  SOKit
//
//  Created by soso on 13-2-21.
//  Copyright (c) 2013-2015 soso. All rights reserved.
//

#import "SOSegmentControlItem.h"
#import "SOGlobal.h"

@implementation SOSegmentControlItem
@synthesize text = _text;
@synthesize font = _font, highlightedFont = _highlightedFont;
@synthesize image = _image, highlightedImage = _highlightedImage;
@synthesize textColor = _textColor, highlightedTextColor = _highlightedTextColor;
@synthesize titleEdgeInset = _titleEdgeInset;

+ (instancetype)itemWithText:(NSString *)text
                       image:(UIImage *)image {
    return ([self itemWithText:text image:image titleInsets:UIEdgeInsetsZero]);
}

+ (instancetype)itemWithText:(NSString *)text
                       image:(UIImage *)image
                 titleInsets:(UIEdgeInsets)titleInsets {
    return ([self itemWithText:text
                          font:[UIFont systemFontOfSize:14]
                         image:image
                   titleInsets:titleInsets]);
}

+ (instancetype)itemWithText:(NSString *)text
                        font:(UIFont *)font
                       image:(UIImage *)image
                 titleInsets:(UIEdgeInsets)titleInsets {
    return ([self itemWithText:text
                     textColor:[UIColor blackColor]
                          font:font
                         image:image
                   titleInsets:titleInsets]);
}

+ (instancetype)itemWithText:(NSString *)text
                   textColor:(UIColor *)textColor
                        font:(UIFont *)font
                       image:(UIImage *)image
                 titleInsets:(UIEdgeInsets)titleInsets {
    return ([self itemWithText:text
                     textColor:textColor
          highlightedTextColor:textColor
                          font:font
               highlightedFont:font
                         image:image
                   titleInsets:titleInsets]);
}

+ (instancetype)itemWithText:(NSString *)text
                   textColor:(UIColor *)textColor
        highlightedTextColor:(UIColor *)highlightedTextColor
                        font:(UIFont *)font
             highlightedFont:(UIFont *)highlightedFont
                       image:(UIImage *)image
                 titleInsets:(UIEdgeInsets)titleInsets {
    return ([self itemWithText:text
                     textColor:textColor
          highlightedTextColor:highlightedTextColor
                          font:font
               highlightedFont:highlightedFont
                         image:image
             highlightedImage:image
                   titleInsets:titleInsets]);
}

+ (instancetype)itemWithText:(NSString *)text
                   textColor:(UIColor *)textColor
        highlightedTextColor:(UIColor *)highlightedTextColor
                        font:(UIFont *)font
             highlightedFont:(UIFont *)highlightedFont
                       image:(UIImage *)image
            highlightedImage:(UIImage *)highlightedImage
                 titleInsets:(UIEdgeInsets)titleInsets {
    SOSegmentControlItem *item = [SOSegmentControlItem item];
    item.text = text;
    item.textColor = textColor;
    item.highlightedTextColor = highlightedTextColor;
    item.font = font;
    item.highlightedFont = highlightedFont;
    item.image = image;
    item.highlightedImage = highlightedImage;
    item.titleEdgeInset = titleInsets;
    return (item);
}

- (void)dealloc {
    SORELEASE(_text);
    SORELEASE(_font);
    SORELEASE(_highlightedFont);
    SORELEASE(_image);
    SORELEASE(_highlightedImage);
    SORELEASE(_textColor);
    SORELEASE(_highlightedTextColor);
    SOSUPERDEALLOC();
}

- (instancetype)init {
    self = [super init];
    if(self) {
        self.text = nil;
        self.font = [UIFont systemFontOfSize:14];
        self.highlightedFont = [UIFont systemFontOfSize:14];
        self.image = self.highlightedImage = nil;
        self.textColor = [UIColor blackColor];
        self.highlightedTextColor = [UIColor lightGrayColor];
        self.titleEdgeInset = UIEdgeInsetsZero;
    }
    return (self);
}

- (NSString *)description {
    return ([[super description] stringByAppendingFormat:@"< %@; title = %@; font = %@; >", NSStringFromClass([self class]), self.text, self.font]);
}

#pragma mark - <NSCopying>
- (id)copyWithZone:(NSZone *)zone {
    SOSegmentControlItem *item = [super copyWithZone:zone];
    item.text = self.text;
    item.font = self.font;
    item.highlightedFont = self.highlightedFont;
    item.textColor = self.textColor;
    item.highlightedTextColor = self.highlightedTextColor;
    item.titleEdgeInset = self.titleEdgeInset;
    item.image = self.image;
    item.highlightedImage = self.highlightedImage;
    return (item);
}
#pragma mark -

@end
