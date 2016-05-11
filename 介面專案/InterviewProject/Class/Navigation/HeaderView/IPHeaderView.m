//
//  IPHeaderView.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPHeaderView.h"

@implementation IPHeaderView

- (void)xibDidSetup
{
    #if !TARGET_INTERFACE_BUILDER
    FAKFontAwesome *cogIcon =
    [FAKFontAwesome barsIconWithSize:20];
    [cogIcon addAttribute:NSForegroundColorAttributeName
                    value:[UIColor blackColor]];
    self.iconImageView.image = [cogIcon imageWithSize:CGSizeMake(20, 20)];
    #endif
}

- (void)setTitleString:(NSString *)titleString
{
    self.titleLabel.text = titleString;
}

- (NSString *)titleString
{
    return self.titleLabel.text;
}

@end
