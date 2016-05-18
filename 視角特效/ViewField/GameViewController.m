//
//  GameViewController.m
//  ViewField
//
//  Created by w91379137 on 2016/5/18.
//  Copyright (c) 2016年 w91379137. All rights reserved.
//

#import "GameViewController.h"
#import "GameScene.h"

@implementation GameViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    GameScene *scene = [[GameScene alloc] initWithSize:self.view.bounds.size];
    [skView presentScene:scene];
}

@end
