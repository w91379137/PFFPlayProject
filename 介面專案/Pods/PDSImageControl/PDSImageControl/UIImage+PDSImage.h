//
//  UIImage+PDSImage.h
//
//  Created by w91379137 on 2016/1/22.
//

#import "PDSImageControl_objc.h"

@interface UIImage (PDSImage)

#pragma mark - 產生純色圖
+ (UIImage *)makePureColorImage:(CGSize)size
                          Color:(UIColor *)color;

#pragma mark - 產生字圖
+ (UIImage *)makeTextImage:(NSString *)string
            FontDictionary:(NSDictionary *)fontDictionary;

#pragma mark - 產生漸層圖
+ (UIImage *)makeGradientImage:(CGSize)size
                    StartPoint:(CGPoint)startPoint
                      EndPoint:(CGPoint)endPoint
                        Colors:(NSArray *)colors
                      Location:(NSArray *)locations;

#pragma mark - 拍圖
+ (UIImage *)makeImageWithView:(UIView *)view;

#pragma mark - 貼圖
+ (UIImage *)addImage:(UIImage *)image
      BackgroundImage:(UIImage *)backgroundImage
               Origin:(CGPoint)origin;

#pragma mark - 混合
+ (UIImage *)addTextureImage:(UIImage *)textureImage
                   MainImage:(UIImage *)mainImage;

+ (UIImage *)addTextureImage:(UIImage *)textureImage
                   MainImage:(UIImage *)mainImage
                        Mode:(CGBlendMode)mode;

+ (UIImage *)maskImage:(UIImage *)image
              withMask:(UIImage *)mask;

#pragma mark - 圓角
+ (UIImage *)addRoundedImage:(UIImage *)image
                     Corners:(UIRectCorner)corners
                      Radius:(float)radius;

#pragma mark - 改大小
+ (UIImage *)reSizeImage:(UIImage *)image
                    Size:(CGSize)size;

+ (UIImage *)reSizeImage:(UIImage *)image
               maxLength:(CGFloat)length;

#pragma mark - 旋轉
+ (UIImage *)rotateImage:(UIImage *)image
             Orientation:(UIImageOrientation)orientation;

#pragma mark - 改顏色
+ (UIImage *)changeImage:(UIImage *)image
                   Color:(UIColor *)color;

#pragma mark - 切圖
+ (UIImage *)subImage:(UIImage *)image
                 Rect:(CGRect)rect;

+ (UIImage *)clipImage:(UIImage *)image
                  Path:(UIBezierPath *)path;

@end
