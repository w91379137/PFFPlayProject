//
//  IPDataObject.m
//  InterviewProject
//
//  Created by w91379137 on 2016/4/12.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import "IPDataObject.h"

@implementation IPDataObject

#pragma mark - Data
+ (NSString *)tableName
{
    return nil;
}

+ (NSMutableArray<IPDescription *> *)propertySettingArray
{
    NSMutableArray *array = [NSMutableArray array];
    {
        IPDescription *description = [[IPDescription alloc] init];
        description.propertyType = PropertyTypeInteger;
        description.setterSelector = @selector(set_idWithNumber:);
        description.getterSelector = @selector(_id);
        description.dbtype = DBtypeINTEGER;
        description.dbKey = @"_id";
        [array addObject:description];
    }
    return array;
}

#pragma mark -
- (void)set_idWithNumber:(NSNumber *)_id
{
    self._id = [_id integerValue];
}

- (void)reloadWithDict:(NSDictionary *)infoDict
{
    for (IPDescription *description in [[self class] propertySettingArray]) {
        
        if (![self respondsToSelector:description.setterSelector]) {
            continue;
        }
        
        if (![infoDict.allKeys containsObject:description.dbKey]) {
            continue;
        }
        
        id data = infoDict[description.dbKey];
        NSObject *obj = nil;
        if (description.dbtype == DBtypeINTEGER) obj = @([data integerValue]);
        if (description.dbtype == DBtypeTEXT) obj = maybe(data, NSString);
        
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [self performSelector:description.setterSelector
                   withObject:obj];
        #pragma clang diagnostic pop
    }
}

- (NSString *)description
{
    NSArray *propertyArray = [[self class] propertySettingArray];
    propertyArray =
    [propertyArray sortedArrayUsingComparator:^NSComparisonResult(IPDescription *obj1, IPDescription *obj2) {
        return [obj1.dbKey compare:obj2.dbKey];
    }];
    
    NSMutableString *string = [NSMutableString string];
    
    [string appendFormat:@"\n"];
    for (NSInteger k = 0; k < propertyArray.count; k++) {
        IPDescription *description = propertyArray[k];
        
        
        if ([self respondsToSelector:description.getterSelector]) {
            
            if (description.propertyType == PropertyTypeInteger) {
                //http://stackoverflow.com/questions/6492033/return-value-for-performselector
                //http://www.jianshu.com/p/da96980648b6
                
                NSInvocation *invocation =
                [NSInvocation invocationWithMethodSignature:
                 [[self class] instanceMethodSignatureForSelector:description.getterSelector]];
                [invocation setSelector:description.getterSelector];
                
                [invocation setTarget:self];
                [invocation invoke];
                NSInteger value;
                [invocation getReturnValue:&value];
                
                [string appendFormat:@"%@ : %ld\n",description.dbKey, (long)value];
            }
            
            if (description.propertyType == PropertyTypeNSString) {
                #pragma clang diagnostic push
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                NSString *value = [self performSelector:description.getterSelector];
                #pragma clang diagnostic pop
                [string appendFormat:@"%@ : %@\n",description.dbKey, value];
            }
        }
    }
    [string appendFormat:@"\n"];
    return string;
}

+ (NSString *)queryAllString
{
    return [NSString stringWithFormat:@"SELECT * FROM %@",self.tableName];
}

@end
