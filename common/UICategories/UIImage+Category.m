//
//  UIImageAdditions.m
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

#import "UIImage+Category.h"
// need Accelerate.framework
#import <Accelerate/Accelerate.h>
#import <ImageIO/ImageIO.h>
#import "NSDate+Category.h"

typedef NS_ENUM(NSInteger, PIXELS)
{
    ALPHA = 0,
    BLUE = 1,
    GREEN = 2,
    RED = 3
};


static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth, float ovalHeight)
{
    float fw, fh;
    
    if (ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


@implementation UIImage (Category)

// 拉伸图片
- (UIImage *)stretchableImage
{
    return [self stretchableImageWithLeftCapWidth:self.size.width/2 topCapHeight:self.size.height/2];
}

- (UIImage *)resizedImageModeTile
{
    UIImage *image = [self resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
    return image;
}

+ (UIImage *)resizedImageModeTileWithName:(NSString *)name
{
    UIImage *image = [UIImage imageNamed:name];
    image = [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0) resizingMode:UIImageResizingModeTile];
    return image;
}

+ (UIImage *)resizedImageWithName:(NSString *)name
{
    return [UIImage resizedImageWithName:name left:0.5 top:0.5];
}

+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [UIImage imageNamed:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGSize size = CGSizeMake(1.0f, 1.0f);
    UIImage *image = [UIImage imageWithColor:color size:size];
    
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    // http://stackoverflow.com/questions/1213790/how-to-get-a-color-image-in-iphone-sdk
    
    //Create a context of the appropriate size
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    if (currentContext == NULL) return nil;
    
    //Build a rect of appropriate size at origin 0,0
    CGRect fillRect = CGRectMake(0, 0, size.width, size.height);
    
    //Set the fill color
    CGContextSetFillColorWithColor(currentContext, color.CGColor);
    
    //Fill the color
    CGContextFillRect(currentContext, fillRect);
    
    //Snap the picture and close the context
    UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return colorImage;
}

// 圆角
+ (id)createRoundedRectImage:(UIImage*)image size:(CGSize)size radius:(NSInteger)r
{
    // the size of CGContextRef
    int w = size.width;
    int h = size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

+ (id)createRoundedRectImage:(UIImage*)image radius:(NSInteger)r
{
    // the size of CGContextRef
    int w = image.size.width;
    int h = image.size.height;
    
    UIImage *img = image;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpace, kCGImageAlphaPremultipliedFirst | kCGBitmapByteOrderDefault);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(context);
    addRoundedRectToPath(context, rect, r, r);
    CGContextClosePath(context);
    CGContextClip(context);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    img = [UIImage imageWithCGImage:imageMasked];
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageMasked);
    
    return img;
}

+ (UIImage *)imageFromText:(NSString *)text
{
    UIFont *font = [UIFont systemFontOfSize:30.0];
    CGSize size  = CGSizeMake(30.0, 30.0);
    
    return [self imageFromText:text font:font size:size];
}

+ (UIImage *)imageFromText:(NSString *)text font:(UIFont *)font size:(CGSize)size
{
    //UIFont* emojiFont = [UIFont fontWithName:@"AppleColorEmoji" size:35.0];
    if (&UIGraphicsBeginImageContextWithOptions != NULL)
    {
        UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunreachable-code"
        UIGraphicsBeginImageContext(size);
#pragma clang diagnostic pop
        
    }
    [text drawAtPoint:CGPointMake(0.0, 0.0) withAttributes:@{NSFontAttributeName:font}];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

// 画水印
- (UIImage *) imageWithWaterMask:(UIImage*)mask inRect:(CGRect)rect
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0)
    {
        UIGraphicsBeginImageContext([self size]);
    }
#endif
    
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    //水印图
    [mask drawInRect:rect];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

- (UIImage *) imageWithStringWaterMark:(NSString *)markString inRect:(CGRect)rect color:(UIColor *)color font:(UIFont *)font
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0)
    {
        UIGraphicsBeginImageContext([self size]);
    }
