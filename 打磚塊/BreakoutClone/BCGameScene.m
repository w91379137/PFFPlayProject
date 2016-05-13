//
//  GameScene.m
//  BreakoutClone
//
//  Created by w91379137 on 2016/5/13.
//  Copyright (c) 2016年 w91379137. All rights reserved.
//

#import "BCGameScene.h"

static const uint32_t ballCategory      = 0x1 << 0;
static const uint32_t paddleCategory    = 0x1 << 1;
static const uint32_t endCategory       = 0x1 << 2;
static const uint32_t blockCategory     = 0x1 << 3;

@interface BCGameScene()

@property(nonatomic,strong) SKSpriteNode *ball;
@property(nonatomic,strong) SKSpriteNode *paddle;
@property(nonatomic,strong) SKSpriteNode *endLine;

@end

@implementation BCGameScene

#pragma mark - Init
- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self){
        //重力設定
        self.physicsWorld.gravity = CGVectorMake(0.0f, 0.0f);
        self.physicsWorld.contactDelegate = self;
        
        //邊界設定
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.friction = 0.0f;
        
        //接版
        [self addChild:self.paddle];
        
        //死線
        [self addChild:self.endLine];
    }
    return self;
}

#pragma mark - Setter / Getter
- (SKSpriteNode *)ball
{
    if (!_ball) {
        _ball = [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
        
        _ball.position = CGPointMake(self.frame.size.width / 3, self.frame.size.height / 3);
        _ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_ball.frame.size.width / 2];
        _ball.physicsBody.friction = 0.0f;
        _ball.physicsBody.restitution = 1.0f;
        _ball.physicsBody.linearDamping = 0.0f;
        _ball.physicsBody.allowsRotation = YES;
        
        _ball.name = @"ball";
        _ball.physicsBody.categoryBitMask = ballCategory;
        _ball.physicsBody.contactTestBitMask = paddleCategory | endCategory | blockCategory;
    }
    return _ball;
}

- (SKSpriteNode *)paddle
{
    if (!_paddle) {
        _paddle =
        [[SKSpriteNode alloc] initWithColor:[UIColor lightGrayColor]
                                       size:CGSizeMake(100, 1)];
        
        _paddle.position =
        CGPointMake(CGRectGetMidX(self.frame), _paddle.frame.size.height * 0.6f + 20);
        _paddle.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_paddle.frame.size];
        _paddle.physicsBody.restitution = 0.1f;
        _paddle.physicsBody.friction = 0.4f;
        _paddle.physicsBody.dynamic = NO; //不會被撞動
        
        _paddle.name = @"paddle";
        _paddle.physicsBody.categoryBitMask = paddleCategory; //沒有設定就是滿值
    }
    return _paddle;
}

- (SKSpriteNode *)endLine
{
    if (!_endLine) {
        _endLine =
        [[SKSpriteNode alloc] initWithColor:[UIColor redColor]
                                       size:CGSizeMake(self.frame.size.width,3)];
        
        _endLine.position = CGPointMake(CGRectGetMidX(self.frame), 0);
        _endLine.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_endLine.frame.size];
        _endLine.physicsBody.dynamic = NO;
        _endLine.physicsBody.categoryBitMask = endCategory;
    }
    return _endLine;
}

- (void)setIsGaming:(BOOL)isGaming
{
    _isGaming = isGaming;
}

#pragma mark - Action
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event
{
    for (UITouch *touch in touches) {
        
        CGPoint point = [touch locationInNode:self];
        
        self.paddle.position =
        CGPointMake(point.x, MAX(10, MIN(150, point.y)));
    }
}

- (void)startGame
{
    //球
    [self addChild:self.ball];
    [self.ball.physicsBody applyImpulse:CGVectorMake(10.0f, 10.0f)];
    
    //清除上次的磚塊
    for (SKSpriteNode *node in self.children) {
        if (node.physicsBody.categoryBitMask == blockCategory)
            [node removeFromParent];
    }
    
    //磚塊
    int blockCount = 10;
    int blockLine = 3;
    
    float blockW = CGRectGetWidth(self.frame) / blockCount;
    float blockH = 30;
    
    for (NSInteger k = 0; k < blockCount; k++) {
        for (NSInteger t = 0; t < blockLine; t++) {
            SKSpriteNode *block =
            [[SKSpriteNode alloc] initWithColor:[UIColor blueColor]
                                           size:CGSizeMake(30,10)];
            
            block.position =
            CGPointMake(blockW * (k + .5),
                        CGRectGetHeight(self.frame) - blockH * (t + .5));
            
            block.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:block.frame.size];
            block.physicsBody.dynamic = NO;
            block.physicsBody.categoryBitMask = blockCategory;
            
            [self addChild:block];
        }
    }
    
    self.isGaming = YES;
}

#pragma mark - SKPhysicsContactDelegate
-(void)didBeginContact:(SKPhysicsContact*)contact
{
    //碰撞開始
    if ([self isRelation:contact A:self.ball B:self.endLine]) {
        self.isGaming = NO;
        [self.ball removeFromParent];
        self.ball = nil;
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    //碰撞結束
    if ([self isRelation:contact A:self.ball B:self.paddle]) {
        
        CGVector vector = self.ball.physicsBody.velocity;
        float xPlus = vector.dx > 0 ? 1.0 : - 1.0;
        [self.ball.physicsBody applyImpulse:CGVectorMake(xPlus, 1.0f)];
    }
    if ([self isRelationCategory:contact CodeA:ballCategory CodeB:blockCategory]) {
        
        SKSpriteNode *block =
        (SKSpriteNode *)(contact.bodyA.categoryBitMask == blockCategory ?
        contact.bodyA.node : contact.bodyB.node);
        
        [block removeFromParent];
    }
}

#pragma mark - Determine
- (BOOL)isRelation:(SKPhysicsContact *)contact
                 A:(SKSpriteNode *)a
                 B:(SKSpriteNode *)b
{
    if (contact.bodyA.node == a && contact.bodyB.node == b)
        return YES;
    if (contact.bodyA.node == b && contact.bodyB.node == a)
        return YES;
    return NO;
}

- (BOOL)isRelationCategory:(SKPhysicsContact *)contact
                     CodeA:(uint32_t)codeA
                     CodeB:(uint32_t)codeB
{
    if (contact.bodyA.categoryBitMask == codeA && contact.bodyB.categoryBitMask == codeB)
        return YES;
    if (contact.bodyA.categoryBitMask == codeB && contact.bodyB.categoryBitMask == codeA)
        return YES;
    return NO;
}

#pragma mark - Update
-(void)update:(CFTimeInterval)currentTime
{
    //這邊是一直監控的區域
    static int maxSpeed = 300;
    CGVector vector = self.ball.physicsBody.velocity;
    
    float speed = sqrt(pow(vector.dx, 2) + pow(vector.dy, 2));
    self.ball.physicsBody.linearDamping = (speed == maxSpeed) ? 0.5f : 0.0;
}

@end
