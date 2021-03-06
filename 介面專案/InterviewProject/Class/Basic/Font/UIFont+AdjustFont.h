//
//  UIFont+AdjustFont.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (AdjustFont)

+ (float)sizeScaleWithScreen;
+ (UIFont *)adjustSystemFontOfSize:(CGFloat)fontSize;
+ (UIFont *)adjustBoldSystemFontOfSize:(CGFloat)fontSize;

@end
