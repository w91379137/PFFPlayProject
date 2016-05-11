//
//  UIColor+IPColor.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (IPColor)

+ (UIColor *)colorWithRedInt:(NSInteger)red
                    greenInt:(NSInteger)green
                     blueInt:(NSInteger)blue
                       alpha:(CGFloat)alpha;

+ (UIColor *)colorWithString:(NSString *)colorString;

@end
