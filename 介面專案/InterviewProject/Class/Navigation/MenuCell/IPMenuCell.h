//
//  IPMenuCell.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/15.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImage (MenuCell)

+ (UIImage *)menuCellBgImage;

@end

@protocol IPMenuCellProtocol <NSObject>

@property(nonatomic, strong) IBOutlet UIImageView *bgImageView;

@property(nonatomic, strong) IBOutlet UILabel *iconLabel;
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;

@end
