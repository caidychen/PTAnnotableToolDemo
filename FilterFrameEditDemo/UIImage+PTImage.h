//
//  UIImage+PTImage.h
//
//  Created by CHEN KAIDI on 14/3/2016.
//  Copyright © 2016 Putao. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import <UIKit/UIKit.h>

/**
 *  Enum types for image flip directions
 */
typedef NS_ENUM(NSInteger, PTImageFlipDirection) {
    /**
     *  Invalid flip direction
     */
    PTImageFlipDirectionUnknown = 0,
    /**
     *  Flip horizontally
     */
    PTImageFlipDirectionHorizontal = 1,
    /**
     *  Flip vertically
     */
    PTImageFlipDirectionVertical = 2,
};

typedef NS_ENUM(NSInteger, PTImageCompressQuality){
    PTImageCompressQualityUnknown = 0,
    PTImageCompressQualityHigh = 1,
    PTImageCompressQualityMedium = 2,
    PTImageCompressQualityLow = 3,
    PTImageCompressQualityExtraLow = 4,
};

@interface UIImage (PTImage)

/**
 *  Calculate average RGB values according to pixels on a given image
 *
 *  @return UIColor of average RGB color
 */

- (UIColor *)averageColor;

/**
 *  Resize an image with scale
 *
 *  @param scale Scale factor
 *
 *  @return Scaled image
 */
- (UIImage *)resizeImageByScaleFactor:(CGFloat)scale;

/**
 *  Compress image based on quality preset
 *
 *  @param compressQuality See PTImageCompressQuality
 *
 *  @return Compressed image
 */
- (UIImage *)compressImageToQuality:(PTImageCompressQuality)compressQuality;

/**
 *  Compress image based on given custom resolution
 *  Note: Custom resolution at factor of 16 is highly recommended.
 *
 *  @param resolution Maximum resoltuion
 *
 *  @return Compressed image
 */
- (UIImage *)compressImageToResolution:(NSInteger)resolution;

/**
 *  Crop an image within defined rect area
 *
 *  @param rect CGRect frame where image to be cropped
 *
 *  @return Cropped image
 */

- (UIImage *)croppIngimageToRect:(CGRect)rect;

- (UIImage *)croppIngimageToRect:(CGRect)rect relativeToImageFrame:(CGRect)imageFrame;

/**
 *  Rotate an image with specific degrees
 *
 *  @param degrees Rotation degrees
 *
 *  @return Rotated image
 */
- (UIImage *)rotatedByDegrees:(CGFloat)degrees;

/**
 *  Flip an image horizontally or vertically
 *
 *  @param flipDirection PTImageFlipDirection
 *
 *  @return Flipped image
 */
- (UIImage *)flip:(PTImageFlipDirection)flipDirection;

/**
 *  Hacking method to fix orientation problem of some photos from camera roll
 *
 *  @return Image with portrait orientation
 */
- (UIImage *)forcePortraitOrientation;

/**
 *  Quick method for image blurring effect with default light tint color
 *
 *  @return Blurred image
 */
- (UIImage *)imgWithBlurredEffect;

/**
 *  Method for image blurring effect effect with specific alpha and radius settings
 *
 *  @param alpha  Alpha value for tint color
 *  @param radius Blur radius
 *  @param colorSaturationFactor Saturation
 *
 *  @return Blurred image
 */
- (UIImage *)imgWithLightAlpha:(CGFloat)alpha radius:(CGFloat)radius colorSaturationFactor:(CGFloat)colorSaturationFactor;

/**
 *  Complete method for image blurring effect with full parameter settings
 *  Note: Make sure your alpha value for tintColor is not 1.0 - you would end up seeing a solid tintColor with no blurring image at all. 
 *
 *  @param blurRadius            Blur radius
 *  @param tintColor             Tint color
 *  @param saturationDeltaFactor Saturation
 *  @param maskImage             Mask image
 *
 *  @return Blurred image
 */
- (UIImage *)imgBluredWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

/**
 *  Stretch an UIImage given edge insets
 *
 *  @param edgeInsets Edge insets for defining how the image will be stretched
 *
 *  @return Stretched image
 */
- (UIImage *)stretchableImageWithedgeInsets:(UIEdgeInsets)edgeInsets;
@end
