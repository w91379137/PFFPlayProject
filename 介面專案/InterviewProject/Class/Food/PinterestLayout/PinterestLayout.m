//
//  PinterestLayout.m
//  PDSCustomLayout
//
//  Created by w91379137 on 2016/2/13.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PinterestLayout.h"

@interface PinterestLayout()

//4. Content height and size
@property(nonatomic) CGFloat contentHeight;
@property(nonatomic) CGFloat contentWidth;

@end

@implementation PinterestLayout

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.numberOfColumns = 2;
        self.cellPadding =  1.0;
        self.cache = [NSMutableArray array];
    }
    return self;
}

- (CGFloat)contentWidth
{
    UIEdgeInsets insets = self.collectionView.contentInset;
    return CGRectGetWidth(self.collectionView.bounds) - (insets.left + insets.right);
}

- (void)prepareLayout
{
    // 1. Only calculate once
    if (self.cache.count == 0) {
        self.contentHeight = 0.0;
        
        // 2. Pre-Calculates the X Offset for every column and adds an array to increment the currently max Y Offset for each column
        CGFloat columnWidth = self.contentWidth / self.numberOfColumns;
        NSMutableArray *xOffset = [NSMutableArray array];
        for (NSInteger column = 0; column < self.numberOfColumns; column++) {
            [xOffset addObject:@(column * columnWidth)];
        }
        
        NSMutableArray *yOffset = [NSMutableArray array];
        for (NSInteger column = 0; column < self.numberOfColumns; column++) {
            [yOffset addObject:@(0)];
        }
        
        NSInteger column = 0;
        for (NSInteger item = 0; item < [self.collectionView numberOfItemsInSection:0]; item++) {
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:item inSection:0];
            
            // 4. Asks the delegate for the height of the picture and the annotation and calculates the cell frame.
            CGFloat width = columnWidth - self.cellPadding * 2;
            CGFloat itemHeight =
            [self.delegate collectionView:self.collectionView
                       HeightForIndexPath:indexPath
                                    Width:width];
            
            CGFloat height = self.cellPadding + itemHeight;
            CGRect frame = CGRectMake([xOffset[column] doubleValue],
                                      [yOffset[column] doubleValue],
                                      columnWidth,
                                      height);
            
            CGRect insetFrame = CGRectInset(frame, self.cellPadding, self.cellPadding);
            
            // 5. Creates an UICollectionViewLayoutItem with the frame and add it to the cache
            
            UICollectionViewLayoutAttributes *attributes =
            [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            
            attributes.frame = insetFrame;
            [self.cache addObject:attributes];
            
            // 6. Updates the collection view content height
            self.contentHeight = MAX(self.contentHeight, CGRectGetMaxY(frame));
            yOffset[column] = @([yOffset[column] doubleValue] + height);
            
            NSInteger minHeightColumn = 0;
            float currentHeight = [yOffset[minHeightColumn] doubleValue];
            
            for (NSInteger k = 1; k < yOffset.count; k++) {
                float checkHeight = [yOffset[k] doubleValue];
                if (checkHeight < currentHeight) {
                    currentHeight = checkHeight;
                    minHeightColumn = k;
                }
            }
            column = minHeightColumn;
        }
    }
}

- (CGSize)collectionViewContentSize
{
    //超過height 使collectionView 正常bounds
    float height = MAX(self.contentHeight, self.collectionView.bounds.size.height + 1);
    return CGSizeMake(self.contentWidth, height);
}

//http://stackoverflow.com/questions/31784104/uicollectionview-with-custom-uicollectionviewlayout-validatelayoutinrect-accerti
//https://github.com/fizzy871/collViewBugTest/blob/master/collViewBugTest/mosaicGridLayout.m

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
    
    // Loop through the cache and look for items in the rect
    for (UICollectionViewLayoutAttributes *attributes in self.cache) {
        if (CGRectIntersectsRect(attributes.frame, rect)) {
            [layoutAttributes addObject:attributes];
        }
    }
    return layoutAttributes;
}

@end
