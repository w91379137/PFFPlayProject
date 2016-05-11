//
//  IPFoodViewController.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/15.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPFoodViewController.h"
#import "IPFoodCollectionViewCell.h"

static NSString *kCollectionViewCellID = @"CollectionViewCellID";

@interface IPFoodViewController ()
{
    NSArray *foods;
}

@end

@implementation IPFoodViewController

#pragma mark - Init
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.mainCollectionView registerNib:
     [UINib nibWithNibName:NSStringFromClass([IPFoodCollectionViewCell class])
                    bundle:nil]
     forCellWithReuseIdentifier:kCollectionViewCellID];
    
    foods = [IPFood allFood];
    
    PinterestLayout *layout =
    (PinterestLayout *)self.mainCollectionView.collectionViewLayout;
    
    weakMake(layout, weaklayout);
    weakSelfMake(weakSelf);
    [self.view addSafeObserver:layout
                    forKeyPath:@"frame"
                UniqueModifyID:@"layoutClearCache"
                   ActionBlock:^(NSString *keyPath, id object, NSDictionary *change, void *context) {
                       [weaklayout.cache removeAllObjects];
                       [weakSelf.mainCollectionView reloadData];
                   }];
}

#pragma mark - UICollectionViewDataSource Cell
- (NSInteger)collectionView:(UICollectionView *)theCollectionView
     numberOfItemsInSection:(NSInteger)theSectionIndex
{
    return foods.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IPFoodCollectionViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellID
                                              forIndexPath:indexPath];
    
    cell.food = maybe(foods[indexPath.row], IPFood);
    return cell;
}

#pragma mark - PinterestLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
       HeightForIndexPath:(NSIndexPath *)indexPath
                    Width:(CGFloat)width
{
    return indexPath.row % 2 == 0 ? 150 : 100;
}

- (BOOL)isEmptyBlackCell:(NSInteger)index
{
    return NO;
}

@end
