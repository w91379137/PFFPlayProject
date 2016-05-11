//
//  IPCacheManager.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/17.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPCacheManager.h"

@implementation IPCacheManager

#pragma mark - Init
+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

#pragma mark - Setter / Getter
- (NSMutableDictionary *)dataDictionary
{
    _dataDictionary =
    maybeDefault(_dataDictionary, NSMutableDictionary, [NSMutableDictionary dictionary]);
    
    return _dataDictionary;
}

@end
