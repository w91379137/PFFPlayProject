//
//  SPSnack.h
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SPCoordinates.h"
#import "SPMap.h"

@interface SPSnack : NSObject

//遊戲規則
@property(nonatomic, weak) SPMap *gameMap;

//第一個是頭
@property(nonatomic, strong) NSMutableArray<SPCoordinates *> *bodyPointArray;
@property(nonatomic) NSUInteger maxBodyLength;
@property(nonatomic) UISwipeGestureRecognizerDirection direction;

- (void)move;
- (BOOL)isHeadTouchSelf;
- (BOOL)isHeadTouchCoordinates:(SPCoordinates *)coordinates;

@end
