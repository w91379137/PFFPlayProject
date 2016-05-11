//
//  SPCoordinates.m
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "SPCoordinates.h"

@implementation SPCoordinates

- (id)copyWithZone:(NSZone *)zone
{
    SPCoordinates *copy = [[[self class] alloc] init];
    
    if (copy) {
        copy.x = self.x;
        copy.y = self.y;
    }
    
    return copy;
}

- (BOOL)isEqual:(id)object
{
    if (![object isKindOfClass:[self class]]) {
        return NO;
    }
    
    SPCoordinates *other = (SPCoordinates *)object;
    
    if (other.x == self.x &&
        other.y == self.y) {
        return YES;
    }
    return NO;
}

@end