#endif
    
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //文字颜色
    [color set];
    
    //水印文字
    [markString drawInRect:rect withAttributes:@{NSFontAttributeName:font}];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

- (UIImage *) imageWithStringWaterMark:(NSString *)markString atPoint:(CGPoint)point color:(UIColor *)color font:(UIFont *)font
{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= 40000
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 4.0)
    {
        UIGraphicsBeginImageContextWithOptions([self size], NO, 0.0); // 0.0 for scale means "scale for device's main screen".
    }
#else
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 4.0)
    {
        UIGraphicsBeginImageContext([self size]);
    }
#endif
    
    //原图
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    
    //文字颜色
    [color set];
    
    //水印文字
    [markString drawAtPoint:point withAttributes:@{NSFontAttributeName:font}];
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newPic;
}

// 蒙板
- (UIImage *) imageWithColor:(UIColor*)color inRect:(CGRect)rect
{
    return  [self imageWithWaterMask:[UIImage imageWithColor:color size:rect.size] inRect:rect];
}

- (BOOL) writeImageToFileAtPath:(NSString*)aPath
{
    if ((aPath == nil) || ([aPath isEqualToString:@""]))
    {
        return NO;
    }
    
    @try
    {
        NSData *imageData = nil;
        NSString *ext = [aPath pathExtension];
        if ([ext isEqualToString:@"png"])
        {
            imageData = UIImagePNGRepresentation(self);
        }
        else 
        {   
            // the rest, we write to jpeg
            // 0. best, 1. lost. about compress.
            imageData = UIImageJPEGRepresentation(self, 0);    
        }
        
        if ((imageData == nil) || ([imageData length] <= 0))
        {
            return NO;
        }
        
        [imageData writeToFile:aPath atomically:YES];      
        
        return YES;
    }
    @catch (NSException *e)
    {
        NSLog(@"create thumbnail exception.");
    }
    
    return NO;
}


//
//CGFloat DegreesToRadians(CGFloat degrees);
//CGFloat RadiansToDegrees(CGFloat radians);
//
//
//CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
//CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

#define DegreesToRadians_Loc(ds) (ds * M_PI / 180)
#define RadiansToDegrees_Loc(rs) (rs * 180 / M_PI)

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{  
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians_Loc(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
//    [rotatedViewBox release];
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians_Loc(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (UIImage*)convertToGrayScale
{
	/* const UInt8 luminance = (red * 0.2126) + (green * 0.7152) + (blue * 0.0722); // Good luminance value */
	/// Create a gray bitmap context
	const size_t width = (size_t)self.size.width;
	const size_t height = (size_t)self.size.height;

    CGRect imageRect = CGRectMake(0, 0, self.size.width, self.size.height);

	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
	CGContextRef bmContext = CGBitmapContextCreate(NULL, width, height, 8/*Bits per component*/, width * 3, colorSpace, kCGImageAlphaNone | kCGBitmapByteOrderDefault);
	CGColorSpaceRelease(colorSpace);
	if (!bmContext)
		return nil;

	/// Image quality
	CGContextSetShouldAntialias(bmContext, false);
	CGContextSetInterpolationQuality(bmContext, kCGInterpolationHigh);

	/// Draw the image in the bitmap context
	CGContextDrawImage(bmContext, imageRect, self.CGImage);

	/// Create an image object from the context
	CGImageRef grayscaledImageRef = CGBitmapContextCreateImage(bmContext);
    UIImage *grayscaled = [UIImage imageWithCGImage:grayscaledImageRef scale:self.scale orientation:self.imageOrientation];

	/// Cleanup
	CGImageRelease(grayscaledImageRef);
	CGContextRelease(bmContext);
    
	return grayscaled;
}

- (UIImage *)imageWithBlackWhite
{
    CGSize size = [self size];
    int width = size.width;
    int height = size.height;

    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));

    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);

    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);

    for(int y = 0; y < height; y++)
    {
        for(int x = 0; x < width; x++)
        {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];
            // convert to grayscale using recommended method: http://en.wikipedia.org/wiki/Grayscale#Converting_color_to_grayscale
            uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];

            // set the pixels to gray
            rgbaPixel[RED] = gray;
            rgbaPixel[GREEN] = gray;
            rgbaPixel[BLUE] = gray;
        }
    }

    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);

    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);
    
    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];
    
    // we're done with image now too
    CGImageRelease(image);
    
    return resultUIImage;
}

