//
//  PDSImage.m
//
//  Created by w91379137 on 2016/1/3.
//

#import "PDSImageControl.h"

@implementation PDSImageControl

#pragma mark - Init
- (instancetype)initWithImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        self.image = image;
    }
    return self;
}

#pragma mark - 貼圖
- (void)addImage:(UIImage *)image
               Origin:(CGPoint)origin
{
    if (self.image) {
        self.image =
        [UIImage addImage:image
          BackgroundImage:self.image
                   Origin:origin];
    }
}

- (void)addImageAtCenter:(UIImage *)image
{
    if (self.image) {
        self.image =
        [UIImage addImage:image
          BackgroundImage:self.image
                   Origin:[PDSImageControl originOfCenterAlignImage:image
                                                    BackgroundImage:self.image]];
    }
}

#pragma mark - 混合
- (void)addTexture:(UIImage *)textureImage
{
    if (self.image) {
        self.image =
        [UIImage addTextureImage:textureImage
                       MainImage:self.image];
    }
}

- (void)addTexture:(UIImage *)textureImage
               mode:(CGBlendMode)mode
{
    if (self.image) {
        self.image =
        [UIImage addTextureImage:textureImage
                       MainImage:self.image
                            Mode:mode];
    }
}

#pragma mark - 圓角
- (void)addCorners:(UIRectCorner)corners
             Radius:(float)radius
{
    if (self.image) {
        self.image =
        [UIImage addRoundedImage:self.image
                          Corners:corners
                           Radius:radius];
    }
}

#pragma mark - 改大小
- (void)reSize:(CGSize)size
{
    if (self.image) {
        self.image =
        [UIImage reSizeImage:self.image
                        Size:size];
    }
}

- (void)reSizeMaxLength:(CGFloat)length
{
    if (self.image) {
        self.image =
        [UIImage reSizeImage:self.image
                   maxLength:length];
    }
}

#pragma mark - 旋轉
- (void)rotateOrientation:(UIImageOrientation)orientation
{
    if (self.image) {
        self.image =
        [UIImage rotateImage:self.image
                 Orientation:orientation];
    }
}

#pragma mark - 改顏色
- (void)changeColor:(UIColor *)color
{
    if (self.image) {
        self.image =
        [UIImage changeImage:self.image
                       Color:color];
    }
}

#pragma mark - 切圖
- (void)subImageRect:(CGRect)rect
{
    if (self.image) {
        self.image =
        [UIImage subImage:self.image
                     Rect:rect];
    }
}

- (void)clipImagePath:(UIBezierPath *)path
{
    if (self.image) {
        self.image =
        [UIImage clipImage:self.image
                      Path:path];
    }
}

#pragma mark - 中心轉換
+ (CGPoint)originOfCenterAlignImage:(UIImage *)image
                    BackgroundImage:(UIImage *)backgroundImage
{
    CGPoint point =
    CGPointMake((backgroundImage.size.width - image.size.width) / 2,
                (backgroundImage.size.height - image.size.height) / 2);
    return point;
}

@end
