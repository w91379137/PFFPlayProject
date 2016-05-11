//
//  IPHomeTableViewCell.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/9.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPHomeTableViewCell.h"

static UIImage *gradientImage;

@interface IPHomeTableViewCell()

@property(nonatomic, weak) UITableView *tableView;

@end

@implementation IPHomeTableViewCell

#pragma mark - OverWrite
- (void)xibDidSetup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.mainContainerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
    
    self.gradientImageView.image = [IPHomeTableViewCell gradientImage];
}

+ (UIImage *)gradientImage
{
    if (!gradientImage) {
        gradientImage =
        [UIImage makeGradientImage:CGSizeMake(30, 30)
                        StartPoint:CGPointMake(15, 0)
                          EndPoint:CGPointMake(15, 30)
                            Colors:@[[UIColor colorWithRed:0 green:0 blue:0 alpha:0],
                                     [UIColor colorWithRed:0 green:0 blue:0 alpha:1]]
                          Location:@[@0,@1]];
    }
    return gradientImage;
}

- (UITableView *)tryTableView
{
    id view = [self superview];
    while (view && [view isKindOfClass:[UITableView class]] == NO) {
        view = [view superview];
    }
    return view;
}

#pragma mark - OverWrite
- (void)didMoveToSuperview
{
    [super didMoveToSuperview];
    self.tableView = [self tryTableView];
}

#pragma mark - Setter / Getter
- (void)setTableView:(UITableView *)tableView
{
    if (_tableView == tableView) return;
    
    _tableView = tableView;
    self.bgImageView.alpha = tableView ? 1 : 0;
    
    weakSelfMake(weakSelf);
    
    [tableView addSafeObserver:self
                    forKeyPath:NSStringFromSelector(@selector(contentOffset))
                UniqueModifyID:@"ParallaxScrolling" //會使之前的被移除
                   ActionBlock:^(NSString *keyPath, id object, NSDictionary *change, void *context) {
                       [weakSelf adjustBgImageView];
                   }];
}

- (void)setCity:(IPCity *)city
{
    _city = city;
    
    NSURL *imageURL = [NSURL URLWithString:city.cityImageURL];
    
    if (imageURL)
        [self.bgImageView setImageWithURL:imageURL
              usingActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    else
        self.bgImageView.image = nil;
    
    self.titleLabel.text = maybe(city.cityName, NSString);
    self.desLabel.text = maybe(city.cityDescription, NSString);
}

#pragma mark - Reload
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self adjustBgImageView];
}

- (void)adjustBgImageView
{
    if (!self.tableView) return;
    
    //影像高 - cell高
    float canShiftHeight = 150; //請手動輸入 self.bgImageView.frame 可能是錯的
    //(self.bgImageView.frame.size.height - self.frame.size.height) / 2;) / 2;
    
    //(cell底 - contentOffset.y) / tableView高
    float bottom =
    self.frame.origin.y + self.frame.size.height;
    
    float multiple =
    MAX(0, bottom - self.tableView.contentOffset.y) /
    MAX(1, self.tableView.frame.size.height + self.frame.size.height);
    multiple = MIN(multiple, 1);
    multiple -= 0.5;
    //multiple 0.5 ~ -0.5
    
    //NSLog(@"%f",multiple);
    [self.bgImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bgImageView.superview.mas_centerY).offset(canShiftHeight * multiple);
    }];
}

@end