// 图片处理 灰度 深棕色 反色
- (UIImage *)grayScaleWithType:(NSInteger)type
{
    CGSize size = [self size];
    int width = size.width;
    int height = size.height;

    // the pixels will be painted to this array
    uint32_t *pixels = (uint32_t *) malloc(width * height * sizeof(uint32_t));

    // clear the pixels so any transparency is preserved
    memset(pixels, 0, width * height * sizeof(uint32_t));

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    // create a context with RGBA pixels
    CGContextRef context = CGBitmapContextCreate(pixels, width, height, 8, width * sizeof(uint32_t), colorSpace, kCGBitmapByteOrder32Little | kCGImageAlphaPremultipliedLast);

    // paint the bitmap to our context which will fill in the pixels array
    CGContextDrawImage(context, CGRectMake(0, 0, width, height), [self CGImage]);

    for(int y = 0; y < height; y++)
    {
        for(int x = 0; x < width; x++)
        {
            uint8_t *rgbaPixel = (uint8_t *) &pixels[y * width + x];

            switch (type)
            {
                    // 灰度
                case IMAGE_GRAYSCALETYPE_GRAY:
                {
                    uint32_t gray = 0.3 * rgbaPixel[RED] + 0.59 * rgbaPixel[GREEN] + 0.11 * rgbaPixel[BLUE];

                    // set the pixels to gray
                    rgbaPixel[RED] = gray;
                    rgbaPixel[GREEN] = gray;
                    rgbaPixel[BLUE] = gray;
                }
                    break;

                    // 做旧 棕色
                case IMAGE_GRAYSCALETYPE_BROWN:
                    rgbaPixel[GREEN] = rgbaPixel[GREEN] * 0.7;
                    rgbaPixel[BLUE] = rgbaPixel[BLUE] * 0.4;
                    break;

                    // 反转颜色
                case IMAGE_GRAYSCALETYPE_INVERSE:
                    rgbaPixel[RED] = 255 - rgbaPixel[RED];
                    rgbaPixel[GREEN] = 255 - rgbaPixel[GREEN];
                    rgbaPixel[BLUE] = 255 - rgbaPixel[BLUE];
                    break;

                default:
                    break;
            }
        }
    }

    // create a new CGImageRef from our context with the modified pixels
    CGImageRef image = CGBitmapContextCreateImage(context);

    // we're done with the context, color space, and pixels
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    free(pixels);

    // make a new UIImage to return
    UIImage *resultUIImage = [UIImage imageWithCGImage:image];

    // we're done with image now too
    CGImageRelease(image);

    return resultUIImage;
}

@end


static CGImageRef CreateMask(CGSize size, NSUInteger thickness)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                       size.width,
                                                       size.height,
                                                       8,
                                                       size.width * 32,
                                                       colorSpace,
                                                       kCGBitmapByteOrderDefault | kCGImageAlphaNone);
    if (bitmapContext == NULL)
    {
        NSLog(@"create mask bitmap context failed");
        CGColorSpaceRelease(colorSpace);
        return nil;
    }
    
    // fill the black color in whole size, anything in black area will be transparent.
    CGContextSetFillColorWithColor(bitmapContext, [UIColor blackColor].CGColor);
    CGContextFillRect(bitmapContext, CGRectMake(0, 0, size.width, size.height));
    
    // fill the white color in whole size, anything in white area will keep.
    CGContextSetFillColorWithColor(bitmapContext, [UIColor whiteColor].CGColor);
    CGContextFillRect(bitmapContext, CGRectMake(thickness, thickness, size.width - thickness * 2, size.height - thickness * 2));
    
    // acquire the mask
    CGImageRef maskImageRef = CGBitmapContextCreateImage(bitmapContext);
    
    // clean up
    CGContextRelease(bitmapContext);
    CGColorSpaceRelease(colorSpace);
    
    return maskImageRef;
}

