//
//  SPMap.h
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SPCoordinates.h"

@interface SPMap : NSObject

@property(nonatomic) NSInteger width;
@property(nonatomic) NSInteger height;

- (SPCoordinates *)centerCoordinates;
- (NSInteger)totalCapacity;
- (SPCoordinates *)randomCoordinatesWithoutArray:(NSArray<SPCoordinates *> *)coordinatesArray;
- (void)shiftCoordinates:(SPCoordinates *)coordinates
               Direction:(UISwipeGestureRecognizerDirection)direction;

@end
