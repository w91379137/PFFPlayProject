//
//  IPFoodCollectionViewCell.h
//  InterviewProject
//
//  Created by w91379137 on 2016/5/11.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IPFoodCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) IPFood *food;

@property(nonatomic, strong) IBOutlet UIImageView *bgImageView;
@property(nonatomic, strong) IBOutlet UILabel *titleLabel;

@end
