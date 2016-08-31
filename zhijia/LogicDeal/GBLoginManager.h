//
//  GBLoginManage.h
//  zhijia
//
//  Created by 张浩 on 16/5/13.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

typedef void(^LoginSuccess)();
typedef void(^LoginFailed)();

#import <Foundation/Foundation.h>

typedef enum
{
    EGBStatusNotLogin     =   -1,       //未登录
    EGBStatusLogining     =   0,        //登录中
    EGBStatusLogined      =   1,        //已登录
    
}EGBLoginState;

typedef enum {
    EGBUserNUll = 0,
    EGBUserRegister = 1,// 用户通过注册进入的客户端
    EGBUserLogin  = 2  // 用户通过登陆进入的客户端
    
    
}EGBUserIsLoginOrRegist;
typedef enum
{
    
    EGBAppStateNone                 = 0,    //保留
    EGBAppStateDidEnterBackground   = 1,    //在后台
    EGBAppStateWillEnterForeground  = 2,    //到前台
    
}EGBAppState;


@interface GBLoginManager : NSObject<UIAlertViewDelegate>
{

    BOOL _isShowUpdateOnce;
    
}

+ (GBLoginManager*)getInstance;

@property (nonatomic, copy) LoginSuccess loginSuccess;
@property (nonatomic, copy) LoginFailed loginFiled;
// 应用程序状态
@property (nonatomic, readonly, assign) EGBAppState appState;

// 用户登陆状态
@property (nonatomic, assign) EGBLoginState loginState;
// 用户登陆还是注册？
@property (nonatomic, assign) EGBUserIsLoginOrRegist  loginMode;

// 用户注销
- (void)logout;

// 新用户注册 传人参数为生日和性别
- (void) startRegisterWithBirthday:(NSString *)birthday gender:(int)gender age:(int)age;

// 新用户注册
- (void)startRegister:(int)age gender:(int)gender;

// 获取最新版本信息
- (void)getUpdateVersionInfo;


// 用户开始登陆
- (void)startLogin:(NSString*)account
          password:(NSString*)password
           verType:(int)verType
              type:(int)type
      loginSuccess:(LoginSuccess)loginSuccess
        loginFiled:(LoginFailed)loginField;


@end
