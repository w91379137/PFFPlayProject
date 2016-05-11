//
//  UIView+PDSIBDesignable.m
//  PDSIBDesignableView_objcDemo
//
//  Created by w91379137 on 2016/3/27.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "UIView+PDSIBDesignable.h"

@implementation UIView (PDSIBDesignable)

#pragma mark - Class Method
+ (NSString *)defaultXibName
{
    return NSStringFromClass(self);
}

#pragma mark - Xib Setup
- (void)xibSetup:(NSString *)xibName
{
    UIView *view = [self loadViewFromNib:xibName];
    
    if (view) {
        [self addSubview:view];
        
        weakSelfMake(weakSelf);
        [view mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(weakSelf);
        }];
        [self xibDidSetup];
    }
}

- (UIView *)loadViewFromNib:(NSString *)xibName
{
    #if !TARGET_INTERFACE_BUILDER
    if ([[NSBundle mainBundle] pathForResource:xibName
                                        ofType:@"nib"] == nil) {
        NSLog(@"No xib : %@",xibName);
        return nil;
    }
    #endif
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    UINib *nib = [UINib nibWithNibName:xibName bundle:bundle];
    
    return
    maybe([nib instantiateWithOwner:self options:nil].firstObject, UIView);
}

#pragma mark - Xib Did Setup
- (void)xibDidSetup
{
    //overwrite
}

@end
