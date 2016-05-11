//
//  NSDictionary+Log.m
//
//  Created by w91379137 on 2015/8/24.
//

#import "NSDictionary+Log.h"

@implementation NSDictionary (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSArray *allKeys = [self allKeys];
    allKeys =
    [allKeys sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString *str =
    [NSMutableString stringWithFormat:@"%@ count:%lu \n{\n",
     [[self class] description], (unsigned long)self.count];
    
    for (NSInteger k = 0; k < self.count; k++) {
        
        if (k != 0) {
            [str appendString:@",\n"];
        }
        {
            id obj = allKeys[k];
            NSString *willAdd = [NSString stringWithFormat:@"\"%@\" = ", obj];
            willAdd = [@"\t" stringByAppendingString:willAdd];
            
            [str appendString:willAdd];
        }
        {
            NSString *key = allKeys[k];
            id obj = self[key];
            
            NSString *willAdd = [NSString stringWithFormat:@"%@", obj];
            willAdd = [willAdd stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t\t"];
            
            [str appendString:willAdd];
        }
        [str appendString:[NSString stringWithFormat:@" _Index(%ld)",(long)k]];
    }
    
    [str appendString:@"\n}"];
    
    return str;
}

@end
