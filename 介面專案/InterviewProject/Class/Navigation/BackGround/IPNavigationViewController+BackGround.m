//
//  IPNavigationViewController+BackGround.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/9.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPNavigationViewController+BackGround.h"

@implementation IPNavigationViewController (BackGround)

- (void)createBgImage
{
    
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    
    //150 * 高
    if (!self.leftImageView.image) {
        self.leftImageView.image =
        [self makeImageWithSize:CGSizeMake(150, screenSize.height)];
    }
    
    //寬 * 80
    if (!self.topImageView.image) {
        self.topImageView.image =
        [self makeImageWithSize:CGSizeMake(screenSize.width, 80)];
    }
    
}

- (UIImage *)makeImageWithSize:(CGSize)targetSize
{
    UIImage *originalImage = [UIImage imageNamed:@"Navigation_bg"];
    //NSLog(@"targetSize %@",NSStringFromCGSize(targetSize));
    if (targetSize.width > targetSize.height) {
        //轉90 度
        originalImage =
        [UIImage rotateImage:originalImage
                 Orientation:UIImageOrientationLeft];
    }
    
    CGSize imageSize = originalImage.size;
    //NSLog(@"imageSize %@",NSStringFromCGSize(imageSize));
    if (targetSize.height > imageSize.height)
        targetSize = CGSizeMake(imageSize.height,
                                imageSize.height / targetSize.height * targetSize.width);
    
    if (targetSize.width > imageSize.width)
        targetSize = CGSizeMake(imageSize.width / targetSize.width * targetSize.height,
                                imageSize.width);
    
    //NSLog(@"targetSize %@",NSStringFromCGSize(targetSize));
    UIImage *gradientImage =
    [UIImage makeGradientImage:targetSize
                    StartPoint:CGPointZero
                      EndPoint:CGPointMake(targetSize.width, targetSize.height)
                        Colors:@[[UIColor colorWithRed:0 green:0 blue:1 alpha:0.6],
                                 [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6]]
                      Location:@[@0, @1]];
    
    UIImage *textureImage =
    [UIImage subImage:originalImage
                 Rect:CGRectMake(0, 0, targetSize.width, targetSize.height)];
    
    return
    [UIImage addTextureImage:textureImage
                   MainImage:gradientImage];
}

@end
