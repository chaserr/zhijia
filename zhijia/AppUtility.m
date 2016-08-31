//
//  AppUtility.m
//  zhijia
//
//  Created by 童星 on 16/6/5.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#define GB_CURRENT_USER_KEY     @"gb_current_user_info"


#import "AppUtility.h"

@implementation GBCurrentUser

- (id)init
{
    if (self = [super init])
    {
        self.account = nil;
        self.password = nil;
        self.token = nil;
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [self autoEncodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        [self autoDecode:aDecoder];
    }
    
    return self;
}

@end

static AppUtility * utilityInstance = nil;

@implementation AppUtility
+ (AppUtility*)getInstance
{
    @synchronized(self)
    {
        if (utilityInstance == nil)
        {
            utilityInstance = [[AppUtility alloc] init];
        }
    }
    return utilityInstance;
}

- (id)init
{
    if (self = [super init])
    {
        self.currentUser = (GBCurrentUser*)[AppUtility objectForKey:GB_CURRENT_USER_KEY];
        if (nil == self.currentUser)
        {
            self.currentUser = [[GBCurrentUser alloc] init];
            [self readFromOldVersion];
        }
        

    }
    return self;
}
//从老版本读取出账号
- (void)readFromOldVersion {
    NSArray * path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [path objectAtIndex:0];
    NSString * oldVersionFilename = [documentsDirectory stringByAppendingPathComponent:@"UserInfo.xml"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:oldVersionFilename]) {
        NSDictionary *countInfo = [NSDictionary dictionaryWithContentsOfFile:oldVersionFilename];
        self.currentUser.account = [countInfo objectForKey:@"userName"];
        self.currentUser.password = [countInfo objectForKey:@"passWord"];
        if ([[NSFileManager defaultManager] isDeletableFileAtPath:oldVersionFilename])
        {
            NSError *error = [[NSError alloc] init];
            [[NSFileManager defaultManager] removeItemAtPath:oldVersionFilename error:&error];
        }
    }
}

- (BOOL)isOpenLocationService
{
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        return YES;
    }else{
        return NO;
    }
}

- (BOOL)checkCurrentUser
{
    //有用户名和密码或者有token就可以登录
    if ((self.currentUser.account && self.currentUser.password )|| self.currentUser.token)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (void)saveCurrentUser
{
    [AppUtility setObject:self.currentUser forKey:GB_CURRENT_USER_KEY];
}

- (void)clearCurrentUser
{
    // 清除当前用户的数据库引用
//    [YYCoreDataMgr destroy];
    
    // 清空当前用户的AppUser单例,新注册后重新创建
    [AppUser clearInstance];
    
    // 清空当前用户登录的账户,新注册后重新创建
    //self.currentUser.account = nil;
    //self.currentUser.password = nil;
    //self.currentUser.userID = nil;
    self.currentUser.token = nil;
    GB_CONFIG.token = nil;
    
    [self saveCurrentUser];
}

// 当前用户路径
- (NSString *)userDocumentPath
{
    if(nil == self.currentUser.account)
        return nil;
    
    NSString *path = [[[FileUtil getFileUtil] getDocmentPath] stringByAppendingPathComponent:self.currentUser.account];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if (![fileMgr fileExistsAtPath:path])
    {
        NSError *error = nil;
        [fileMgr  createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
        {
            DLog(@"\n---- Create userDocumentPath error %@ ----", error.description);
        }
    }
    
    return path;
}

// 当前用户图片路径
- (NSString *)imageFilePath
{
    NSString *path = [[self userDocumentPath] stringByAppendingPathComponent:@"image"];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if (![fileMgr fileExistsAtPath:path])
    {
        NSError *error = nil;
        [fileMgr  createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
        {
            DLog(@"\n---- Create imageFilePath error %@ ----", error.description);
        }
    }
    
    return path;
}

// 公共文件夹路径
- (NSString *)commonPath
{
    NSString *path = [[[FileUtil getFileUtil] getDocmentPath] stringByAppendingPathComponent:@"common"];
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    
    if (![fileMgr fileExistsAtPath:path])
    {
        NSError *error = nil;
        [fileMgr  createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
        if (error)
        {
            DLog(@"\n---- Create commonPath error %@ ----", error.description);
        }
    }
    return path;
}

- (NSString*)bundleFile:(NSString*)file
{
    return [[NSBundle mainBundle] pathForResource:[file stringByDeletingPathExtension] ofType:[file pathExtension]];
}

+ (BOOL)setObject:(NSObject *)value forKey:(NSString *)key
{
    return [NSKeyedArchiver archiveRootObject:value toFile:[self dataFilePathForKey:key]];
}

+ (NSObject *)objectForKey:(NSString *)key
{
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self dataFilePathForKey:key]];
}

+ (NSString *)dataFilePathForKey:(NSString *)key
{
    NSString *documentPath = [[FileUtil getFileUtil] getDocmentPath];
    NSString *dir = [documentPath stringByAppendingPathComponent:@"user"];
    
    NSError *error = nil;
    
    if (![[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error])
    {
        return nil;
    }
    NSString *path = [NSString stringWithFormat:@"%@/%@", dir, key];
    return path;
}



@end
