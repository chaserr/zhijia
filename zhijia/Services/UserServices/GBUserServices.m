//
//  GBUserServices.m
//  
//
//  Created by 童星 on 16/5/24.
//
//

#import "GBUserServices.h"

@implementation GBUserServices


/*
 *  @brief  登陆
 *  @param  account 账号
 *  @param  password 密码
 *  @param  verType 客户端版本：0->红版，1->篮版(多品牌，与主版本用户数据不同步),
 *  @param  type: 0->正常登录，1->新消息通知登录(安静的登录)
 *  @param  response 回调block
 *  @return N/A
 */
- (void)login:(NSString *)account
     password:(NSString *)password
     resopnse:(GBResponse)response
{

    NSMutableDictionary *bodyDict = [[NSMutableDictionary alloc] init];
    [bodyDict setValue:account forKey:@"account"];
    [bodyDict setValue:password forKey:@"password"];
    
    NSString *url = GB_CONFIG.loginUrl;
    [GBNetworking postWithUrl:url params:[bodyDict mutableCopy]success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable dic) {
        if(dic == nil)
        {
            DLog(@"---- login fail!!!! dic = nil ----");
            if(response)
            {
                response(EGBResponseResultFailed, nil, nil, nil);
            }
            return;
        }
        
        if(response)
        {
            NSHTTPURLResponse *urlResponse =(NSHTTPURLResponse *)((NSURLSessionTask *)task).response;
            NSDictionary *allHeaders = urlResponse.allHeaderFields;
            DLog(@"---- login success!!!! ----");
            GB_CONFIG.token = [allHeaders objectForKey:@"token"];
            DLog(@"token = %@", GB_CONFIG.token);
            response(EGBResponseResultSucceed, task, dic, nil);
        }
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"---- login fail!!!! error = %@ ----", error.description);
        
        if(response)
        {
            GBError *yyerror = [GBError errorWithNSError:error];
            response(EGBResponseResultFailed, task, nil, yyerror);
        }
    }];

}
@end
