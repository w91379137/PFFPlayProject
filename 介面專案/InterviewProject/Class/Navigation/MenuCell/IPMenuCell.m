//
//  IPMenuCell.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/15.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPMenuCell.h"

static UIImage *menuCellBgImage;

@implementation UIImage (MenuCell)

+ (UIImage *)menuCellBgImage
{
    if (!menuCellBgImage) {
        
        CGSize targetSize = CGSizeMake(150, 40);
        
        menuCellBgImage =
        [UIImage makeGradientImage:targetSize
                        StartPoint:CGPointMake(targetSize.width - targetSize.height , 0)
                          EndPoint:CGPointMake(targetSize.width , targetSize.height)
                            Colors:@[[UIColor colorWithRed:1 green:1 blue:1 alpha:0.0],
                                     [UIColor colorWithRed:.9 green:.7 blue:.7 alpha:0.8]]
                          Location:@[@0, @1]];
    }
    return menuCellBgImage;
}

@end
