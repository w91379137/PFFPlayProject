//
//  UIColor+IPColor.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "UIColor+IPColor.h"

@implementation UIColor (IPColor)

+ (UIColor *)colorWithRedInt:(NSInteger)red
                    greenInt:(NSInteger)green
                     blueInt:(NSInteger)blue
                       alpha:(CGFloat)alpha
{
    return [UIColor colorWithRed:red / 255.0f
                           green:green / 255.0f
                            blue:blue / 255.0f
                           alpha:alpha];
}

+ (UIColor *)colorWithString:(NSString *)colorString
{
    SEL getColor = NSSelectorFromString(colorString);
    
    if ([UIColor respondsToSelector:getColor] == YES) {
        UIColor *color = [UIColor performSelector:getColor];
        if ([color isKindOfClass:[UIColor class]]) {
            return color;
        }
    }
    return nil;
}

@end
