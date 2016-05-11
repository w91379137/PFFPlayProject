//
//  IPFoodCollectionViewCell.m
//  InterviewProject
//
//  Created by w91379137 on 2016/5/11.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPFoodCollectionViewCell.h"

@implementation IPFoodCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.titleLabel.layer.shadowOpacity = 1;
    self.titleLabel.layer.shadowRadius = 3;
}

- (void)setFood:(IPFood *)food
{
    _food = food;
    
    NSURL *imageURL = [NSURL URLWithString:food.foodImageURL];
    
    if (imageURL)
        [self.bgImageView setImageWithURL:imageURL
              usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    else
        self.bgImageView.image = nil;
    
    self.titleLabel.text = maybe(food.foodName, NSString);
}

@end