@implementation UIImage (Border)

- (UIImage *) imageWithColoredBorder:(NSUInteger)borderThickness borderColor:(UIColor *)color withShadow:(BOOL)withShadow
{
    size_t shadowThickness = 0;
    if (withShadow)
    {
        shadowThickness = 2;
    }
    
    size_t newWidth = self.size.width + 2 * borderThickness + 2 * shadowThickness;
    size_t newHeight = self.size.height + 2 * borderThickness + 2 * shadowThickness;
    CGRect imageRect = CGRectMake(borderThickness + shadowThickness, borderThickness + shadowThickness, self.size.width, self.size.height);
    
    UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight));
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGContextSetShadow(ctx, CGSizeZero, 4.5f);
    [color setFill];
    CGContextFillRect(ctx, CGRectMake(shadowThickness, shadowThickness, newWidth - 2 * shadowThickness, newHeight - 2 * shadowThickness));
    CGContextRestoreGState(ctx);
    [self drawInRect:imageRect];
    //CGContextDrawImage(ctx, imageRect, self.CGImage); //if use this method, image will be filp vertically
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    return img;
}

- (UIImage *) imageWithTransparentBorder:(NSUInteger)thickness
{
    size_t newWidth = self.size.width + 2 * thickness;
    size_t newHeight = self.size.height + 2 * thickness;
    
    size_t bitsPerComponent = 8;
    size_t bitsPerPixel = 32;
    size_t bytesPerRow = bitsPerPixel * newWidth;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    if(colorSpace == NULL)
    {
        NSLog(@"create color space failed");
        return nil;
    }
    
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL,
                                                       newWidth,
                                                       newHeight,
                                                       bitsPerComponent,
                                                       bytesPerRow,
                                                       colorSpace,
                                                       kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    if (bitmapContext == NULL)
    {
        NSLog(@"create bitmap context failed");
        CGColorSpaceRelease(colorSpace);
        return nil;
    }
    
    // acquire image with opaque border
    CGRect imageRect = CGRectMake(thickness, thickness, self.size.width, self.size.height);
    CGContextDrawImage(bitmapContext, imageRect, self.CGImage);
    CGImageRef opaqueBorderImageRef = CGBitmapContextCreateImage(bitmapContext);
    
    // acquire image with transparent border
    CGImageRef maskImageRef = CreateMask(CGSizeMake(newWidth, newHeight), thickness);
    CGImageRef transparentBorderImageRef = CGImageCreateWithMask(opaqueBorderImageRef, maskImageRef);
    UIImage *transparentBorderImage = [UIImage imageWithCGImage:transparentBorderImageRef];
    
    // clean up
    CGColorSpaceRelease(colorSpace);
    CGContextRelease(bitmapContext);
    CGImageRelease(opaqueBorderImageRef);
    CGImageRelease(maskImageRef);
    CGImageRelease(transparentBorderImageRef);
    
    return transparentBorderImage;
}

- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:RadiansToDegrees_Loc(radians)];
}


@end


@implementation UIImage (MGProportionalFill)


