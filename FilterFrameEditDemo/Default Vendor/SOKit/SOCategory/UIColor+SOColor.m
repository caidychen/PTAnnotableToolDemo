//
//  UIColor+SOColor.m
//  SOKit
//
//  Created by soso on 14-12-19.
//  Copyright (c) 2015年 com.. All rights reserved.
//

#import "UIColor+SOColor.h"
#import "SOGlobal.h"

SOColorComponents const SOColorComponentsZero = (SOColorComponents){.r = 0, .g = 0, .b = 0, .a = 0};

SOColorComponents SOColorComponentsMake(CGFloat r, CGFloat g, CGFloat b, CGFloat a) {
    SOColorComponents cc = SOColorComponentsZero;
    cc.r = r;
    cc.g = g;
    cc.b = b;
    cc.a = a;
    return (cc);
}

SOColorComponents SOColorComponentsWithUIColor(UIColor *color) {
    return (SOColorComponentsWithCGColor(color.CGColor));
}

SOColorComponents SOColorComponentsWithCGColor(CGColorRef color) {
    CGFloat a = 1;
    const CGFloat *c = CGColorGetComponents(color);
    size_t cpts = CGColorGetNumberOfComponents(color);
    if(cpts > 3) {
        a = c[cpts - 1];
    }
    CGFloat r = c[0];
    CGFloat g = c[1];
    CGFloat b = c[2];
    return (SOColorComponentsMake(r, g, b, a));
}

CGColorRef CGColorWithColorComponents(SOColorComponents components) {
    return (UIColorWithColorComponents(components).CGColor);
}

UIColor * UIColorWithColorComponents(SOColorComponents components) {
    return ([UIColor colorWithRed:components.r
                            green:components.g
                             blue:components.b
                            alpha:components.a]);
}

@implementation UIColor(SOColor)

+ (UIColor *)randomColor {
    return ([self randomColorWithAlpha:SORandom()]);
}

+ (UIColor *)randomColorWithAlpha:(CGFloat)alpha {
    return ([UIColor colorWithRed:SORandom() green:SORandom() blue:SORandom() alpha:alpha]);
}

- (CGColorSpaceModel)colorSpaceModel {
    return CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor));
}

- (NSString *)colorSpaceString {
    switch ([self colorSpaceModel]) {
        case kCGColorSpaceModelUnknown:
            return (@"kCGColorSpaceModelUnknown");
            break;
            
        case kCGColorSpaceModelMonochrome:
            return (@"kCGColorSpaceModelMonochrome");
            break;
            
        case kCGColorSpaceModelRGB:
            return (@"kCGColorSpaceModelRGB");
            break;
            
        case kCGColorSpaceModelCMYK:
            return (@"kCGColorSpaceModelCMYK");
            break;
            
        case kCGColorSpaceModelLab:
            return (@"kCGColorSpaceModelLab");
            break;
            
        case kCGColorSpaceModelDeviceN:
            return (@"kCGColorSpaceModelDeviceN");
            break;
            
        case kCGColorSpaceModelIndexed:
            return (@"kCGColorSpaceModelIndexed");
            break;
            
        case kCGColorSpaceModelPattern:
            return (@"kCGColorSpaceModelPattern");
            break;
            
        default:
            return (@"Not a valid color space");
            break;
    }
}

- (CGFloat)red {
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return (c[0]);
}

- (CGFloat)green {
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome)
        return (c[0]);
    
    return (c[1]);
}

- (CGFloat)blue {
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    if ([self colorSpaceModel] == kCGColorSpaceModelMonochrome) {
        return (c[0]);
    }
    return (c[2]);
}

- (CGFloat)alpha {
    size_t cpts =CGColorGetNumberOfComponents(self.CGColor);
    if(cpts <= 3) {
        return (-1.0f);
    }
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    return (c[cpts - 1]);
}

- (instancetype)selectedColor {
    SOColorComponents ccp = SOColorComponentsWithUIColor(self);
    ccp.r *= (ccp.r > 0.5f) ? 0.9f : 1.1f;
    ccp.g *= (ccp.g > 0.5f) ? 0.9f : 1.1f;
    ccp.b *= (ccp.b > 0.5f) ? 0.9f : 1.1f;
    return ([UIColor colorWithRed:ccp.r
                            green:ccp.g
                             blue:ccp.b
                            alpha:ccp.a]);
}

