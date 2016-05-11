//
//  IPCity.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/12.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPCity.h"

@implementation IPCity

#pragma mark - Data
+ (NSString *)tableName
{
    return @"City";
}

+ (NSMutableArray *)propertySettingArray
{
    NSMutableArray *array = [super propertySettingArray];
    {
        IPDescription *description = [[IPDescription alloc] init];
        description.propertyType = PropertyTypeNSString;
        description.setterSelector = @selector(setCityName:);
        description.getterSelector = @selector(cityName);
        description.dbtype = DBtypeTEXT;
        description.dbKey = @"cityName";
        [array addObject:description];
    }
    {
        IPDescription *description = [[IPDescription alloc] init];
        description.propertyType = PropertyTypeNSString;
        description.setterSelector = @selector(setCityImageURL:);
        description.getterSelector = @selector(cityImageURL);
        description.dbtype = DBtypeTEXT;
        description.dbKey = @"cityImageURL";
        [array addObject:description];
    }
    {
        IPDescription *description = [[IPDescription alloc] init];
        description.propertyType = PropertyTypeNSString;
        description.setterSelector = @selector(setCityDescription:);
        description.getterSelector = @selector(cityDescription);
        description.dbtype = DBtypeTEXT;
        description.dbKey = @"cityDescription";
        [array addObject:description];
    }
    return array;
}

#pragma mark - 
+ (NSArray *)allCity
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
