//
//  IPHomeTableViewCell.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/9.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSIBTableViewCell.h"

@interface IPHomeTableViewCell : PDSIBTableViewCell

@property(nonatomic, strong) IPCity *city;

@property(nonatomic, strong) IBOutlet UIImageView *bgImageView;
@property(nonatomic, strong) IBOutlet UIImageView *gradientImageView;

@property(nonatomic, strong) IBOutlet UILabel *titleLabel;
@property(nonatomic, strong) IBOutlet UILabel *desLabel;

@end
