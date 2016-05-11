//
//  UIImage+PDSImage.m
//
//  Created by w91379137 on 2016/1/22.
//

#import "UIImage+PDSImage.h"
#import "UIColor+PDSImage.h"

@implementation UIImage (PDSImage)

#pragma mark - Public
+ (void)beginImageContextSize:(CGSize)size
{
    if (CGSizeEqualToSize(size, CGSizeZero)) size = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
}

+ (void)beginImageContextImage:(UIImage *)image
{
    CGSize size = image.size;
    if (CGSizeEqualToSize(size, CGSizeZero)) size = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(size, NO, image.scale);
    [maybe(image, UIImage) drawAtPoint:CGPointMake(0, 0)];
}

+ (UIImage *)endImageContext
{
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 產生純色圖
+ (UIImage *)makePureColorImage:(CGSize)size
                          Color:(UIColor *)color
{
    {
        color = maybe(color, UIColor);
        if (!color) color = [UIColor blackColor];
    }
    
    [UIImage beginImageContextSize:size];
    
    {
        [color set];
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
    }
    
    return [UIImage endImageContext];
}

#pragma mark - 產生字圖
+ (UIImage *)makeTextImage:(NSString *)string
            FontDictionary:(NSDictionary *)fontDictionary
{
    CGSize size =
    [string boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)
                         options:NSStringDrawingUsesLineFragmentOrigin
                      attributes:fontDictionary
                         context:nil].size;
    
    [UIImage beginImageContextSize:size];
    
    {
        [[UIColor clearColor] set];
        UIRectFill(CGRectMake(0, 0, size.width, size.height));
        
        [string drawAtPoint:CGPointZero withAttributes:fontDictionary];
    }
    
    return [UIImage endImageContext];
}

#pragma mark - 產生漸層圖
+ (UIImage *)makeGradientImage:(CGSize)size
                    StartPoint:(CGPoint)startPoint
                      EndPoint:(CGPoint)endPoint
                        Colors:(NSArray *)colors
                      Location:(NSArray *)locations
{
    [UIImage beginImageContextSize:size];
    
    {
        //取出顏色的資訊
        NSMutableArray *valuesArray = [self valuesFromColors:colors];
        
        //漸層中所包含的關鍵顏色 RGBA
        CGFloat colorComponents[[valuesArray count]];
        for (int i = 0; i < [valuesArray count]; i++) {
            colorComponents[i] = [[valuesArray objectAtIndex:i] floatValue];
        }
        
        //關鍵顏色所出現的位置
        CGFloat locationsComponents[[locations count]];
        for (int i = 0; i < [locations count]; i++) {
            locationsComponents[i] = [[locations objectAtIndex:i] floatValue];
        }
        
        //關鍵顏色的個數
        size_t count = colors.count;
        
        //製作漸層顏色模型
        CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
        CGGradientRef gradient =
        CGGradientCreateWithColorComponents(colorSpaceRef,
                                            colorComponents,
                                            locationsComponents,
                                            count);
        CGColorSpaceRelease(colorSpaceRef);
        
        //繪製漸層線條
        CGContextDrawLinearGradient(UIGraphicsGetCurrentContext(),
                                    gradient,
                                    startPoint,
                                    endPoint,
                                    0);
        CGGradientRelease(gradient);
    }
    
    return [UIImage endImageContext];
}

