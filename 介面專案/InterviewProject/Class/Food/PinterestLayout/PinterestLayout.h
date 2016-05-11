//
//  PinterestLayout.h
//  PDSCustomLayout
//
//  Created by w91379137 on 2016/2/13.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>

//http://www.raywenderlich.com/107439/uicollectionview-custom-layout-tutorial-pinterest
@protocol PinterestLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *)collectionView
       HeightForIndexPath:(NSIndexPath *)indexPath
                    Width:(CGFloat)width;
@end

@interface PinterestLayout : UICollectionViewLayout

//1. Pinterest Layout Delegate
@property (nonatomic, weak) IBOutlet NSObject<PinterestLayoutDelegate> *delegate;

//2. Configurable properties
@property (nonatomic) NSInteger numberOfColumns;
@property (nonatomic) CGFloat cellPadding;

//3. Array to keep a cache of attributes.
@property(nonatomic, strong) NSMutableArray *cache;

@end
