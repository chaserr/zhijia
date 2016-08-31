//
//  TelephonyUtil.h
//  YouYuan
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//
//

#import <Foundation/Foundation.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTCallCenter.h>

@protocol ITelephonyDelegate <NSObject>

/**
 *  运营商信息改变
 *
 *  @param carr carr description
 */
- (void)carrierStautsChange:(CTCarrier *)carr;

/**
 *  呼叫状态改变
 *
 *  @param call call description
 */
- (void)callStautsChange:(CTCall *)call;

@end

@interface TelephonyUtil : NSObject
{
    
}

+ (TelephonyUtil *)shareInstance;

- (void)setDelegate:(id<ITelephonyDelegate>)delegate;

@end
