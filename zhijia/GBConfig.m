//
//  GBConfig.m
//  zhijia
//
//  Created by 童星 on 16/5/24.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBConfig.h"

static GBConfig * instance = nil;

@implementation GBConfig

+ (GBConfig*)getInstance
{
    @synchronized(self) {
        if (instance == nil)
        {
            instance = [[GBConfig alloc] init];
        }
    }
    return instance;
}

- (id)init
{
    self = [super init];
    if (self != nil)
    {
        
        [self initConfig];
        
    }
    return self;
}


-(void)initConfig
{
    
    self.token = nil;
    self.sessionId = nil;
    //初始化fid 从xcconfig配置中读取
    _hostUrl = kHostUrl;

    
    [self updateAllUrl];
}

- (void)updateAllUrl{

    
    // 登录
    self.loginUrl = [self getRelativePaths:kLoginUrl];
    self.registerVerifyUrl = [self getRelativePaths:kRegiseterVerifyUrl];
    
    // =======首页
    self.messageListUrl = [self getRelativePaths:kMessageListUrl];
    self.sendMessageUrl = [self getRelativePaths:kSendMessageUrl];
    self.sendCommentUrl = [self getRelativePaths:kSendCommentUrl];
    self.sendPraiseUrl = [self getRelativePaths:kSendPraiseUrl];


    
    // ====== 我的
    self.getuserUrl = [self getRelativePaths:kGetuserUrl];
    self.updateUserUrl = [self getRelativePaths:kUpdateuserUrl];
    self.experienceAddUrl = [self getRelativePaths:kExperienceAddUrl];
    self.experienceRemoveUrl = [self getRelativePaths:kExperienceRemoveUrl];
    self.experienceUpdateUrl = [self getRelativePaths:kExperienceUpdateUrl];
    
    
}

- (NSString *)getRelativePaths:(NSString *)urlPath{

    return [NSString stringWithFormat:@"%@%@", _hostUrl, urlPath];
}

- (NSDictionary*)getPlatformInfo
{
    /*
     "platformInfo":
     {
     "version":版本号,
     "fid":渠道号,
     "platform":平台(8->IOS),
     "product":产品号(21->红版;22->小金刚;24->约会吧), 新改产品id 是1004
     "phonetype":手机型号,
     "pid":手机串号,
     "w":分辨率宽,
     "h":分辨率高,
     "systemVersion":系统版本,
     "netType":联网类型(0->无网络,2->wifi,3->cmwap,4->cmnet,5->ctnet,6->ctwap,7->3gwap,8->3gnet,9->uniwap,10->uninet)
     "imsi":sim卡imsi号,
     "mobileIP":手机ip
     "release":发版时间，例如：20150117
     }
     */
    NSMutableDictionary *platformInfo = [[NSMutableDictionary alloc] init];
    
    [platformInfo setValue:@"50050100" forKey:@"version"];
    
    [platformInfo setValue:[NSNumber numberWithInt:8] forKey:@"platform"];
    [platformInfo setValue:[CommonUtils getCurrentDeviceName] forKey:@"phonetype"];
    [platformInfo setValue:@"862845022676899" forKey:@"pid"];
    [platformInfo setValue:[NSNumber numberWithInt:[[UIScreen mainScreen] bounds].size.width] forKey:@"w"];
    [platformInfo setValue:[NSNumber numberWithInt:[[UIScreen mainScreen] bounds].size.height] forKey:@"h"];
    [platformInfo setValue:[[UIDevice currentDevice] systemVersion] forKey:@"systemVersion"];
    [platformInfo setValue:[NSNumber numberWithInt:2] forKey:@"netType"];
    //[platformInfo setValue:@"" forKey:@"imsi"];
    [platformInfo setValue:@"127.0.0.1" forKey:@"mobileIP"];
    
    
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    // 客户端编译日期和次数
    NSString* buildVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    [platformInfo setValue:[NSNumber numberWithInt:[buildVersion intValue]] forKey:@"release"];
    
    return platformInfo;
}

- (NSString*)getAuthCode
{
    // 广告标示符（IDFA-identifierForIdentifier）
    // 示例: 1E2DFA89-496A-47FD-9941-DF1FC4E6484A
    NSString* adId = [CommonUtils advertisingIdentifier];
    // 获取到时间戳里的毫秒单位
    UInt64 nowTime = [[NSDate date] timeIntervalSince1970] * 1000;
    NSString* str = [NSString stringWithFormat:@"%@_%llu", adId, nowTime];
    NSString* auth = [NSString stringWithFormat:@"%@_%llu_%@", adId, nowTime, [CommonUtils gbMD5:str]];
    
    return auth;
}
@end
