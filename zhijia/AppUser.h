//
//  AppUser.h
//  zhijia
//
//  Created by 童星 on 16/6/5.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//
#define APP_USER [AppUser getInstance]

#import <Foundation/Foundation.h>

@interface AppUser : NSObject

+ (AppUser*)getInstance;

+ (void)clearInstance;

/**登录名*/
@property (nonatomic, strong) NSString* account;
/**密码*/
@property (nonatomic, strong) NSString* password;

/**token凭证*/
@property (nonatomic, strong) NSString* token;
/**昵称*/
@property (nonatomic, strong) NSString* nickName;
/** 当前位置 */
@property (nonatomic, strong) NSDictionary * currentArea;
/**存储当前信息*/
- (void)save;
/**存储头像*/
- (BOOL) saveProtraitImage:(UIImage *)image withPath:(NSString *)path;
/**读取数据*/
- (UIImage*)readPhotoFromLocalCache:(NSString *)path;
@end
