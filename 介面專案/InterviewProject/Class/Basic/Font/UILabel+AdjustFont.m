//
//  UILabel+AdjustFont.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "UILabel+AdjustFont.h"

@implementation UILabel (AdjustFont)

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.font = [self.font fontWithSize:self.font.pointSize * [UIFont sizeScaleWithScreen]];
}

@end
