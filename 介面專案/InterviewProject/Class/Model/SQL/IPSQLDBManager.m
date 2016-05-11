//
//  IPSQLDBManager.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/11.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPSQLDBManager.h"

@implementation IPSQLDBManager

#pragma mark - Init
+ (FMDatabase *)mainDatabase
{
    static FMDatabase *db = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path =
        [[NSBundle mainBundle] pathForResource:@"mainDB" ofType:@"db"];
        
        db = [FMDatabase databaseWithPath:path];
        [db open];
    });
    return db;
}

@end
