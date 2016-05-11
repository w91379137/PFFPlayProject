//
//  IPContainerView.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPContainerView.h"

@implementation IPContainerView

- (nullable UIView *)hitTest:(CGPoint)point
                   withEvent:(nullable UIEvent *)event
{
    UIView *hitView = [super hitTest:point withEvent:event];
    if (hitView == self) return nil;
    return hitView;
}

@end
