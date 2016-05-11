//
//  IPDataObject.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/12.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IPSQLDBManager.h"
#import "IPDescription.h"

@interface IPDataObject : NSObject

@property(nonatomic) NSInteger _id;
- (void)set_idWithNumber:(NSNumber *)_id;

+ (NSString *)tableName;
+ (NSString *)queryAllString;

+ (NSMutableArray<IPDescription *> *)propertySettingArray;
- (void)reloadWithDict:(NSDictionary *)infoDict;

- (NSString *)description;

@end