- (UIImage *)imageToFitSize:(CGSize)fitSize method:(MGImageResizingMethod)resizeMethod
{
	float imageScaleFactor = 1.0;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	if ([self respondsToSelector:@selector(scale)]) {
		imageScaleFactor = [self scale];
	}
#endif
	
	float sourceWidth = [self size].width * imageScaleFactor;
	float sourceHeight = [self size].height * imageScaleFactor;
	float targetWidth = fitSize.width;
	float targetHeight = fitSize.height;
	BOOL cropping = !(resizeMethod == MGImageResizeScale);
	
	// Calculate aspect ratios
	float sourceRatio = sourceWidth / sourceHeight;
	float targetRatio = targetWidth / targetHeight;
	
	// Determine what side of the source image to use for proportional scaling
	BOOL scaleWidth = (sourceRatio <= targetRatio);
	// Deal with the case of just scaling proportionally to fit, without cropping
	scaleWidth = (cropping) ? scaleWidth : !scaleWidth;
	
	// Proportionally scale source image
	float scalingFactor, scaledWidth, scaledHeight;
	if (scaleWidth) {
		scalingFactor = 1.0 / sourceRatio;
		scaledWidth = targetWidth;
		scaledHeight = round(targetWidth * scalingFactor);
	} else {
		scalingFactor = sourceRatio;
		scaledWidth = round(targetHeight * scalingFactor);
		scaledHeight = targetHeight;
	}
	float scaleFactor = scaledHeight / sourceHeight;
	
	// Calculate compositing rectangles
	CGRect sourceRect, destRect;
	if (cropping) {
		destRect = CGRectMake(0, 0, targetWidth, targetHeight);
		float destX =0.0f , destY = 0.0f;
		if (resizeMethod == MGImageResizeCrop) {
			// Crop center
			destX = round((scaledWidth - targetWidth) / 2.0);
			destY = round((scaledHeight - targetHeight) / 2.0);
		} else if (resizeMethod == MGImageResizeCropStart) {
			// Crop top or left (prefer top)
			if (scaleWidth) {
				// Crop top
				destX = 0.0;
				destY = 0.0;
			} else {
				// Crop left
				destX = 0.0;
				destY = round((scaledHeight - targetHeight) / 2.0);
			}
		} else if (resizeMethod == MGImageResizeCropEnd) {
			// Crop bottom or right
			if (scaleWidth) {
				// Crop bottom
				destX = round((scaledWidth - targetWidth) / 2.0);
				destY = round(scaledHeight - targetHeight);
			} else {
				// Crop right
				destX = round(scaledWidth - targetWidth);
				destY = round((scaledHeight - targetHeight) / 2.0);
			}
		}
		sourceRect = CGRectMake(destX / scaleFactor, destY / scaleFactor,
								targetWidth / scaleFactor, targetHeight / scaleFactor);
	} else {
		sourceRect = CGRectMake(0, 0, sourceWidth, sourceHeight);
		destRect = CGRectMake(0, 0, scaledWidth, scaledHeight);
	}
	
	// Create appropriately modified image.
	UIImage *image = nil;
	
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
	CGImageRef sourceImg = nil;
	if ([UIScreen instancesRespondToSelector:@selector(scale)]) {
		UIGraphicsBeginImageContextWithOptions(destRect.size, NO, 0.f); // 0.f for scale means "scale for device's main screen".
		sourceImg = CGImageCreateWithImageInRect([self CGImage], sourceRect); // cropping happens here.
		image = [UIImage imageWithCGImage:sourceImg scale:0.0 orientation:self.imageOrientation]; // create cropped UIImage.
		
	} else {
		UIGraphicsBeginImageContext(destRect.size);
		sourceImg = CGImageCreateWithImageInRect([self CGImage], sourceRect); // cropping happens here.
		image = [UIImage imageWithCGImage:sourceImg]; // create cropped UIImage.
	}
	
	CGImageRelease(sourceImg);
	[image drawInRect:destRect]; // the actual scaling happens here, and orientation is taken care of automatically.
	image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
#endif
	
	if (!image) {
		// Try older method.
		CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
		CGContextRef context = CGBitmapContextCreate(NULL, scaledWidth, scaledHeight, 8, (scaledWidth * 4),
													 colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrderDefault);
		CGImageRef sourceImg = CGImageCreateWithImageInRect([self CGImage], sourceRect);
		CGContextDrawImage(context, destRect, sourceImg);
		CGImageRelease(sourceImg);
		CGImageRef finalImage = CGBitmapContextCreateImage(context);
		CGContextRelease(context);
		CGColorSpaceRelease(colorSpace);
		image = [UIImage imageWithCGImage:finalImage];
		CGImageRelease(finalImage);
	}
	
	return image;
}


