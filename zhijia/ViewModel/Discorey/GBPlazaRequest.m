//
//  GBPlazaRequest.m
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBPlazaRequest.h"

@implementation GBPlazaRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/users/:user_id/posts";
    self.METHOD = @"GET";
    //self.httpHeaderFields = @{@"JWL-User-Token":[UserCenter sharedInstance].token};
}
@end
