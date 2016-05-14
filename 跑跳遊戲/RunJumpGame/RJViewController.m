//
//  RJViewController.m
//  RunJumpGame
//
//  Created by w91379137 on 2016/5/14.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "RJViewController.h"
#import "RJStartScene.h"

@interface RJViewController ()

@end

@implementation RJViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    RJStartScene *scene = [[RJStartScene alloc] initWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
}

@end
