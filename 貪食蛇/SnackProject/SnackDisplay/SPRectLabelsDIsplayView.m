//
//  SPRectLabelsDisplayView.m
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "SPRectLabelsDisplayView.h"

@implementation SPRectLabelsDisplayView

- (NSString *)keyGenerateByX:(NSInteger)x Y:(NSInteger)y
{
    return
    [NSString stringWithFormat:@"%ld_%ld",(long)x,(long)y];
}

- (void)createLabels
{
    if (!self.rectLabelsDictionary) {
        
        float length = [UIScreen mainScreen].bounds.size.width / self.gameMap.width;
        self.rectLabelsDictionary = [NSMutableDictionary dictionary];
        
        for (NSInteger x = 0; x < self.gameMap.width; x++) {
            
            for (NSInteger y = 0; y < self.gameMap.height; y++) {
                
                CALayer *layer = [CALayer new];
                layer.frame =
                CGRectMake(x * length + 1,
                           y * length + 20 + 1,
                           length - 2,
                           length - 2);
                
                layer.cornerRadius = 6;
                
                [self.layer addSublayer:layer];
                self.rectLabelsDictionary[[self keyGenerateByX:x Y:y]] = layer;
            }
        }
        
        self.frame =
        CGRectMake(0, 0,
                   self.gameMap.width * length ,
                   self.gameMap.height * length);
    }
}

- (void)reloadColor
{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    
    for (NSInteger x = 0; x < self.gameMap.width; x++) {
        for (NSInteger y = 0; y < self.gameMap.height; y++) {
            
            CALayer *layer = self.rectLabelsDictionary[[self keyGenerateByX:x Y:y]];
            
            SPCoordinates *coordinates = [SPCoordinates new];
            coordinates.x = x;
            coordinates.y = y;
            
            layer.backgroundColor =
            [self.delegate displayView:self
                    colorOfCoordinates:coordinates].CGColor;
        }
    }
    
    [CATransaction commit];
}

@end
