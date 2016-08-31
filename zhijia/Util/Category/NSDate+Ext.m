//
//  NSDate+Ext.m
//  YouYuan
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import "NSDate+Ext.h"

@implementation NSDate (IdentifierAddition)

+ (BOOL)isYesterday:(NSDate*)compareDate
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:-1];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *compareString = [formatter stringFromDate:compareDate];
    NSString *nowString = [formatter stringFromDate:date];
    if ([compareString isEqualToString:nowString]) {
        return YES;
    }
    return NO;
}
+ (BOOL) isToday:(NSDate *)compareDate
{
    NSDate * date = [NSDate date];
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString * compareString = [formatter stringFromDate:compareDate];
    NSString * nowString = [formatter stringFromDate:date];
    if ([compareString isEqualToString:nowString]) {
        return YES;
    }
    return NO;
}
+ (BOOL)isTheDayBeforeYesterday:(NSDate*)compareDate
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:-2];
    NSCalendar *gregorian = [[NSCalendar alloc]
                             
                             initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *date = [gregorian dateByAddingComponents:comps toDate:[NSDate date] options:0];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy.MM.dd"];
    NSString *compareString = [formatter stringFromDate:compareDate];
    NSString *nowString = [formatter stringFromDate:date];
    if ([compareString isEqualToString:nowString]) {
        return YES;
    }
    return NO;
}

+(NSString *) compareCurrentTime:(NSDate*) compareDate
//
{
//    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
//    timeInterval = -timeInterval;
//    int temp = timeInterval;
    NSString *result;
    /*if ((temp = timeInterval/60) <5) {
        result = [NSString stringWithFormat:@"刚刚"];
    }
    else if((temp = timeInterval/60) <30){
        result = [NSString stringWithFormat:@"%d分钟前",temp];
    }
    
    else */
//    if((temp = temp/60/60) <24)
    if ([self isToday:compareDate])
    {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        result = [NSString stringWithFormat:@"%@",[formatter stringFromDate:compareDate]];
    }
    else if([self isYesterday:compareDate]){
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        result = [NSString stringWithFormat:@"昨天%@",[formatter stringFromDate:compareDate]];
    }
    /*else if([self isTheDayBeforeYesterday:compareDate]){
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        result = [NSString stringWithFormat:@"前天%@",[formatter stringFromDate:compareDate]];
    }*/
    else
    {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        if ([[formatter stringFromDate:compareDate] isEqualToString:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]]]]) {
           // [formatter setDateFormat:@"MM月dd HH:mm"];
            [formatter setDateFormat:@"M月dd日"];
        }
        else
        {
           // [formatter setDateFormat:@"yyyy年MM月dd HH:mm"];
            [formatter setDateFormat:@"yyyy年M月dd日"];
        }
        
        
        result = [formatter stringFromDate:compareDate];
    }
    return  result;
}

+(NSString *) compareCurrentTimeForShort:(NSDate*) compareDate
{
    NSTimeInterval  timeInterval = [compareDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    NSString *result;
   
//    if((timeInterval = timeInterval/60/60) <24){
//        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"HH:mm"];
//        result = [NSString stringWithFormat:@"%@",[formatter stringFromDate:compareDate]];
//    }
    if ([self isToday:compareDate]) {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        result = [NSString stringWithFormat:@"%@",[formatter stringFromDate:compareDate]];
    }
    else if([self isYesterday:compareDate]){
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        result = [NSString stringWithFormat:@"昨天%@",[formatter stringFromDate:compareDate]];
    }
    else
    {
        NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy"];
        if ([[formatter stringFromDate:compareDate] isEqualToString:[formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]]]]) {
            [formatter setDateFormat:@"MM月dd日 HH:mm"];
        }
        else
        {
            [formatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        }
        
        result = [formatter stringFromDate:compareDate];
    }
    return  result;
}

+(NSString *) convertToString:(NSDate*) date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}



+(NSInteger)month {
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:[NSDate date]];
    NSInteger month = [conponent month];
    
    return month;
}

+(NSInteger)day {
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:[NSDate date]];
    NSInteger day = [conponent day];
    
    return day;
}

+(NSInteger)year {
    NSCalendar * cal=[NSCalendar currentCalendar];
    NSUInteger unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
    NSDateComponents * conponent= [cal components:unitFlags fromDate:[NSDate date]];
    NSInteger year = [conponent year];
    
    return year;
}

@end

