//
//  GBUtils.h
//  zhijia
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GBUtils : NSObject
+(UIAlertView*)alert:(NSString*)msg;
+(void)showTextDialog:(UIView *)view message:(NSString *)text;
+(NSDate *)dateFromString:(NSString *)createAt;
+(NSDate *)dateFromInt:(int) createAt;
+(NSString *)createdDateFormat:(int)createAt;
@end
