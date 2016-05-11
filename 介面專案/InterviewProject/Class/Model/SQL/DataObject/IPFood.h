//
//  IPFood.h
//  InterviewProject
//
//  Created by w91379137 on 2016/5/11.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPDataObject.h"

@interface IPFood : IPDataObject

@property(nonatomic, strong) NSString *foodName;
@property(nonatomic, strong) NSString *foodImageURL;

+ (NSArray *)allFood;

@end
