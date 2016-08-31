//
//  GBError.m
//  zhijia
//
//  Created by 童星 on 16/5/23.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBError.h"

@implementation GBError
+ (GBError*)errorWithNSError:(NSError*)error
{
    GBError* sterror = [GBError errorWithDomain:error.domain code:error.code userInfo:error.userInfo];
    return sterror;
}

+ (GBError*)errorWithCode:(NSInteger)code errorMessage:(NSString*)errorMsg
{
    NSMutableDictionary* userInfo = [[NSMutableDictionary alloc] initWithCapacity:2];
    [userInfo setObject:[NSString stringWithFormat:@"%ld", code] forKey:@"errorCode"];
    if (errorMsg)
    {
        [userInfo setObject:errorMsg forKey:@"errorMsg"];
    }
    GBError* error = [GBError errorWithDomain:@"ZhiJia" code:code userInfo:userInfo];
    return error;
}

- (NSInteger)errorCode
{
    return self.code;
}

- (NSString*)errorMsg
{
    NSString* errorMsg = nil;
    errorMsg = [self.userInfo objectForKey:@"errorMsg"];
    
    if (nil == errorMsg)
    {
        if (NSOrderedSame == [self.domain compare:@"NSURLErrorDomain"])
        {
            switch (self.code)
            {
                case NSURLErrorNotConnectedToInternet:
                    errorMsg = @"网络连接失败，请稍候再试";
                    break;
                case NSURLErrorTimedOut:
                    errorMsg = @"连接超时";
                    break;
                case kCFURLErrorCancelled:
                    errorMsg = @"网络连接失败，请稍候再试";
                    break;
                case kCFURLErrorCannotFindHost:
                    //                    errorMsg = @"未能找到使用指定主机名的服务器";
                    errorMsg = @"网络连接失败，请稍候再试";
                    break;
                default:
                    //                    errorMsg = self.domain;
                    //更改默认服务器提示
                    errorMsg = @"服务器开小差了，别怕，程序员哥哥正在抢修~";
                    break;
            }
        }
        else
        {
            errorMsg = @"未知错误";
        }
    }
    
    return errorMsg;
}

@end
