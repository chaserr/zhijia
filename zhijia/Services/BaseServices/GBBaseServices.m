//
//  GBBaseServices.m
//  zhijia
//
//  Created by 童星 on 16/5/23.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBBaseServices.h"
@interface GBBaseServices ()
/** 状态 */
@property (nonatomic, assign) int status;

@end
@implementation GBBaseServices

//- (BOOL)networkReachable
//{
//    Reachability* reach = [Reachability reachabilityForInternetConnection];
//    
//    if([reach currentReachabilityStatus] == NotReachable)
//    {
//        return NO;
//    }
//    else
//    {
//        return YES;
//    }
//}

//- (BOOL)networkReachable
//{
//    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
//
//    @WeakObj(self);
//    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
//        @StrongObj(self);
//        self.status = status;
//
//    }];
//    
//    if (self.status <= 0) {
//        return NO;
//    }else{
//        
//        return YES;
//    }
//
//}
@end
