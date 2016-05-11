//
//  IPBasicViewController.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/3.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPBasicViewController.h"
#import "IPNavigationViewController.h"

@interface IPBasicViewController ()

@end

@implementation IPBasicViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    if (headerView) {
        [headerView.backButton addTarget:self
                                  action:@selector(back:)
                        forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)back:(id)sender
{
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    else {
        IPNavigationViewController *nv =
        maybe(self.navigationController, IPNavigationViewController);
        
        nv.isMenuShow = !nv.isMenuShow;
    }
}

- (void)dealloc
{
    NSLog(@"%@ dealloc",NSStringFromClass([self class]));
}

@end
