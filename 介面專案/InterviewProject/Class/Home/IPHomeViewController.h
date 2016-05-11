//
//  IPHomeViewController.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/3.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPBasicViewController.h"

//視差動畫參考
//http://www.bondlink.com.tw/WebDesign/market-show.asp?id=271

//全球旅遊都市排名
//https://newsroom.mastercard.com/wp-content/uploads/2014/07/Mastercard_GDCI_2014_Letter_Final_70814.pdf

@interface IPHomeViewController : IPBasicViewController
<UITableViewDataSource, UITableViewDelegate>

@property(nonatomic, strong) IBOutlet UITableView *mainTableView;

@end
