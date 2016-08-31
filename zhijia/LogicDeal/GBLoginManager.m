//
//  GBLoginManage.m
//  zhijia
//
//  Created by 张浩 on 16/5/13.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBLoginManager.h"
#import "GBLoginViewControl.h"

static GBLoginManager *_sharedLoginManager = nil;


@implementation GBLoginManager

+ (GBLoginManager*)getInstance
{
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        
        _sharedLoginManager = [[GBLoginManager alloc] init];
    });
    
    return _sharedLoginManager;
}

- (id)init
{
    self = [super init];
    
    if(self)
    {
        //        [[NSNotificationCenter defaultCenter] addObserver:self
        //                                                 selector:@selector(handleTokenExpire)
        //                                                     name:kNotificationTokenError
        //                                                   object:nil];
        //
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(handleServerError)
                                                     name:kNotificationServerError
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(didEnterBackground)
                                                     name:KNotifcationApplicationDidEnterBackground
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(willEnterForeground)
                                                     name:KNotifcationApplicationWillEnterForeground
                                                   object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updateLoginState)
                                                     name:kNotificationLoginStateChanged
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(getUserLocation)
                                                     name:kNotificationGetLocationInfo
                                                   object:nil];
        
        
        _loginState = EGBStatusNotLogin;
        _appState = EGBAppStateWillEnterForeground;
//        _updateVersion = nil;
        _isShowUpdateOnce = NO;
        
    }
    return self;
}

// 用户开始登陆
- (void)startLogin:(NSString*)account password:(NSString*)password verType:(int)verType type:(int)type loginSuccess:(LoginSuccess)loginSuccess loginFiled:(LoginFailed)loginFailed
{
    //    if(![APP_UTILITY checkCurrentUser])
    //        return;
    //
    _loginMode = EGBUserLogin;
    
    if(self.loginState != EGBStatusNotLogin)
    {
        return;
        
    }
    
    [self setloginState:EGBStatusLogining];
    
    DLog(@"\n---- 开始登录 ----");
    NSString *path = GB_CONFIG.loginUrl;
    // 测试账号：
    NSDictionary *postDict = @{ @"account": account,
                                @"password" : password
                                };
    [GBNetworking postWithUrl:path params:[postDict mutableCopy]success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseDict) {
        NSHTTPURLResponse *response =(NSHTTPURLResponse *)((NSURLSessionTask *)task).response;
        NSDictionary *allHeaders = response.allHeaderFields;
        // 获取tocken
        NSInteger state = [[responseDict objectForKey:@"state"] integerValue];
        if (state == 200) {
            [self setloginState:EGBStatusLogined];

            APP_UTILITY.currentUser.account = account;
            APP_UTILITY.currentUser.password = password;
            APP_UTILITY.currentUser.token = [allHeaders objectForKey:@"Token"];
            
            APP_USER.account = account;
            APP_USER.password = password;
            [APP_USER save];
            
            GB_CONFIG.token = [allHeaders objectForKey:@"Token"];
            DLog(@"%@", [allHeaders objectForKey:@"Token"]);
            
            loginSuccess();
        }
        else{
            
            [GBHUDVIEW showTips:[responseDict objectForKey:@"data"] autoHideTime:2];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                loginFailed();
                [self setloginState:EGBStatusNotLogin];
            });

        }
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self setloginState:EGBStatusNotLogin];
        if ([[error.userInfo objectForKey:@"_kCFStreamErrorCodeKey"] intValue] == -2102) {
//            [error.userInfo objectForKey:@"NSLocalizedDescription"]
            [GBHUDVIEW showTips:@"请求超时，请稍后再试" autoHideTime:2];

        }else{
        
            [GBHUDVIEW showTips:@"用户鉴权失败" autoHideTime:2];

        }
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            loginFailed();

        });

    }];

}

- (void)logout
{
    // 重置登录状态
    [self setloginState:EGBStatusNotLogin];
    // 清空当前用户(包括数据库引用)
//    [APP_UTILITY clearCurrentUser];
    
//#ifndef NO_POLLNOTIFY_NOTIFICATION
    // 停止轮询
//    [[YYNotifyManager getInstance] stop];
//#endif
//    // 停止QA拦截
//    [[YYQAManager getInstance] stop];
    // 跳转到登录界面
    [AppNavigator openLoginViewController];
//#ifndef NO_JPUSH_NOTIFICATION
//    [[YYPushManager getInstance] cleanTagsAlias];
//#endif
//    [[YYCoreDataMgr instance] cleanUp];
    
    _loginMode = EGBUserNUll;
}

