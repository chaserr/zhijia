//
//  TelephonyUtil.m
//  YouYuan
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//
//

#import "TelephonyUtil.h"

@interface TelephonyUtil ()
{
    CTCallCenter *center;
    CTTelephonyNetworkInfo *info;
    CTCarrier *carrier;
    
    __weak id<ITelephonyDelegate> _delegate;
}

@end

@implementation TelephonyUtil

#pragma mark - Lifecycle

+ (TelephonyUtil *)shareInstance
{
    static TelephonyUtil *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[TelephonyUtil alloc] init];
    });
    return instance;
}

- (void)dealloc
{
    
}

- (id)init
{
    self = [super init];
    if (self)
    {
        info = [[CTTelephonyNetworkInfo alloc] init];
        carrier = info.subscriberCellularProvider;
        __weak id weakSelf = self;
        info.subscriberCellularProviderDidUpdateNotifier = ^(CTCarrier *carr) {
            NSLog(@"carrier:%@", [carr description]);
            [weakSelf carrierChange:carr];
        };
        center = [[CTCallCenter alloc] init];
        
        center.callEventHandler = ^(CTCall *call) {
            
            [weakSelf callChange:call];
        };
    }
    return self;
}

- (void)setDelegate:(id<ITelephonyDelegate>)delegate
{
    _delegate = delegate;
}

- (void)carrierChange:(CTCarrier *)carr
{
    if ([_delegate conformsToProtocol:@protocol(ITelephonyDelegate)]) {
        [_delegate carrierStautsChange:carr];
    }
}

- (void)callChange:(CTCall *)call
{
    if ([_delegate conformsToProtocol:@protocol(ITelephonyDelegate)]) {
        [_delegate callStautsChange:call];
    }
}

@end