- (UIImage *)imageCroppedToFitSize:(CGSize)fitSize
{
	return [self imageToFitSize:fitSize method:MGImageResizeCrop];
}


- (UIImage *)imageScaledToFitSize:(CGSize)fitSize
{
	return [self imageToFitSize:fitSize method:MGImageResizeScale];
}


@end

#pragma mark - UIImage + Blur

@implementation UIImage (Blur)

- (UIImage *)boxblurImageWithBlur:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    
    CGImageRef img = self.CGImage;
    
    vImage_Buffer inBuffer, outBuffer;
    
    vImage_Error error;
    
    void *pixelBuffer;
    
    
    //create vImage_Buffer with data from CGImageRef
    
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    
    
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    
    //create vImage_Buffer for output
    
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    
    // Create a third buffer for intermediate processing
    void *pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outBuffer2;
    outBuffer2.data = pixelBuffer2;
    outBuffer2.width = CGImageGetWidth(img);
    outBuffer2.height = CGImageGetHeight(img);
    outBuffer2.rowBytes = CGImageGetBytesPerRow(img);
    
    //perform convolution
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"1 error from convolution %ld", error);
    }
    
    error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"2 error from convolution %ld", error);
    }
    
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"3 error from convolution %ld", error);
    }
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(outBuffer.data,
                                             outBuffer.width,
                                             outBuffer.height,
                                             8,
                                             outBuffer.rowBytes,
                                             colorSpace,
                                             kCGImageAlphaNoneSkipLast | kCGBitmapByteOrderDefault);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    
    //clean up
    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    
    free(pixelBuffer);
    free(pixelBuffer2);
    CFRelease(inBitmapData);
    
    CGImageRelease(imageRef);
    
    return returnImage;
}

@end



@implementation UIImage (ImageMetadata)

- (NSMutableDictionary *)getImageMetadata
{
    NSData *imageNSData = UIImageJPEGRepresentation(self, 1.0f);

    CGImageSourceRef source;
    source = CGImageSourceCreateWithData((__bridge CFDataRef)imageNSData, NULL);

    if (!source)
    {
        return nil;
    }

    //get all the metadata in the image
    CFDictionaryRef cfMetaData = CGImageSourceCopyPropertiesAtIndex(source, 0, NULL);

    if (cfMetaData)
    {
        NSDictionary *metaData = (__bridge NSDictionary *)cfMetaData;

        //make the metadata dictionary mutable so we can add properties to it
        NSMutableDictionary *metadataAsMutable = [NSMutableDictionary dictionaryWithDictionary:metaData];

        CFRelease(cfMetaData);
        CFRelease(source);

        return metadataAsMutable;
    }

    CFRelease(source);

    return nil;
}

