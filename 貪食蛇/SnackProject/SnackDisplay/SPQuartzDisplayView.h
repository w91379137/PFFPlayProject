//
//  SPQuartzDisplayView.h
//  SnackProject
//
//  Created by w91379137 on 2016/4/30.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SPQuartzDisplayView;

@protocol SPQuartzDisplayViewDelegate <NSObject>

- (NSArray *)snackPathOnDisplayView:(SPQuartzDisplayView *)displayView;
- (NSArray *)fruitPathOnDisplayView:(SPQuartzDisplayView *)displayView;

@end

@interface SPQuartzDisplayView : UIView

@property(nonatomic, weak) id<SPQuartzDisplayViewDelegate> delegate;

@end
