//
//  RJGameScene.m
//  RunJumpGame
//
//  Created by w91379137 on 2016/5/14.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "RJGameScene.h"
#import "RJStartScene.h"
//https://www.youtube.com/watch?v=Bu_PkhCcRVI&list=PLgffZ1Nsdt5p5lUgiB-BA71VrxUqSBcu5&index=2

static const uint32_t ballCategory      = 0x1 << 0;
static const uint32_t bottomCategory    = 0x1 << 1;
static const uint32_t endCategory       = 0x1 << 2;
static const uint32_t blockCategory     = 0x1 << 3;

@interface RJGameScene()<SKPhysicsContactDelegate>

@property(nonatomic) int jumpTimes;
@property(nonatomic, strong) SKSpriteNode *bottomLine;
@property(nonatomic, strong) SKSpriteNode *endLine;
@property(nonatomic, strong) SKSpriteNode *ball;

@property(nonatomic) int score;
@property(nonatomic, strong) SKLabelNode *scoreLabel;

@property(nonatomic, strong) NSMutableArray *blockArray;

@end

@implementation RJGameScene

#pragma mark - Init
- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        _jumpTimes = 1;
        _blockArray = [NSMutableArray array];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view
{
    self.physicsWorld.contactDelegate = self;
    self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
    self.physicsBody.friction = 0.0f;
    
    [self addChild:self.bottomLine];
    [self addChild:self.endLine];
    [self addChild:self.ball];
    
    self.score = 0;
    
    for (NSInteger k = 0; k < 4; k++) {
        [self performSelector:@selector(createBlock)
                   withObject:nil
                   afterDelay:0.5 + k];
    }
}

#pragma mark - Setter / Getter
- (SKSpriteNode *)bottomLine
{
    if (!_bottomLine) {
        _bottomLine =
        [SKSpriteNode spriteNodeWithColor:[UIColor blackColor]
                                     size:CGSizeMake(self.frame.size.width, 20)];
        
        _bottomLine.position = CGPointMake(self.frame.size.width / 2, 20);
        _bottomLine.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_bottomLine.size];
        _bottomLine.physicsBody.dynamic = NO;
        _bottomLine.physicsBody.affectedByGravity = NO;
        _bottomLine.physicsBody.friction = 1.0;
        _bottomLine.physicsBody.categoryBitMask = bottomCategory;
    }
    return _bottomLine;
}

- (SKSpriteNode *)endLine
{
    if (!_endLine) {
        _endLine =
        [[SKSpriteNode alloc] initWithColor:[UIColor redColor]
                                       size:CGSizeMake(1,self.frame.size.height)];
        
        _endLine.position = CGPointMake(3, self.frame.size.height / 2);
        _endLine.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_endLine.frame.size];
        _endLine.physicsBody.dynamic = NO;
        _endLine.physicsBody.categoryBitMask = endCategory;
    }
    return _endLine;
}

- (SKSpriteNode *)ball
{
    if (!_ball) {
        _ball =
        [SKSpriteNode spriteNodeWithImageNamed:@"ball.png"];
        
        _ball.position =
        CGPointMake(self.frame.size.width / 5,
                    CGRectGetMaxY(self.bottomLine.frame) + 15);
        
        _ball.physicsBody =
        [SKPhysicsBody bodyWithCircleOfRadius:_ball.size.height / 2];
        
        _ball.physicsBody.friction = 1.0f;
        _ball.physicsBody.linearDamping = 1.0f;
        _ball.physicsBody.contactTestBitMask = 1;
        
        _ball.physicsBody.categoryBitMask = ballCategory;
        _ball.physicsBody.contactTestBitMask = endCategory | bottomCategory;
    }
    return _ball;
}

- (void)setScore:(int)score
{
    _score = score;
    
    if (!self.scoreLabel) {
        self.scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        self.scoreLabel.fontSize = 45;
        self.scoreLabel.position =
        CGPointMake(CGRectGetMidX(self.frame),
                    CGRectGetMidY(self.frame) - 20);
        
        [self addChild:self.scoreLabel];
    }
    
    self.scoreLabel.text = [NSString stringWithFormat:@"%d",score];
}

#pragma mark - Action
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //跳
    if (self.jumpTimes > 0 || self.ball.physicsBody.velocity.dy == 0) {
        self.jumpTimes--;
        [self.ball.physicsBody applyImpulse:CGVectorMake(0.0, 15.0)];
    }
}

- (void)createBlock
{
    SKSpriteNode *block =
    [[SKSpriteNode alloc] initWithColor:[UIColor blueColor]
                                   size:CGSizeMake(30,30)];
    
    block.position =
    CGPointMake(self.size.width,
                CGRectGetMaxY(self.bottomLine.frame) + 15 + 30 * arc4random_uniform(3));
    
    block.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:block.frame.size];
    block.physicsBody.friction = 1.0;
    block.physicsBody.mass = self.ball.physicsBody.mass * 3;
    block.physicsBody.allowsRotation = YES;
    block.physicsBody.affectedByGravity = NO;
    
    block.physicsBody.categoryBitMask = blockCategory;
    block.physicsBody.contactTestBitMask = endCategory;
    
    [self addChild:block];
    [self.blockArray addObject:block];
}

#pragma mark - SKPhysicsContactDelegate
- (void)didBeginContact:(SKPhysicsContact *)contact
{
    if ([self isRelation:contact A:self.ball B:self.endLine]) {
        [self.ball removeFromParent];
        self.ball = nil;
        
        [self.scene.view presentScene:[[RJStartScene alloc] initWithSize:self.size]
                           transition:[SKTransition doorsOpenVerticalWithDuration:1.0]];
    }
    
    if ([self isRelationCategory:contact CodeA:blockCategory CodeB:endCategory]) {
        
        SKSpriteNode *block =
        (SKSpriteNode *)(contact.bodyA.categoryBitMask == blockCategory ?
                         contact.bodyA.node : contact.bodyB.node);
        
        [self.blockArray removeObject:block];
        [block removeFromParent];
        
        self.score++;
        [self performSelector:@selector(createBlock)
                   withObject:nil
                   afterDelay:arc4random_uniform(4) * 0.5];
    }
}

- (void)didEndContact:(SKPhysicsContact *)contact
{
    if ([self isRelationCategory:contact CodeA:ballCategory CodeB:bottomCategory]) {
        self.jumpTimes = 1;
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
    int speed = MIN(self.score / 10 + 5, 15);
    
    for (SKSpriteNode *block in self.blockArray) {
        block.position = CGPointMake(block.position.x - speed, block.position.y);
    }
    
    float move = 0;
    
    if (self.ball.position.x < self.size.width * 3 / 5) move = 0.1;
    if (self.ball.position.x > self.size.width * 4 / 5) move = -0.1;

    [self.ball.physicsBody applyImpulse:CGVectorMake(move, 0.0)];
}

@end
