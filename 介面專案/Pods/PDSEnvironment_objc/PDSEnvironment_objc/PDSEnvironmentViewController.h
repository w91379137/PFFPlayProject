//
//  PDSEnvironmentViewController.h
//  PDSEnvironment_objcDemo
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDSEnvironment_objc.h"

@interface PDSEnvironmentViewController : UIViewController

+ (instancetype)sharedInstance;
@property (strong, nonatomic) UIViewController *rootViewController;

- (void)placeRootViewControllerView; //OverWrite

@end
