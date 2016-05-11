//
//  UIColor+PDSImage.h
//  PDSImageControlDemo
//
//  Created by w91379137 on 2016/1/23.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSImageControl_objc.h"

@interface UIColor (PDSImage)

+ (NSArray *)valuesFromColor:(UIColor *)color;

+ (UIColor *)adjustColor:(UIColor *)color
             rgbAddValue:(float)rgbAddValue;

+ (UIColor *)randomColor;

@end
