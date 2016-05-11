//
//  IPFood.m
//  InterviewProject
//
//  Created by w91379137 on 2016/5/11.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPFood.h"

@implementation IPFood

#pragma mark - Data
+ (NSString *)tableName
{
    return @"Food";
}

+ (NSMutableArray *)propertySettingArray
{
    NSMutableArray *array = [super propertySettingArray];
    {
        IPDescription *description = [[IPDescription alloc] init];
        description.propertyType = PropertyTypeNSString;
        description.setterSelector = @selector(setFoodName:);
        description.getterSelector = @selector(foodName);
        description.dbtype = DBtypeTEXT;
        description.dbKey = @"foodName";
        [array addObject:description];
    }
    {
        IPDescription *description = [[IPDescription alloc] init];
        description.propertyType = PropertyTypeNSString;
        description.setterSelector = @selector(setFoodImageURL:);
        description.getterSelector = @selector(foodImageURL);
        description.dbtype = DBtypeTEXT;
        description.dbKey = @"foodImageURL";
        [array addObject:description];
    }
    return array;
}

#pragma mark -
+ (NSArray *)allFood
{
    FMResultSet *result =
    [[IPSQLDBManager mainDatabase] executeQuery:self.queryAllString];
    
    NSMutableArray *array = [NSMutableArray array];
    while ([result next]) {
        IPDataObject *obj = [[self alloc] init];
        [obj reloadWithDict:[result resultDictionary]];
        [array addObject:obj];
    }
    
    return array;
}

@end
