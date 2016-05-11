//
//  NSArray+NSArrayFormatExtension.m
//
//  Created by w91379137 on 2015/8/24.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale
{
    NSMutableString *str =
    [NSMutableString stringWithFormat:@"%@ count:%lu \n[\n",
     [[self class] description], (unsigned long)self.count];
    
    for (NSInteger k = 0; k < self.count; k++) {
        
        if (k != 0) {
            [str appendString:@",\n"];
        }
        
        {
            id obj = self[k];
            NSString *willAdd = [NSString stringWithFormat:@"%@", obj];
            
            willAdd = [willAdd stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
            willAdd = [@"\t" stringByAppendingString:willAdd];
            
            [str appendString:willAdd];
        }
        [str appendString:[NSString stringWithFormat:@" _Index(%ld)",(long)k]];
    }
    
    [str appendString:@"\n]"];
    
    return str;
}

@end
