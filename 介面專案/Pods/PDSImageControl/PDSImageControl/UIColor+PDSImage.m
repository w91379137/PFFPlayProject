//
//  UIColor+PDSImage.m
//  PDSImageControlDemo
//
//  Created by w91379137 on 2016/1/23.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "UIColor+PDSImage.h"

@implementation UIColor (PDSImage)

+ (NSArray *)valuesFromColor:(UIColor *)color
{
    CGFloat red = 0;
    CGFloat green = 0;
    CGFloat blue = 0;
    CGFloat alpha = 1;
    
    if (CGColorGetNumberOfComponents(color.CGColor) == 2) {
        CGFloat hue;
        CGFloat saturation;
        CGFloat brightness;
        
        [color getHue:&hue
           saturation:&saturation
           brightness:&brightness
                alpha:&alpha];
        
        red = brightness;
        green = brightness;
        blue = brightness;
    }
    else if (CGColorGetNumberOfComponents(color.CGColor) == 4) {
        
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        red = components[0];
        green = components[1];
        blue = components[2];
        alpha = components[3];
    }
    else {
        NSLog(@"★★The color can't be anaysis to rgb★★");
    }
    
    return @[@(red),@(green),@(blue),@(alpha)];
}

+ (UIColor *)adjustColor:(UIColor *)color
             rgbAddValue:(float)rgbAddValue
{
    NSArray *values = [UIColor valuesFromColor:color];
    return [UIColor colorWithRed:[values[0] floatValue] + rgbAddValue
                           green:[values[1] floatValue] + rgbAddValue
                            blue:[values[2] floatValue] + rgbAddValue
                           alpha:[values[3] floatValue]];
}

+ (UIColor *)randomColor
{
    return [UIColor colorWithRed:arc4random_uniform(255) / 255.0f
                           green:arc4random_uniform(255) / 255.0f
                            blue:arc4random_uniform(255) / 255.0f
                           alpha:0.9];
}

@end
