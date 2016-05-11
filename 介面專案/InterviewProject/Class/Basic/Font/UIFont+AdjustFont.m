//
//  UIFont+AdjustFont.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "UIFont+AdjustFont.h"

@implementation UIFont (AdjustFont)

+ (float)sizeScaleWithScreen
{
    CGFloat windowWidth = [UIScreen mainScreen].bounds.size.width;
    
    float sizeScale = 1;
    if (windowWidth > 375) {
        sizeScale = 1.3;
    }
    else if (windowWidth > 320) {
        sizeScale = 1.1;
    }
    
    return sizeScale;
}

+ (UIFont *)adjustSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont systemFontOfSize:fontSize * [UIFont sizeScaleWithScreen]];
}

+ (UIFont *)adjustBoldSystemFontOfSize:(CGFloat)fontSize
{
    return [UIFont boldSystemFontOfSize:fontSize * [UIFont sizeScaleWithScreen]];
}

@end