- (void)setloginState:(EGBLoginState)state
{
    if(_loginState == state)
    {
        return;
    }
    
    // 状态机改变发出登录状态改变通知
    _loginState = state;
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLoginStateChanged object:nil];
}

- (void)handleServerError
{
    //[YYHUDVIEW showTips:@"服务器错误" autoHideTime:1];
//    UI_LOG(@"服务器错误");
}

- (void)updateLoginState
{
    // todo...
}

-(void)didEnterBackground
{
    _appState = EGBAppStateDidEnterBackground;
}

-(void)willEnterForeground
{
    _appState = EGBAppStateWillEnterForeground;
}

- (void) getUserLocation
{
    if (_loginMode == EGBUserRegister) {
        [self uploadLocation];
    }else if(_loginMode == EGBUserLogin) {
        [self checkUserLocationInfo];
    }
    
}


// 更新用户的位置信息
- (void)uploadLocation
{
//    NSDictionary * locationDict = [self parseLocationInfo:Loction_Manager.locationInfo];
//    if (locationDict) {
//        [YY_CORE.userService uploadLocation:locationDict resopnse:^(NSInteger result, NSDictionary *dict, YYError *error){
//            if (result == EYYResponseResultSucceed) {
//                NSString * isSuccess = [dict objectForKey:@"isSucceed"];
//                NSString * message = [dict objectForKey:@"message"];
//            }
//        }];
//    }
    
}

// 登陆后检测用户位置信息

-(void) checkUserLocationInfo
{
//    NSDictionary * locationDict = [self parseLocationInfo:Loction_Manager.locationInfo];
//    if (locationDict) {
//        [YY_CORE.userService checkUserLocation:locationDict  resopnse:^(NSInteger result, NSDictionary *dict, YYError *error){
//            
//            if (result == EYYResponseResultSucceed) {
//                NSDictionary * areaDict = [UtilFunc checkNull:[dict objectForKey:@"area"]];
//                if(areaDict != nil){
//                    YYArea * area = [[YYArea alloc] init];
//                    NSDictionary * areaDict = [dict objectForKey:@"area"];
//                    area.provinceId = [[UtilFunc checkNull:[areaDict objectForKey:@"provinceId"]]intValue];
//                    area.provinceName = [UtilFunc checkNull:[areaDict objectForKey:@"provinceName"]];
//                    area.cityId = [[UtilFunc checkNull:[areaDict objectForKey:@"cityId"]]intValue];
//                    area.cityName = [UtilFunc checkNull:[areaDict objectForKey:@"cityName"]];
//                    area.areaId = [[UtilFunc checkNull:[areaDict objectForKey:@"areaId"]] intValue];
//                    area.areaName = [UtilFunc checkNull:[areaDict objectForKey:@"areaName"]];
//                    APP_USER.currentArea = areaDict;
//                    
//                    YYContactData * myData = [YYContactData contactByUid:APP_USER.userID];
//                    YYArea * currentUserArea = myData.area;
//                    BOOL userAreaIsChange = NO;
//                    if (![currentUserArea.provinceName isEqualToString:area.provinceName] ) {
//                        userAreaIsChange = YES;
//                        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserSetLocationChange object:nil];
//                        
//                    }
//                    
//                    if (userAreaIsChange ){
//                        
//                        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"您当前位置和设置的个人信息不一致，现在是否更新" cancelButtonTitle:@"取消" otherButtonTitles:@[@"确定"] handler:^(UIAlertView *alertView, NSInteger buttonIndex){
//                            if (buttonIndex == 1) {
//                                
//                                myData.area = area;
//                                YYUser* user = [myData convertToCoreObject];
//                                [YY_CORE.contactsService uploadMyInfo:user response:^(NSInteger result, NSDictionary *dict, YYError *error) {
//                                    
//                                    if(result == EYYResponseResultSucceed)
//                                    {
//                                        // 上传成功,需要更新缓存,并存数据库
//                                        YYUser* user = [[YYContactManager getInstance] parseUserObject:[dict objectForKey:@"user"]];
//                                        YYContactData* me = [[YYContactManager getInstance] convertUserObject:user];
//                                        [me saveContact];
//                                        [YYHUDVIEW showTips:@"更新信息成功"];
//                                        
//                                    }
//                                    else if (result == EYYResponseResultFailed)
//                                    {
//                                        [YYHUDVIEW showTips:[NSString stringWithFormat:@"%@", error.errorMsg] autoHideTime:2];
//                                    }
//                                }];
//                                
//                                [myData saveContact];
//                            }
//                        }];
//                        
//                    }
//                }
//            }
//        }];
//        
//    }
//    

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