- (NSData *)setImageDateTime:(NSDate *)date latitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude withCompressionQuality:(CGFloat)compressionQuality;
{
    NSMutableData *imageData = [UIImageJPEGRepresentation(self, compressionQuality) mutableCopy];
    CGImageSourceRef  source;
    source = CGImageSourceCreateWithData((__bridge CFDataRef)imageData, NULL);
    //get all the metadata in the image
    NSDictionary *metadata =  (NSDictionary *) CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source,0,NULL));
    
    //make the metadata dictionary mutable so we can add properties to it
    NSMutableDictionary *metadataAsMutable = [metadata mutableCopy];
    
    // EXIF
    NSMutableDictionary *EXIFDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    if(!EXIFDictionary)
    {
        //if the image does not have an EXIF dictionary (not all images do), then create one for us to use
        EXIFDictionary = [NSMutableDictionary dictionary];
    }
    //add our modified EXIF data back into the image’s metadata
    [EXIFDictionary setValue:[date stringByFormatter:@"yyyy:MM:dd HH:mm:ss"] forKey:(NSString *)kCGImagePropertyExifDateTimeOriginal];
    [EXIFDictionary setValue:[date stringByFormatter:@"yyyy:MM:dd HH:mm:ss"] forKey:(NSString *)kCGImagePropertyExifDateTimeDigitized];
    [metadataAsMutable setObject:EXIFDictionary forKey:(NSString *)kCGImagePropertyExifDictionary];
    
    // GPS
    if (latitude > 0 && longitude > 0)
    {
        NSMutableDictionary *GPSDictionary = [[metadataAsMutable objectForKey:(NSString *)kCGImagePropertyGPSDictionary] mutableCopy];
        if(!GPSDictionary)
        {
            GPSDictionary = [NSMutableDictionary dictionary];
        }
        [GPSDictionary setValue:[NSNumber numberWithFloat:latitude] forKey:(NSString *)kCGImagePropertyGPSLatitude];
        [GPSDictionary setValue:[NSNumber numberWithFloat:longitude] forKey:(NSString *)kCGImagePropertyGPSLongitude];
        [metadataAsMutable setObject:GPSDictionary forKey:(NSString *)kCGImagePropertyGPSDictionary];
    }
    
    //this is the type of image (e.g., public.jpeg)
    CFStringRef UTI = CGImageSourceGetType(source);
    //this will be the data CGImageDestinationRef will write into
    NSMutableData *dest_data = [NSMutableData data];
    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)dest_data,UTI,1,NULL);
    if(!destination)
    {
        NSLog(@"***Could not create image destination ***");
        CFRelease(source);

        return nil;
    }
    //add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
    CGImageDestinationAddImageFromSource(destination,source,0, (__bridge CFDictionaryRef) metadataAsMutable);
    //tell the destination to write the image data and metadata into our data object.
    //It will return false if something goes wrong
    BOOL success = NO;
    success = CGImageDestinationFinalize(destination);
    if(!success)
    {
        NSLog(@"***Could not create data from image destination ***");
    }
    //cleanup
    CFRelease(destination);
    CFRelease(source);
    
    return dest_data;
}

- (NSData *)setImageMetadata:(NSMutableDictionary *)metaData
{
    return [self setImageMetadata:metaData withCompressionQuality:0.5f];
}

- (NSData *)setImageMetadata:(NSMutableDictionary *)metaData withCompressionQuality:(CGFloat)compressionQuality;
{
    NSData *imageNSData = UIImageJPEGRepresentation(self, compressionQuality);

    CGImageSourceRef source;
    source = CGImageSourceCreateWithData((__bridge CFDataRef)imageNSData, NULL);

    if (!source)
    {
        return nil;
    }

    CFStringRef UTI = CGImageSourceGetType(source); //this is the type of image (e.g., public.jpeg)

    //this will be the data CGImageDestinationRef will write into
    NSMutableData *dest_data = [NSMutableData data];

    CGImageDestinationRef destination = CGImageDestinationCreateWithData((__bridge CFMutableDataRef)dest_data, UTI, 1, NULL);

    if (!destination)
    {
        NSLog(@"***Could not create image destination ***");
        CFRelease(source);

        return nil;
    }

    //add the image contained in the image source to the destination, overidding the old metadata with our modified metadata
    CGImageDestinationAddImageFromSource(destination, source, 0, (__bridge CFDictionaryRef)metaData);

    //tell the destination to write the image data and metadata into our data object.
    //It will return false if something goes wrong
    BOOL success = NO;
    success = CGImageDestinationFinalize(destination);

    if(!success) {
        NSLog(@"***Could not create data from image destination ***");
    }

    //now we have the data ready to go, so do whatever you want with it
    //here we just write it to disk at the same path we were passed
    //[dest_data writeToFile:file atomically:YES];
    //UIImage *image = [UIImage imageWithData:dest_data];

    //cleanup
    CFRelease(destination);
    CFRelease(source);

    return dest_data;
}


@end

