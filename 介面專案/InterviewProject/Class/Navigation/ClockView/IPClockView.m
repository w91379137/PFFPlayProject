//
//  IPClockView.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPClockView.h"

@implementation IPClockView

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.containerView.layer.cornerRadius = 0;
    self.containerView.layer.borderWidth = 0;
}

- (void)setCurrentTime
{
    [self setTime:[NSDate date]];
}

- (void)setTime:(NSDate *)date
{
    self.containerView.layer.cornerRadius =
    self.containerView.frame.size.width / 2;
    
    self.containerView.layer.borderColor = [UIColor blackColor].CGColor;
    self.containerView.layer.borderWidth = 1;
    
    NSDateComponents *dateComponents =
    [[NSCalendar currentCalendar] components:(NSCalendarUnitHour | NSCalendarUnitMinute)
                                    fromDate:date];
    
    NSInteger hours = [dateComponents hour];
    NSInteger minutes = [dateComponents minute];
    
    if (hours > 12) hours -= 12;
    
    self.hourView.transform =
    CGAffineTransformRotate(CGAffineTransformIdentity, hours * M_PI * 2 / 12);
    
    self.minuteView.transform =
    CGAffineTransformRotate(CGAffineTransformIdentity, minutes * M_PI * 2 / 60);
}

@end
