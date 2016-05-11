//
//  PDSEnvironmentViewController+SizeClass.m
//  PDSEnvironment_objcDemo
//
//  Created by w91379137 on 2016/4/6.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "PDSEnvironmentViewController+SizeClass.h"

@implementation PDSEnvironmentViewController (SizeClass)

- (UITraitCollection *)overrideTraitCollectionForChildViewController:(UIViewController *)childViewController
{
    BOOL isPortrait =
    self.view.frame.size.height > self.view.frame.size.width;
    //NSLog(@"告知 %@ %d",NSStringFromClass([childViewController class]),isPortrait);
    return isPortrait ?
    [self traitCollectionHorizontal:UIUserInterfaceSizeClassCompact
                           Vertical:UIUserInterfaceSizeClassRegular] :
    [self traitCollectionHorizontal:UIUserInterfaceSizeClassRegular
                           Vertical:UIUserInterfaceSizeClassCompact];
}

- (UITraitCollection *)traitCollectionHorizontal:(UIUserInterfaceSizeClass)horizontal
                                        Vertical:(UIUserInterfaceSizeClass)vertical
{
    UITraitCollection *traitCollection_Horizontal =
    [UITraitCollection traitCollectionWithHorizontalSizeClass:horizontal];
    
    UITraitCollection *traitCollection_Vertical =
    [UITraitCollection traitCollectionWithVerticalSizeClass:vertical];
    
    return
    [UITraitCollection traitCollectionWithTraitsFromCollections:@[traitCollection_Horizontal, traitCollection_Vertical]];
}

@end
