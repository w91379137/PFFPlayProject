//
//  GameScene.m
//  ViewField
//
//  Created by w91379137 on 2016/5/18.
//  Copyright (c) 2016年 w91379137. All rights reserved.
//

#import "GameScene.h"

//SpriteKit
//https://www.youtube.com/watch?v=jqtKXvIBCj0

//Cocos2D
//https://www.youtube.com/watch?v=zxeEjJyzgbE

@implementation GameScene

-(void)didMoveToView:(SKView *)view
{
    float halfWidth = self.size.width / 2;
    float halfHeight = self.size.height / 2;
    
    camera = [SKCameraNode new];
    camera.position = CGPointMake(halfWidth ,halfHeight);
    self.camera = camera;
    
    NSArray *particleNameArray =
    @[@"ParticleBokeh",
      @"ParticleFire",
      @"ParticleFireflies",
      @"ParticleMagic",
      @"ParticleRain",
      @"ParticleSmoke",
      @"ParticleSnow",
      @"ParticleSpark"];
    
    NSInteger column = 3;
    
    for (NSInteger k = 0; k < particleNameArray.count; k++) {
        
        NSInteger x = k % column;
        NSInteger y = k / column;
        
        NSString *path =
        [[NSBundle mainBundle] pathForResource:particleNameArray[k]
                                        ofType:@"sks"];
        
        SKEmitterNode *node = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        
        node.position =
        CGPointMake(halfWidth * (2 * x + 1), halfHeight * (2 * y + 1));
        [self addChild:node];
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        CGPoint point1 = [touch locationInNode:self];
        CGPoint point2 = [touch previousLocationInNode:self];
        
        
        CGPoint newPoint =
        CGPointMake(self.camera.position.x - point1.x + point2.x,
                    self.camera.position.y - point1.y + point2.y);
        
        self.camera.position = newPoint;
        
        //NSLog(@"%@",NSStringFromCGPoint(self.camera.position));
    }
}

-(void)update:(CFTimeInterval)currentTime
{
}

@end
