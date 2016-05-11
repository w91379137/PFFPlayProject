//
//  SPRectLabelsDisplayView.h
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPMap.h"

@class SPRectLabelsDisplayView;

@protocol SPRectLabelsDIsplayViewDelegate <NSObject>

- (UIColor *)displayView:(SPRectLabelsDisplayView *)displayView
      colorOfCoordinates:(SPCoordinates *)coordinates;

@end

#pragma mark -

@interface SPRectLabelsDisplayView : UIView

@property(nonatomic, weak) SPMap *gameMap;
@property(nonatomic, weak) id<SPRectLabelsDIsplayViewDelegate> delegate;
@property(nonatomic, strong) NSMutableDictionary *rectLabelsDictionary;

- (void)createLabels;
- (void)reloadColor;

@end
