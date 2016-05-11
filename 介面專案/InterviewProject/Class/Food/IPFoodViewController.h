//
//  IPFoodViewController.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/15.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPBasicViewController.h"
#import "PinterestLayout.h"

//https://zh.wikipedia.org/wiki/%E5%8F%B0%E7%81%A3%E5%B0%8F%E5%90%83

@interface IPFoodViewController : IPBasicViewController
<UICollectionViewDataSource, UICollectionViewDelegate,
PinterestLayoutDelegate>

@property (nonatomic, strong) IBOutlet UICollectionView *mainCollectionView;

@end
