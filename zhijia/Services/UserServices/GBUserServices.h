//
//  GBUserServices.h
//  
//
//  Created by 童星 on 16/5/24.
//
//

#import "GBBaseServices.h"

@interface GBUserServices : GBBaseServices

/*
 *  @brief  注册
 *  @param  age 年龄
 *  @param  gender 性别
 *  @param  response 回调block
 *  @return N/A
 */
- (void)registerUser:(int)age
              gender:(int)gender
            location:(NSDictionary *) locationInfo;

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
     resopnse:(GBResponse)response;



@end
