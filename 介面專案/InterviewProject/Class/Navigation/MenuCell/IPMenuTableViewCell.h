//
//  IPMenuTableViewCell.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSIBTableViewCell.h"
#import "IPMenuCell.h"

@interface IPMenuTableViewCell : PDSIBTableViewCell
<IPMenuCellProtocol>

@property(nonatomic, strong) IBOutlet UIImageView *bgImageView;

@property(nonatomic, strong) IBOutlet UILabel *iconLabel;
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;

@end
