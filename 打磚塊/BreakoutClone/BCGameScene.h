//
//  GameScene.h
//  BreakoutClone
//
//  Copyright (c) 2016年 w91379137. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
//https://www.raywenderlich.com/49721/how-to-create-a-breakout-game-using-spritekit

@interface BCGameScene : SKScene<SKPhysicsContactDelegate>

@property(nonatomic, readonly) BOOL isGaming;
- (void)startGame;

@end
