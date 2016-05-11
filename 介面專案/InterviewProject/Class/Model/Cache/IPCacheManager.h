//
//  IPCacheManager.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/17.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IPCacheManagerDataKey @"IPCacheManagerDataKey"
#define IPCacheManagerTimeKey @"IPCacheManagerTimeKey"

@interface IPCacheManager : NSObject
{
    NSMutableDictionary *_dataDictionary;
}

- (NSMutableDictionary *)dataDictionary;
+ (instancetype)sharedInstance;


@end