- (instancetype)highlightColor {
    SOColorComponents ccp = SOColorComponentsWithUIColor(self);
    ccp.a *= 0.5f;
    return ([UIColor colorWithRed:ccp.r
                            green:ccp.g
                             blue:ccp.b
                            alpha:ccp.a]);
}

- (instancetype)disableColor {
    SOColorComponents ccp = SOColorComponentsWithUIColor(self);
    ccp.a *= 0.3f;
    return ([UIColor colorWithRed:ccp.r
                            green:ccp.g
                             blue:ccp.b
                            alpha:ccp.a]);
}

- (instancetype)invertColor {
    SOColorComponents ccp = SOColorComponentsWithUIColor(self);
    ccp.r = 1.0f - ccp.r;
    ccp.g = 1.0f - ccp.g;
    ccp.b = 1.0f - ccp.b;
    ccp.a = 1.0f - ccp.a;
    return ([UIColor colorWithRed:ccp.r
                            green:ccp.g
                             blue:ccp.b
                            alpha:ccp.a]);
}

- (UIColor *)colorToColor:(UIColor *)color progress:(double)progress {
    SOColorComponents ccp = SOColorComponentsWithUIColor(self);
    SOColorComponents tccp = SOColorComponentsWithUIColor(color);
    CGFloat pr = ccp.r + (tccp.r - ccp.r) * progress;
    CGFloat pg = ccp.g + (tccp.g - ccp.g) * progress;
    CGFloat pb = ccp.b + (tccp.b - ccp.b) * progress;
    CGFloat pa = ccp.a + (tccp.a - ccp.a) * progress;
    return ([UIColor colorWithRed:pr
                            green:pg
                             blue:pb
                            alpha:pa]);
}

+ (CGFloat) colorComponentFrom: (NSString *) string start: (NSUInteger) start length: (NSUInteger) length

{
    
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    
    unsigned hexComponent;
    
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    
    return hexComponent / 255.0;
    
}

+ (UIColor *) colorWithHexString: (NSString *) hexString

{
    
    NSString *colorString = [[hexString stringByReplacingOccurrencesOfString: @"#"withString: @""] uppercaseString];
    
    CGFloat alpha, red, blue, green;
    
    switch ([colorString length]) {
            
        case 3: // #RGB
            
            alpha = 1.0f;
            
            red   = [self colorComponentFrom: colorString start: 0 length: 1];
            
            green = [self colorComponentFrom: colorString start: 1 length: 1];
            
            blue  = [self colorComponentFrom: colorString start: 2 length: 1];
            
            break;
            
        case 4: // #ARGB
            
            alpha = [self colorComponentFrom: colorString start: 0 length: 1];
            
            red   = [self colorComponentFrom: colorString start: 1 length: 1];
            
            green = [self colorComponentFrom: colorString start: 2 length: 1];
            
            blue  = [self colorComponentFrom: colorString start: 3 length: 1];
            
            break;
            
        case 6: // #RRGGBB
            
            alpha = 1.0f;
            
            red   = [self colorComponentFrom: colorString start: 0 length: 2];
            
            green = [self colorComponentFrom: colorString start: 2 length: 2];
            
            blue  = [self colorComponentFrom: colorString start: 4 length: 2];
            
            break;
            
        case 8: // #AARRGGBB
            
            alpha = [self colorComponentFrom: colorString start: 0 length: 2];
            
            red   = [self colorComponentFrom: colorString start: 2 length: 2];
            
            green = [self colorComponentFrom: colorString start: 4 length: 2];
            
            blue  = [self colorComponentFrom: colorString start: 6 length: 2];
            
            break;
            
        default:
            
            [NSException raise:@"Invalid color value" format: @"Color value %@ is invalid.  It should be a hex value of the form #RBG, #ARGB, #RRGGBB, or #AARRGGBB", hexString];
            
            break;
            
    }
    
    return [UIColor colorWithRed: red green: green blue: blue alpha: alpha];
    
}


@end
