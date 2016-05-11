//
//  SPViewController.h
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPRectLabelsDIsplayView.h"
#import "SPQuartzDisplayView.h"

#import "SPSnack.h"
#import "SPMap.h"

@interface SPViewController : UIViewController
<SPRectLabelsDIsplayViewDelegate, SPQuartzDisplayViewDelegate>

//地圖
@property(nonatomic, strong) SPMap *gameMap;

//顯示器
@property(nonatomic, strong) SPRectLabelsDisplayView *displayView;
@property(nonatomic, strong) SPQuartzDisplayView *quartDisplayView;

@property(nonatomic) BOOL isGaming;
@property(nonatomic, strong) IBOutlet UIButton *reStartButton;

//計時器
@property(nonatomic, strong) NSTimer *myTimer;

//遊戲物件
@property(nonatomic, strong) SPSnack *snack;
@property(nonatomic, strong) SPCoordinates *fruit;

@end
