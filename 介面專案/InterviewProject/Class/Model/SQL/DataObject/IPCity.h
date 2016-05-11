//
//  IPCity.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/12.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPDataObject.h"

@interface IPCity : IPDataObject

@property(nonatomic, strong) NSString *cityName;
@property(nonatomic, strong) NSString *cityImageURL;
@property(nonatomic, strong) NSString *cityDescription;

+ (NSArray *)allCity;

@end
