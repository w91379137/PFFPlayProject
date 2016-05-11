//
//  IPNavigationViewController.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IPClockView.h"

@interface IPNavigationViewController : UINavigationController
<UITableViewDataSource, UITableViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegate>

- (instancetype)initWithHome;

@property(nonatomic) BOOL isMenuShow;

@property(nonatomic, strong) IBOutlet UIView *containerView;
@property(nonatomic, strong) IBOutlet UIView *sideBarView;

@property(nonatomic, strong) IBOutlet UIButton *closeButton;

@property(nonatomic, strong) IBOutlet IPClockView *clockView;

@property(nonatomic, strong) IBOutlet UIView *leftContainerView;
@property(nonatomic, strong) IBOutlet UIImageView *leftImageView;
@property(nonatomic, strong) IBOutlet UITableView *mainTableView;

@property(nonatomic, strong) IBOutlet UIView *topContainerView;
@property(nonatomic, strong) IBOutlet UIImageView *topImageView;
@property(nonatomic, strong) IBOutlet UICollectionView *mainCollectionView;

@end
