//
//  IPNetWorkAPI.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/17.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPNetWorkAPI.h"
#import "IPCacheManager.h"

@implementation IPNetWorkAPI

+ (void)taipeiOpenDataRid:(NSString *)rid
          CompletionBlock:(void (^)(NSDictionary *responseObject))completionBlock
{
    //Request 管理者
    AFHTTPSessionManager *manager =
    [AFHTTPSessionManager manager];
    
    manager.responseSerializer.acceptableContentTypes =
    [NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    //包成參數
    NSMutableDictionary *parameters =
    [NSMutableDictionary dictionary];
    
    NSString *path =
    [@"http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid="
     stringByAppendingString:rid];
    
    [manager GET:path
      parameters:parameters
        progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             completionBlock(responseObject);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             completionBlock(nil);
         }];
    
    //格式
    //http://data.taipei/opendata/datalist/datasetMeta?oid=8ef1626a-892a-4218-8344-f7ac46e1aa48
}

+ (void)taipeiBikeCompletionBlock:(void (^)(NSDictionary *responseObject))completionBlock
{
    NSString *key = @"ddb80380-f1b3-4f8e-8016-7ed9cba571d5";
    
    BOOL shouldCallApi = YES;
    
    //如果不存在 先看是否從檔讀
    //如果存在 將 判斷邏輯 打包成常用method
    //如果要call api 將 儲存 跟 寫出邏輯 打包成常用method
    //組合(時間)輸出 的 部分可以分開(如果需要寫入硬碟)
    
    //https://www.google.com.tw/search?q=isEqualToArray+isEqualToDictionary&safe=off&biw=1440&bih=734&tbas=0&source=lnt&sa=X&ved=0ahUKEwjOxtvI_ZbMAhWo26YKHUJaCB4QpwUIEw
    //自己建立deep好了
    
    NSDate *date =
    maybe([IPCacheManager sharedInstance].dataDictionary[key][IPCacheManagerTimeKey], NSDate);
    if (date) {
        if (ABS([date timeIntervalSinceNow]) < 300) {
            shouldCallApi = NO;
        }
    }
    
    if (shouldCallApi) {
        void (^newCompletionBlock)(NSDictionary *responseObject) =
        ^(NSDictionary *responseObject){
            
            if (responseObject) {
                {//追加紀錄
                    NSMutableDictionary *newResponseObject = [responseObject mutableCopy];
                    newResponseObject[@"time"] = [NSDate date];
                    responseObject = newResponseObject;
                }
                
                NSMutableDictionary *dataPair = [NSMutableDictionary dictionary];
                dataPair[IPCacheManagerTimeKey] = [NSDate date];
                dataPair[IPCacheManagerDataKey] = responseObject;
                
                [IPCacheManager sharedInstance].dataDictionary[key] = dataPair;
            }
            
            completionBlock(responseObject);
        };
        
        [self taipeiOpenDataRid:key
                CompletionBlock:newCompletionBlock];
    }
    else {
        NSDictionary *responseObject =
        [IPCacheManager sharedInstance].dataDictionary[key][IPCacheManagerDataKey];
        
        //NSLog(@"CacheManager %@",[IPCacheManager sharedInstance].dataDictionary.allKeys);
        completionBlock(responseObject);
    }
}

@end
