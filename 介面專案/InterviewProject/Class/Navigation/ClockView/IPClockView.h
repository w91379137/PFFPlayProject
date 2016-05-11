//
//  IPClockView.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSIBView.h"

@interface IPClockView : PDSIBView

@property(nonatomic, strong) IBOutlet UIView *containerView;
@property(nonatomic, strong) IBOutlet UIView *hourView;
@property(nonatomic, strong) IBOutlet UIView *minuteView;

- (void)setCurrentTime;
- (void)setTime:(NSDate *)date;

@end
