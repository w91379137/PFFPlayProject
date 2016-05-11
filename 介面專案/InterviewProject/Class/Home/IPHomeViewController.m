//
//  IPHomeViewController.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/3.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPHomeViewController.h"
#import "IPHomeTableViewCell.h"

@interface IPHomeViewController ()
{
    NSArray *citys;
}

@end

@implementation IPHomeViewController

#pragma mark - Init
- (void)viewDidLoad
{
    [super viewDidLoad];
    {
        [self.mainTableView registerClass:[IPHomeTableViewCell class]
                   forCellReuseIdentifier:cellReuseIdentifier];
    }
    
    citys = [IPCity allCity];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return citys.count;
}

-     (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果更換高度 tableView 會壞掉
    //從下往上滑會 逐一更新高度 會瞬移
    //MIN(tableView.contentSize.width / 16 * 9, tableView.frame.size.height);
    CGSize size = [UIScreen mainScreen].bounds.size;
    return MIN(size.width, size.height);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IPHomeTableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
    
    cell.city = maybe(citys[indexPath.row], IPCity);
    return cell;
}

#pragma mark - UITableViewDelegate

@end
