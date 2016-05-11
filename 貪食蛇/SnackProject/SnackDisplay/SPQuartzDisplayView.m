//
//  SPQuartzDisplayView.m
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "SPQuartzDisplayView.h"

@implementation SPQuartzDisplayView

//http://www.techotopia.com/index.php/An_iPhone_Graphics_Drawing_Tutorial_using_Quartz_2D
- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 1.0);
    
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    CGPoint from = CGPointZero;
    CGPoint to = CGPointZero;
    
    {
        NSArray *points = [self.delegate snackPathOnDisplayView:self];
        for (NSInteger k = 0; k < points.count; k++) {
            NSValue *pointValue = points[k];
            CGPoint point = [pointValue CGPointValue];
            
            if (k == 0) from = point;
            {
                CGFloat radius = 6;
                CGFloat startAngle = -((float)M_PI / 2); // 90 degrees
                CGFloat endAngle = ((2 * (float)M_PI) + startAngle);
                CGContextAddArc(context, point.x, point.y, radius, startAngle, endAngle, 0);
                CGContextStrokePath(context);
            }
        }
    }
    
    {
        NSArray *points = [self.delegate fruitPathOnDisplayView:self];
        for (NSInteger k = 0; k < points.count; k++) {
            NSValue *pointValue = points[k];
            CGPoint point = [pointValue CGPointValue];
            
            if (k == 0) to = point;
            {
                CGContextMoveToPoint(context, point.x , point.y - 6);
                CGContextAddLineToPoint(context, point.x - 6, point.y + 4);
                CGContextAddLineToPoint(context, point.x + 6, point.y + 4);
                CGContextClosePath(context);
                CGContextStrokePath(context);
            }
        }
    }
    
    CGContextMoveToPoint(context, from.x , from.y);
    CGContextAddLineToPoint(context, to.x, to.y);
    
    CGFloat dashArray[] = {2,6,4,2};
    CGContextSetLineDash(context, 3, dashArray, 4);
    CGContextStrokePath(context);
}



@end
