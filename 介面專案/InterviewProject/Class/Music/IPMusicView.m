//
//  IPMusicView.m
//  InterviewProject
//
//  Created by w91379137 on 2016/5/11.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPMusicView.h"

@implementation IPMusicView
//http://tech.glowing.com/cn/usage-of-cadisplaylink/

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    
    float *data = self.delegate.data;
    NSInteger groupCount = self.delegate.groupCount;
    
    static float clipTheta = 0.1;
    static float radius = 70;
    
    CGPoint center =
    CGPointMake(rect.size.width / 2, rect.size.height / 2);
    
    for (NSInteger k = 0; k < groupCount; k++) {
        
        //顏色
        UIColor *color =
        [UIColor colorWithRed:1.0f / groupCount * k
                        green:1 - 1.0f / groupCount * k
                         blue:0.7
                        alpha:1];
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        
        //角度
        float theta = (M_PI * (2 - clipTheta * 2)) / groupCount * k + M_PI * clipTheta;
        
        //起點
        float radius1 = radius + data[k] / 3;
        if (isnan(radius1)) radius1 = 0;
        
        CGPoint from =
        CGPointMake(center.x + radius1 * sinf(theta), center.y + radius1 * cosf(theta));
        
        //終點
        float radius2 = radius + data[k];
        if (isnan(radius2)) radius2 = 0;
        
        CGPoint to =
        CGPointMake(center.x + radius2 * sinf(theta), center.y + radius2 * cosf(theta));
        
        //畫圖
        CGContextMoveToPoint(context, from.x , from.y);
        CGContextAddLineToPoint(context, to.x, to.y);
        CGContextStrokePath(context);
    }
}

@end
