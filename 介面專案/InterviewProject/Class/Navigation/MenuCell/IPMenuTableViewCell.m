//
//  IPMenuTableViewCell.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPMenuTableViewCell.h"

@implementation IPMenuTableViewCell

+ (NSString *)defaultXibName
{
    return @"IPMenuCell";
}

- (void)xibDidSetup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    self.bgImageView.image = [UIImage menuCellBgImage];
}

@end
