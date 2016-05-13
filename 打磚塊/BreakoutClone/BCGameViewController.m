//
//  GameViewController.m
//  BreakoutClone
//
//  Created by w91379137 on 2016/5/13.
//  Copyright (c) 2016年 w91379137. All rights reserved.
//

#import "BCGameViewController.h"
#import "BCGameScene.h"

#import "PDSSetting.h"
#import "PDSSafeKVO_objc.h"

@interface BCGameViewController()
{
    BCGameScene *scene;
    IBOutlet UIButton *restartButton;
}

@end

@implementation BCGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SKView *skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    skView.ignoresSiblingOrder = YES;
    
    scene = [[BCGameScene alloc] initWithSize:self.view.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene:scene];
    
    weakMake(scene, weakScene);
    weakMake(restartButton, weakButton);
    [scene addSafeObserver:restartButton
                forKeyPath:@"isGaming"
            UniqueModifyID:@"isGaming"
               ActionBlock:^(NSString *keyPath, id object, NSDictionary *change, void *context) {
                   weakButton.hidden = weakScene.isGaming;
               }];
}

- (IBAction)reStart:(id)sender
{
    [scene startGame];
}

@end
