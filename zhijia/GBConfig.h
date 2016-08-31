//
//  GBConfig.h
//  zhijia
//
//  Created by 童星 on 16/5/24.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#define GB_CONFIG [GBConfig getInstance]

#import <Foundation/Foundation.h>



#define kUMAppKey        @"5758dbdee0f55aaf51000516"
#define kSinaAppKey      @"2908806847"
#define kSinaAppSecret   @"93265075a619df27231722ed13de7ddc"
#define kQQAppID         @"1105386787"
#define kQQAppKey        @"qPUIyn7zWzkJBnl7"
#define kWexinAppId      @"wx0f3ba100728bc231"
#define kWeixinAppSecret @"20449b800bc58b3e4bc117397e36b110"

#define APP_NAME        @"有缘网"

/**
 *  @author 童星, 16-05-24 12:05:12
 *
 *  @brief 登录接口
 *
 *  @since 1.0
 */

/** 主机名*/
#define kHostUrl     @"http://api.shenbianhi.com/"

/** 登录*/
#define kLoginUrl    @"v1/auth/login"
/** 注册验证 */
#define kRegiseterVerifyUrl @"v1/register/verify"
//=======首页
/** 首页列表数据*/
#define kMessageListUrl @"v1/message/get/messagelist"
/** 发布信息 */
#define kSendMessageUrl @"v1/message/send/message"
/** 发送评论 */
#define kSendCommentUrl @"v1/message/send/comment"
/** 点赞 */
#define kSendPraiseUrl @"v1/message/send/praise"



//=======我的
/** 获取我的数据*/
#define kGetuserUrl          @"v1/user/getuser"
/** 更新我的数据*/
#define kUpdateuserUrl       @"v1/user/update/user"
/** 添加工作经验 */
#define kExperienceAddUrl    @"v1/user/experience/add"
/** 移除工作经验 */
#define kExperienceRemoveUrl @"v1/user/experience/remove"
/** 更新工作经验 */
#define kExperienceUpdateUrl @"v1/user/experience/update"

@interface GBConfig : NSObject


+ (GBConfig*)getInstance;

//token凭证
@property (nonatomic, copy) NSString* token;
//sessionId
@property (nonatomic, copy) NSString* sessionId;

//服务器地址，从xcconfig中获取
@property (nonatomic, copy) NSString* hostUrl;

//微信key
@property(nonatomic, strong) NSString* weChatKey;

//支付宝key
@property(nonatomic, strong) NSString* aliPayKey;




/** 登录 */
@property (nonatomic, copy) NSString* loginUrl;
@property (nonatomic, copy) NSString *registerVerifyUrl;
// ======= 首页
/** 首页消息列表 */
@property (nonatomic, copy) NSString *messageListUrl;
@property (nonatomic, copy) NSString *sendMessageUrl;
@property (nonatomic, copy) NSString *sendCommentUrl;
@property (nonatomic, copy) NSString *sendPraiseUrl;
// =======我的
/** 获取我的数据 */
@property (nonatomic, copy) NSString *getuserUrl;
@property (nonatomic, copy) NSString *updateUserUrl;
@property (nonatomic, copy) NSString *experienceAddUrl;
@property (nonatomic, copy) NSString *experienceRemoveUrl;
@property (nonatomic, copy) NSString *experienceUpdateUrl;

- (NSDictionary*)getPlatformInfo;
- (NSString*)getAuthCode;

@end
