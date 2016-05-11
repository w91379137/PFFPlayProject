//
//  PDSIBView.m
//  PDSIBDesignableView_objcDemo
//
//  Created by w91379137 on 2016/3/27.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSIBView.h"
#import "UIView+PDSIBDesignable.h"

@implementation PDSIBView

#pragma mark - Init
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self xibSetup:self.class.defaultXibName];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self xibSetup:self.class.defaultXibName];
    }
    return self;
}

#pragma mark - overwrite
- (UIView *)loadViewFromNib:(NSString *)xibName
{
    self.mainContainerView = [super loadViewFromNib:xibName];
    return self.mainContainerView;
}

@end
