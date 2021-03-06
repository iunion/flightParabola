//
//  UIImageAdditions.h
//  Created by Devin Ross on 7/25/09.
//
/*
 
 tapku.com || http://github.com/devinross/tapkulibrary
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import <UIKit/UIKit.h>
#import <CoreLocation/CLLocation.h>


#define ROUNDEDRECT_PERCENTAGE 10

typedef NS_ENUM(NSInteger, IMAGE_GRAYSCALETYPE)
{
    IMAGE_GRAYSCALETYPE_GRAY = 0,
    IMAGE_GRAYSCALETYPE_BROWN,
    IMAGE_GRAYSCALETYPE_INVERSE
};

@interface UIImage (Category)

- (UIImage *)stretchableImage;

- (UIImage *)resizedImageModeTile;
+ (UIImage *)resizedImageModeTileWithName:(NSString *)name;

// add by HQF
// 图片拉伸
+ (UIImage *)resizedImageWithName:(NSString *)name;
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

// 图片先压缩到size大小然后再做圆角大小为r，然后在view上圆角与图片可能被等比拉伸/缩放
+ (id)createRoundedRectImage:(UIImage *)image size:(CGSize)size radius:(NSInteger)r;
// 先在原图做r大的圆角，然后在view上圆角与图片可能被等比拉伸/缩放
+ (id)createRoundedRectImage:(UIImage *)image radius:(NSInteger)r;

// 文字转为图片
+ (UIImage *)imageFromText:(NSString *)text;
+ (UIImage *)imageFromText:(NSString *)text font:(UIFont *)font size:(CGSize)size;


// 画水印
// 图片水印
- (UIImage *) imageWithWaterMask:(UIImage *)mask inRect:(CGRect)rect;
// 文字水印
- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font;
- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font;


// 蒙板
- (UIImage *) imageWithColor:(UIColor*)color inRect:(CGRect)rect;


// 保存图像文件
- (BOOL) writeImageToFileAtPath:(NSString *)aPath;


// 图像旋转(角度)
- (UIImage *) imageRotatedByDegrees:(CGFloat)degrees;


// 黑白
- (UIImage *)convertToGrayScale;    // 有黑底
- (UIImage *)imageWithBlackWhite;

// 图片处理 黑白灰度 做旧深棕色 反色
- (UIImage *)grayScaleWithType:(NSInteger)type;

@end


@interface UIImage (Border)

- (UIImage *) imageWithColoredBorder:(NSUInteger)borderThickness borderColor:(UIColor *)color withShadow:(BOOL)withShadow;
- (UIImage *) imageWithTransparentBorder:(NSUInteger)thickness;

@end

@interface UIImage (MGProportionalFill)

typedef enum {
    MGImageResizeCrop,	// analogous to UIViewContentModeScaleAspectFill, i.e. "best fit" with no space around.
    MGImageResizeCropStart,
    MGImageResizeCropEnd,
    MGImageResizeScale	// analogous to UIViewContentModeScaleAspectFit, i.e. scale down to fit, leaving space around if necessary.
} MGImageResizingMethod;

- (UIImage *)imageToFitSize:(CGSize)size method:(MGImageResizingMethod)resizeMethod;
- (UIImage *)imageCroppedToFitSize:(CGSize)size; // uses MGImageResizeCrop
- (UIImage *)imageScaledToFitSize:(CGSize)size; // uses MGImageResizeScale

@end

@interface UIImage (Blur)
- (UIImage *)boxblurImageWithBlur:(CGFloat)blur;
@end

@interface UIImage (ImageMetadata)
- (NSMutableDictionary *)getImageMetadata;
- (NSData *)setImageDateTime:(NSDate *)date latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude withCompressionQuality:(CGFloat)compressionQuality;
- (NSData *)setImageMetadata:(NSMutableDictionary *)metaData;
- (NSData *)setImageMetadata:(NSMutableDictionary *)metaData withCompressionQuality:(CGFloat)compressionQuality;
@end


