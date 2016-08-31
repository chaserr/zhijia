//
//  AppUser.m
//  zhijia
//
//  Created by 童星 on 16/6/5.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//
#define GB_CLIENT_KEY       @"gb_user_info"

#import "AppUser.h"
static AppUser * instance = nil;

@implementation AppUser

+ (AppUser*)getInstance
{
    @synchronized(self)
    {
        if (instance == nil)
        {
            instance = (AppUser*)[AppUser objectForKey:GB_CLIENT_KEY];
            
            if (!instance)
            {
                instance = [[AppUser alloc] init];
            }
        }
    }
    return instance;
}

+ (void)clearInstance
{
    instance = nil;
}

- (void)save
{
    [AppUser setObject:self forKey:GB_CLIENT_KEY];
}

+ (BOOL)setObject:(NSObject *)value forKey:(NSString *)key
{
    NSString *path = [self dataFilePathForKey:key];
    return [NSKeyedArchiver archiveRootObject:value toFile:path];
}

+ (NSObject *)objectForKey:(NSString *)key
{
    NSString *path = [self dataFilePathForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}
+ (NSString *)dataFilePathForKey:(NSString *)key
{
    NSString *documentDirectory = [APP_UTILITY userDocumentPath];
    NSString *dir = [documentDirectory stringByAppendingPathComponent:@"userdata"];
    
    NSError *error = nil;
    
    if (![[NSFileManager defaultManager] createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:&error])
    {
        return nil;
    }
    NSString *path = [NSString stringWithFormat:@"%@/%@", dir, key];
    return path;
}

- (BOOL) saveProtraitImage:(UIImage *)image withPath:(NSString *)path{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *imageCacheMgrDir = [self getImageCachePath];
    // 创建目录
    if (![[NSFileManager defaultManager] fileExistsAtPath:imageCacheMgrDir])
    {
        [fileManager createDirectoryAtPath:imageCacheMgrDir withIntermediateDirectories:YES attributes:nil error:nil];
        
    }
    
    return [UIImageJPEGRepresentation(image, 0.6) writeToFile:[imageCacheMgrDir stringByAppendingPathComponent:[path MD5]]atomically:YES];
    
}

- (NSString*)getCachePath
{
    //获取程序cache目录
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

- (NSString*)getImageCachePath
{
    //获取引擎图片cache目录
    NSString *imageCachePath = [[self getCachePath] stringByAppendingPathComponent:@"image/yyImageDownloadCache"];
    return imageCachePath;
}

//从缓存读取图片
- (UIImage*)readPhotoFromLocalCache:(NSString *)path;
{
    // 图片缓存目录
    NSString *imageCacheMgrDir = [self getImageCachePath];
    // 最终图片路径 = 图片缓存目录/[url md5]
    NSString *imageCacheMgrPath = [imageCacheMgrDir stringByAppendingPathComponent:[path MD5]];
    
    NSData *reader = [NSData dataWithContentsOfFile:imageCacheMgrPath];
    return [UIImage imageWithData:reader];
}

-(BOOL)deleteProtraitFileWithPath:(NSString *)path{
    NSString *imageCacheMgrDir = [self getImageCachePath];
    // 最终图片路径 = 图片缓存目录/[url md5]
    NSString *imageCacheMgrPath = [imageCacheMgrDir stringByAppendingPathComponent:[path MD5]];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isSucceed = [fileManager removeItemAtPath:imageCacheMgrPath error:nil];
    return isSucceed;
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
