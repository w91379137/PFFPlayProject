//
//  IPDescription.h
//  InterviewProject
//
//  Created by w91379137 on 2016/4/13.
//  Copyright © 2016年 w91379137. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, PropertyType) {
    PropertyTypeInteger,
    PropertyTypeNSString
};

typedef NS_ENUM(NSInteger, DBtype) {
    DBtypeINTEGER,
    DBtypeTEXT
};

@interface IPDescription : NSObject

@property(nonatomic) PropertyType propertyType;
@property(nonatomic) SEL setterSelector;
@property(nonatomic) SEL getterSelector;
@property(nonatomic) DBtype dbtype;
@property(nonatomic, strong) NSString *dbKey;

@end
