//
//  GameScene.m
//  RunJumpGame
//
//  Created by w91379137 on 2016/5/14.
//  Copyright (c) 2016年 w91379137. All rights reserved.
//

#import "RJStartScene.h"
#import "RJGameScene.h"

@implementation RJStartScene

#pragma mark - Init
- (void)didMoveToView:(SKView *)view
{
    SKLabelNode *label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    
    label.text = @"Start !!";
    label.fontSize = 45;
    label.position =
    CGPointMake(CGRectGetMidX(self.frame),
                CGRectGetMidY(self.frame) - 20);
    
    [self addChild:label];
}

#pragma mark - Action
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.scene.view presentScene:[[RJGameScene alloc] initWithSize:self.size]
                       transition:[SKTransition doorsOpenVerticalWithDuration:1.0]];
}

@end
