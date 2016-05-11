//
//  IPEnvironmentViewController.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/8.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSEnvironmentViewController.h"
#define envc [IPEnvironmentViewController sharedInstance]

@interface IPEnvironmentViewController : PDSEnvironmentViewController

@property(nonatomic, strong) IBOutlet UIView *statusBGView;
@property(nonatomic, strong) IBOutlet UIView *containerView;

@end
