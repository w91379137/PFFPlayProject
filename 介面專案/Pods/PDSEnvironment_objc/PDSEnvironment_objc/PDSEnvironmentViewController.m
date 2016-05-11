//
//  PDSEnvironmentViewController.m
//  PDSEnvironment_objcDemo
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSEnvironmentViewController.h"

@interface PDSEnvironmentViewController ()

@end

@implementation PDSEnvironmentViewController

#pragma mark - Init
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Setter / Getter
-(void)setRootViewController:(UIViewController *)rootViewController
{
    //移除舊的畫面
    if (_rootViewController != nil) {
        
        UIViewController *removeVC = _rootViewController;
        
        CATransform3D transform =
        CATransform3DTranslate(CATransform3DIdentity, 0, -[UIScreen mainScreen].bounds.size.height, 0);
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                             removeVC.view.layer.transform = transform;
                         } completion:^(BOOL finished) {
                             [removeVC.view removeFromSuperview];
                             [removeVC removeFromParentViewController];
                         }];
    }
    
    _rootViewController = rootViewController;
    [self addChildViewController:_rootViewController];
    
    [self placeRootViewControllerView];
}

- (void)placeRootViewControllerView
{
    [self.view insertSubview:_rootViewController.view atIndex:0];
    
    [_rootViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

@end
