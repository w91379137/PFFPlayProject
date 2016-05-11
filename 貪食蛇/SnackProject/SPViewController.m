//
//  SPViewController.m
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "SPViewController.h"

@interface SPViewController ()

@end

@implementation SPViewController

#pragma mark - Init
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.gameMap = [SPMap new];
        self.gameMap.width = 10;
        self.gameMap.height = 15;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //顯示器
    if (!self.displayView) {
        self.displayView = [[SPRectLabelsDisplayView alloc] initWithFrame:CGRectZero];
        self.displayView.userInteractionEnabled = NO;
        [self.view addSubview:self.displayView];
        
        self.displayView.delegate = self;
        self.displayView.gameMap = self.gameMap;
        [self.displayView createLabels];
    }
    
    if (!self.quartDisplayView) {
        self.quartDisplayView = [[SPQuartzDisplayView alloc] initWithFrame:CGRectZero];
        self.quartDisplayView.frame = self.view.bounds;
        self.quartDisplayView.backgroundColor = [UIColor clearColor];
        self.quartDisplayView.userInteractionEnabled = NO;
        
        self.quartDisplayView.delegate = self;
        [self.view addSubview:self.quartDisplayView];
    }
    
    //控制器
    {
        NSArray *directions =
        @[@(UISwipeGestureRecognizerDirectionRight),
          @(UISwipeGestureRecognizerDirectionLeft),
          @(UISwipeGestureRecognizerDirectionDown),
          @(UISwipeGestureRecognizerDirectionUp)];
        
        for (NSNumber *number in directions) {
            
            UISwipeGestureRecognizer *swipeGesture =
            [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                      action:@selector(swipeAction:)];
            swipeGesture.direction = [number integerValue];
            
            [self.view addGestureRecognizer:swipeGesture];
        }
    }
    
    //計時器
    if (!self.myTimer) {
        self.myTimer =
        [NSTimer scheduledTimerWithTimeInterval:0.2
                                         target:self
                                       selector:@selector(update:)
                                       userInfo:nil
                                        repeats:YES];
        [self.myTimer fire];
    }
    
    //重新開始
    [self newGame:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if (self.myTimer) {
        [self.myTimer invalidate];
        self.myTimer = nil;
    }
    [super viewWillDisappear:animated];
}

#pragma mark - Setter / Getter
- (void)setIsGaming:(BOOL)isGaming
{
    _isGaming = isGaming;
    
    [self.reStartButton setTitle:isGaming ? @"Loop" : @"GG" forState:UIControlStateNormal];
    self.reStartButton.enabled = !isGaming;
}

#pragma mark - Control
- (IBAction)switchRectLabelsDisplayViewAction:(UISwitch *)sender
{
    self.displayView.alpha = sender.on ? 1 : 0;
}

- (IBAction)switchQuartzDisplayViewAction:(UISwitch *)sender
{
    self.quartDisplayView.alpha = sender.on ? 1 : 0;
}

- (void)update:(NSTimer *)sender
{
    if (!self.isGaming)
        return;
    
    [self.snack move];
    
    if (self.fruit &&
        [self.snack isHeadTouchCoordinates:self.fruit]) {
        self.snack.maxBodyLength++;
        [self newFruit];
    }
    
    if ([self.snack isHeadTouchSelf])
        self.isGaming = NO;
    
    [self draw];
}

- (void)swipeAction:(UISwipeGestureRecognizer *)sender
{
    BOOL isSenderDirectionVertical = YES;
    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        case UISwipeGestureRecognizerDirectionLeft:
            isSenderDirectionVertical = NO;
            break;
        default:
            break;
    }
    
    BOOL isSnackDirectionVertical = YES;
    switch (self.snack.direction) {
        case UISwipeGestureRecognizerDirectionRight:
        case UISwipeGestureRecognizerDirectionLeft:
            isSnackDirectionVertical = NO;
            break;
        default:
            break;
    }
    
    if (isSenderDirectionVertical != isSnackDirectionVertical)
        self.snack.direction = sender.direction;
}

#pragma mark - Renew
- (void)draw
{
    [self.displayView reloadColor];
    [self.quartDisplayView setNeedsDisplay];
}

- (void)newFruit
{
    self.fruit =
    [self .gameMap randomCoordinatesWithoutArray:self.snack.bodyPointArray];
}

- (IBAction)newGame:(id)sender
{
    {
        self.snack = [[SPSnack alloc] init];
        self.snack.gameMap = self.gameMap;
        [self.snack.bodyPointArray addObject:[self.gameMap centerCoordinates]];
    }
    
    [self newFruit];
    
    self.isGaming = YES;
}

#pragma mark - SPRectLabelsDIsplayViewDelegate
- (UIColor *)displayView:(SPRectLabelsDisplayView *)displayView
      colorOfCoordinates:(SPCoordinates *)coordinates
{
    if ([self.snack.bodyPointArray containsObject:coordinates]) {
        return
        [self.snack.bodyPointArray.firstObject isEqual:coordinates] ?
        [UIColor greenColor] : [UIColor blackColor];
    }
    else {
        return
        [self.fruit isEqual:coordinates] ?
        [UIColor redColor] : [UIColor whiteColor];
    }
}

#pragma mark - SPQuartzDisplayViewDelegate
- (NSArray *)snackPathOnDisplayView:(SPQuartzDisplayView *)displayView
{
    float length = [UIScreen mainScreen].bounds.size.width / self.gameMap.width;
    
    NSMutableArray *values = [NSMutableArray array];
    for (NSInteger k = 0; k < self.snack.bodyPointArray.count; k++) {
        SPCoordinates *coordinates = self.snack.bodyPointArray[k];
        
        CGPoint point =
        CGPointMake((coordinates.x + 0.5) * length ,
                    (coordinates.y + 0.5) * length + 20);
        
        [values addObject:[NSValue valueWithCGPoint:point]];
    }
    
    return values;
}

- (NSArray *)fruitPathOnDisplayView:(SPQuartzDisplayView *)displayView
{
    float length = [UIScreen mainScreen].bounds.size.width / self.gameMap.width;
    
    CGPoint point =
    CGPointMake((self.fruit.x + 0.5) * length ,
                (self.fruit.y + 0.5) * length + 20);
    
    return @[[NSValue valueWithCGPoint:point]];
}

@end
