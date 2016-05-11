//
//  IPEnvironmentViewController.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/8.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPEnvironmentViewController.h"

@interface IPEnvironmentViewController ()

@end

@implementation IPEnvironmentViewController

#pragma mark - Setter / Getter
- (void)placeRootViewControllerView
{
    [self view];
    [self.containerView insertSubview:self.rootViewController.view atIndex:0];
    [self.rootViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.containerView);
    }];
}

@end