#pragma mark - 拍圖
+ (UIImage *)makeImageWithView:(UIView *)view
{
    CGSize size = view.bounds.size;
    
    [UIImage beginImageContextSize:size];
    
    {
        [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    return [UIImage endImageContext];
}

#pragma mark - 貼圖
+ (UIImage *)addImage:(UIImage *)image
      BackgroundImage:(UIImage *)backgroundImage
               Origin:(CGPoint)origin
{
    [UIImage beginImageContextImage:backgroundImage];
    
    {
        [image drawAtPoint:origin];
    }
    
    return [UIImage endImageContext];
}

#pragma mark - 混合
+ (UIImage *)addTextureImage:(UIImage *)textureImage
                   MainImage:(UIImage *)mainImage
{
    return [self addTextureImage:textureImage
                       MainImage:mainImage
                            Mode:kCGBlendModeOverlay];
}

+ (UIImage *)addTextureImage:(UIImage *)textureImage
                   MainImage:(UIImage *)mainImage
                        Mode:(CGBlendMode)mode
{
    if (!maybe(mainImage, UIImage)) return nil;
    if (!maybe(textureImage, UIImage)) return mainImage;
    
    [UIImage beginImageContextImage:mainImage];
    
    //設定參考範圍
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1, -1);
    
    CGRect region = CGRectMake(0, 0, mainImage.size.width, mainImage.size.height);
    CGContextTranslateCTM(context, 0, -region.size.height);
    CGContextSaveGState(context);
    
    //可以有保留透明背景的效果
    CGContextClipToMask(context, region, mainImage.CGImage);
    
    //將材質紋理與原影像混和
    CGContextDrawImage(context, region, textureImage.CGImage);
    CGContextRestoreGState(context);
    CGContextSetBlendMode(context, mode);
    CGContextDrawImage(context, region, mainImage.CGImage);
    
    return [UIImage endImageContext];
}

+ (UIImage *)maskImage:(UIImage *)image
              withMask:(UIImage *)mask
{
    CGImageRef imgRef = [image CGImage];
    CGImageRef maskRef = [mask CGImage];
    
    CGImageRef actualMask =
    CGImageMaskCreate(CGImageGetWidth(maskRef),
                      CGImageGetHeight(maskRef),
                      CGImageGetBitsPerComponent(maskRef),
                      CGImageGetBitsPerPixel(maskRef),
                      CGImageGetBytesPerRow(maskRef),
                      CGImageGetDataProvider(maskRef), NULL, false);
    
    CGImageRef masked = CGImageCreateWithMask(imgRef, actualMask);
    UIImage *completeImage = [UIImage imageWithCGImage:masked];
    
    CGImageRelease(masked);
    CGImageRelease(actualMask);
    
    return completeImage;
}

#pragma mark - 圓角
+ (UIImage *)addRoundedImage:(UIImage *)image
                     Corners:(UIRectCorner)corners
                      Radius:(float)radius
{
    //http://stackoverflow.com/questions/4847163/round-two-corners-in-uiview
    
    //下面兩個角導角
    //corners >> UIRectCornerBottomLeft | UIRectCornerBottomRight
    
    CGRect rect = {CGPointZero, image.size};
    
    UIBezierPath *maskPath =
    [UIBezierPath bezierPathWithRoundedRect:rect
                          byRoundingCorners:corners
                                cornerRadii:CGSizeMake(radius, radius)];
    return [self clipImage:image
                      Path:maskPath];
}

#pragma mark - 改大小
+(UIImage *)reSizeImage:(UIImage *)image
                   Size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, 0, image.scale);
    
    {
        [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    }
    
    return [UIImage endImageContext];
}

+(UIImage *)reSizeImage:(UIImage *)image
              maxLength:(CGFloat)length
{
    CGSize size = image.size;
    float scale = MIN(length / size.width, length / size.height);
    return [UIImage reSizeImage:image
                           Size:CGSizeMake(size.width * scale, size.height * scale)];
}

#pragma mark - 旋轉
+ (UIImage *)rotateImage:(UIImage *)image
             Orientation:(UIImageOrientation)orientation
{
    return
    [UIImage imageWithCGImage:image.CGImage
                        scale:image.scale
                  orientation:orientation];
}

#pragma mark - 改顏色
+ (UIImage *)changeImage:(UIImage *)image
                   Color:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(image.size, 0, image.scale);
    
    {
        CGRect rect = CGRectMake(0, 0, image.size.width, image.size.height);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextClipToMask(context, rect, image.CGImage);
        CGContextSetFillColorWithColor(context, color.CGColor);
        CGContextFillRect(context, rect);
    }
    //畫出來是上下顛倒的
    
    return
    [UIImage rotateImage:[UIImage endImageContext]
             Orientation:UIImageOrientationDownMirrored];
}

#pragma mark - 切圖
+ (UIImage *)subImage:(UIImage *)image
                 Rect:(CGRect)rect
{
    UIGraphicsBeginImageContextWithOptions(rect.size, 0, image.scale);
    
    [image drawInRect:CGRectMake(-rect.origin.x,
                                 -rect.origin.y,
                                 image.size.width,
                                 image.size.height)];
    
    return [UIImage endImageContext];
}

+ (UIImage *)clipImage:(UIImage *)image
                  Path:(UIBezierPath *)path
{
    //http://stackoverflow.com/questions/16142743/clip-uiimage-with-uibezierpath-asynchronously
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, image.scale);
    
    {
        [path addClip];//必須比下一行先執行
        [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    }
    
    return [UIImage endImageContext];
}

#pragma mark - 資料處理
+ (NSMutableArray *)valuesFromColors:(NSArray *)colorArray
{
    NSMutableArray *valuesArray = [NSMutableArray array];
    for (int k = 0; k < [colorArray count]; k++) {
        UIColor *color = maybeDefault(colorArray[k], UIColor, [UIColor blackColor]);
        [valuesArray addObjectsFromArray:[UIColor valuesFromColor:color]];
    }
    return valuesArray;
}

@end
