//
//  UIView+PDSIBDesignable.h
//  PDSIBDesignableView_objcDemo
//
//  Created by w91379137 on 2016/3/27.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDSIBDesignableView_objc.h"

@interface UIView (PDSIBDesignable)

+ (NSString *)defaultXibName;

- (void)xibSetup:(NSString *)xibName;

- (UIView *)loadViewFromNib:(NSString *)xibName;

- (void)xibDidSetup;

@end
