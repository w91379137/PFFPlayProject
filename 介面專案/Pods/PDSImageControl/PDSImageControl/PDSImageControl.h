//
//  PDSImageControl.h
//
//  Created by w91379137 on 2016/1/3.
//

#import "PDSImageControl_objc.h"

@interface PDSImageControl : NSObject
@property (nonatomic, strong) UIImage *image;

#pragma mark - Init
- (instancetype)initWithImage:(UIImage *)image;

#pragma mark - 貼圖
- (void)addImage:(UIImage *)image
          Origin:(CGPoint)origin;

- (void)addImageAtCenter:(UIImage *)image;

#pragma mark - 混合
- (void)addTexture:(UIImage *)textureImage;

- (void)addTexture:(UIImage *)textureImage
              mode:(CGBlendMode)mode;

#pragma mark - 圓角
- (void)addCorners:(UIRectCorner)corners
            Radius:(float)radius;

#pragma mark - 改大小
- (void)reSize:(CGSize)size;

- (void)reSizeMaxLength:(CGFloat)length;

#pragma mark - 旋轉
- (void)rotateOrientation:(UIImageOrientation)orientation;

#pragma mark - 改顏色
- (void)changeColor:(UIColor *)color;

#pragma mark - 切圖
- (void)subImageRect:(CGRect)rect;

- (void)clipImagePath:(UIBezierPath *)path;

#pragma mark - 中心轉換
+ (CGPoint)originOfCenterAlignImage:(UIImage *)image
                    BackgroundImage:(UIImage *)backgroundImage;

@end
