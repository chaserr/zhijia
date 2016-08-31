//
//  NSDate+Ext.h
//  YouYuan
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (IdentifierAddition)
+(NSString *) compareCurrentTime:(NSDate*) compareDate;
+(NSString *) compareCurrentTimeForShort:(NSDate*) compareDate;
+(NSString *) convertToString:(NSDate*) date;
+(NSInteger)day;
+(NSInteger)month;
+(NSInteger)year;
@end
