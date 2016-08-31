//
//  GBUtils.m
//  zhijia
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBUtils.h"

@implementation GBUtils
+(UIAlertView*)alert:(NSString*)msg{
    UIAlertView *alertView=[[UIAlertView alloc]
                            initWithTitle:nil message:msg delegate:nil
                            cancelButtonTitle:@"好的" otherButtonTitles:nil];
    [alertView show];
    return alertView;
}

+(void)showTextDialog:(UIView *)view message:(NSString *)text
{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    hud.mode = MBProgressHUDModeText;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    [hud hide:YES afterDelay:2];
}

+(NSDate *)dateFromString:(NSString *)createAt
{
    return [NSDate dateWithTimeIntervalSince1970:[createAt doubleValue]];
}
+(NSDate *)dateFromInt:(int)createAt
{
    return [[self class] dateFromString:[NSString stringWithFormat:@"%d",createAt]];
}
+(NSString *)createdDateFormat:(int)created
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH24:mm:ss Z yyyy";
    NSDate *createDate = [[self class] dateFromInt:created];
    if (createDate.isThisYear) {
        if (createDate.isToday) { // 今天
            NSDateComponents *cmps = [createDate deltaWithNow];
            if (cmps.hour >= 1) { // 至少是1小时前发的
                return [NSString stringWithFormat:@"%ld小时前", (long)cmps.hour];
            } else if (cmps.minute >= 1) { // 1~59分钟之前发的
                return [NSString stringWithFormat:@"%ld分钟前", (long)cmps.minute];
            } else { // 1分钟内发的
                return @"刚刚";
            }
        } else if (createDate.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        } else { // 至少是前天
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd";
        return [fmt stringFromDate:createDate];
    }
}
@end
