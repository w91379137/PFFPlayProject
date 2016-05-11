//
//  SPMap.m
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "SPMap.h"

@implementation SPMap

- (NSInteger)totalCapacity
{
    return self.width * self.height;
}

- (SPCoordinates *)centerCoordinates
{
    SPCoordinates *coordinates = [SPCoordinates new];
    coordinates.x = self.width / 2;
    coordinates.y = self.height / 2;
    return coordinates;
}

- (SPCoordinates *)randomCoordinatesWithoutArray:(NSArray<SPCoordinates *> *)coordinatesArray
{
    NSInteger x = arc4random_uniform((int)self.width);
    NSInteger y = arc4random_uniform((int)self.height);
    
    SPCoordinates *coordinates = [SPCoordinates new];
    coordinates.x = x;
    coordinates.y = y;
    
    if (coordinatesArray.count < self.totalCapacity) {
        while ([coordinatesArray containsObject:coordinates]) {
            [self shiftCoordinates:coordinates
                         Direction:UISwipeGestureRecognizerDirectionLeft];
            if (coordinates.x == x) {
                [self shiftCoordinates:coordinates
                             Direction:UISwipeGestureRecognizerDirectionDown];
            }
            //NSLog(@"coordinates %ld %ld",(long)coordinates.x,(long)coordinates.y);
        }
        return coordinates;
    }
    else {
        return nil;
    }
}

- (void)shiftCoordinates:(SPCoordinates *)coordinates
               Direction:(UISwipeGestureRecognizerDirection)direction
{
    switch (direction) {
        case UISwipeGestureRecognizerDirectionUp:
            coordinates.y = coordinates.y - 1;
            break;
        case UISwipeGestureRecognizerDirectionDown:
            coordinates.y = coordinates.y + 1;
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            coordinates.x = coordinates.x - 1;
            break;
        case UISwipeGestureRecognizerDirectionRight:
            coordinates.x = coordinates.x + 1;
            break;
        default:
            break;
    }
    
    if (coordinates.x < 0) coordinates.x += self.width;
    if (coordinates.x >= self.width)coordinates.x -= self.width;
    
    if (coordinates.y < 0) coordinates.y += self.height;
    if (coordinates.y >= self.height) coordinates.y -= self.height;
}

@end
