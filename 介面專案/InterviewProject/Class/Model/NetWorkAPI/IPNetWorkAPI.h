//
//  IPNetWorkAPI.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/17.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPNetWorkAPI : NSObject

+ (void)taipeiOpenDataRid:(NSString *)rid
          CompletionBlock:(void (^)(NSDictionary *responseObject))completionBlock;

+ (void)taipeiBikeCompletionBlock:(void (^)(NSDictionary *responseObject))completionBlock;

@end
