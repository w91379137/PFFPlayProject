//
//  SPSnack.m
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "SPSnack.h"

@implementation SPSnack

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.bodyPointArray = [NSMutableArray array];
        self.direction = UISwipeGestureRecognizerDirectionDown;
        self.maxBodyLength = 2;
    }
    return self;
}

- (void)move
{
    SPCoordinates *coordinates = self.bodyPointArray.firstObject;
    
    SPCoordinates *newCoordinates = [coordinates copy];
    [self.gameMap shiftCoordinates:newCoordinates
                         Direction:self.direction];
    [self.bodyPointArray insertObject:newCoordinates atIndex:0];
    
    {//檢查長度
        while (self.bodyPointArray.count > self.maxBodyLength) {
            [self.bodyPointArray removeLastObject];
        }
    }
}

- (BOOL)isHeadTouchSelf
{
    for (NSInteger k = 1; k < self.bodyPointArray.count; k++) {
        SPCoordinates *coordinates = self.bodyPointArray[k];
        
        if ([self.bodyPointArray.firstObject isEqual:coordinates]) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)isHeadTouchCoordinates:(SPCoordinates *)coordinates
{
    return [self.bodyPointArray.firstObject isEqual:coordinates];
}

@end
