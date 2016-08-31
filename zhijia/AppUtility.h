//
//  AppUtility.h
//  zhijia
//
//  Created by 童星 on 16/6/5.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#define APP_UTILITY [AppUtility getInstance]

#import <Foundation/Foundation.h>

@interface GBCurrentUser : NSObject

/** 登录账号*/
@property (nonatomic, strong) NSString* account;
/** 密码*/
@property (nonatomic, strong) NSString* password;
/** token凭证*/
@property (nonatomic, strong) NSString* token;

@end

@interface AppUtility : NSObject

@property (nonatomic, strong) GBCurrentUser* currentUser;


+ (AppUtility*)getInstance;

/** 检查当前用户是否存在*/
- (BOOL)checkCurrentUser;
/** 保存当前用户 */
- (void)saveCurrentUser;
/** 注销当前用户 */
- (void)clearCurrentUser;
/** 当前用户路径 */
- (NSString *)userDocumentPath;
/**当前用户数据库路径*/
- (NSString *)databasePath;
/**当前用户图片路径*/
- (NSString *)imageFilePath;
/**公共文件夹路径*/
- (NSString *)commonPath;

- (NSString*)bundleFile:(NSString*)file;

/**用户是否开启定位服务*/
- (BOOL)isOpenLocationService;


@end
