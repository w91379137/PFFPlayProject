//
//  PDSIBCollectionViewCell.m
//  PDSIBDesignableView_objcDemo
//
//  Created by w91379137 on 2016/3/27.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSIBCollectionViewCell.h"
#import "UIView+PDSIBDesignable.h"

@implementation PDSIBCollectionViewCell

#pragma mark - Init
- (id)initWithFrame:(CGRect)aRect
{
    self = [super initWithFrame:aRect];
    if (self) {
        [self xibSetup:self.class.defaultXibName];
    }
    return self;
}

#pragma mark - overwrite
- (void)xibSetup:(NSString *)xibName
{
    UIView *view = [self loadViewFromNib:xibName];
    
    if (view) {
        [self.contentView addSubview:view];
        
        weakMake(self.contentView, weakObject);
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakObject.mas_top);
            make.leading.equalTo(weakObject.mas_leading);
        }];
        [self xibDidSetup];
    }
}

- (UIView *)loadViewFromNib:(NSString *)xibName
{
    self.mainContainerView = [super loadViewFromNib:xibName];
    return self.mainContainerView;
}

- (void)xibDidSetup
{
    //If constants in xib no width -> make.trailing.equalTo
    //If constants at xib no height -> make.botton.equalTo
}

@end
