//
//  IPHeaderView.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSIBView.h"

IB_DESIGNABLE
@interface IPHeaderView : PDSIBView

@property(nonatomic, strong) IBOutlet UIImageView *iconImageView;
@property(nonatomic, strong) IBOutlet UIButton *backButton;

@property(nonatomic, strong) IBInspectable NSString *titleString;
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;

@end
