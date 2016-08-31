//
//  SustainManage.m
//  WalkOnTime
//
//  Created by tongxing on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import "SustainManage.h"
@implementation SustainManage

static SustainManage *manage = nil;
+ (SustainManage *)shareInstance
{
    @synchronized(self){
        if (manage == nil) {
            manage = [[SustainManage alloc] init];//伪单例
        }
    }
    return manage;
}
//用户信息
- (void)synchronized
{
    [[NSUserDefaults standardUserDefaults] synchronize];
}

////设置用户信息（存储用户信息到本地）
//- (void)setSendEnvelopSTiem:(NSString *)startTime{
//
//    [[NSUserDefaults standardUserDefaults] setObject:startTime forKey:[NSString stringWithFormat:@"sendEnvelopSTime%@",APP_USER.userID]];
//}
//
//- (void)setIsSendRedEnvelop:(NSInteger)isSendRedEnvelop{
//
//    [[NSUserDefaults standardUserDefaults] setInteger:isSendRedEnvelop forKey:[NSString stringWithFormat:@"isSendRedEnvelop%@",APP_USER.userID]];
//}
//
//- (void)setAskForContactCount:(NSInteger)askForContactCount{
//
//    [[NSUserDefaults standardUserDefaults] setInteger:askForContactCount forKey:[NSString stringWithFormat:@"askForContactCount%@",APP_USER.userID]];
//}
//
//- (void)setLookLetterInterceptCount:(NSInteger)lookLetterInterceptCount{
//
//    [[NSUserDefaults standardUserDefaults] setInteger:lookLetterInterceptCount forKey:[NSString stringWithFormat:@"lookLetterInterceptCount%@",APP_USER.userID]];
//
//}


- (void)setMiGuUrl:(NSString *)chuangYiReadUrl{

    [[NSUserDefaults standardUserDefaults] setObject:chuangYiReadUrl forKey:@"chuangYiReadUrl"];

}

//获取用户信息
//
//- (NSString *)sendEnvelopSTime{
//
//    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:[NSString stringWithFormat:@"sendEnvelopSTime%@",APP_USER.userID]];
//    return time;
//}
//
//- (NSInteger)isSendRedEnvelop{
//    
//    NSInteger isSend = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"isSendRedEnvelop%@",APP_USER.userID]];
//    return isSend;
//    
//}
//
//- (NSInteger)askForContactCount{
//
//    NSInteger askCount = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"askForContactCount%@",APP_USER.userID]];
//
//    return askCount;
//    
//}
//
//- (NSInteger)lookLetterInterceptCount{
//
//    NSInteger lookCount = [[NSUserDefaults standardUserDefaults] integerForKey:[NSString stringWithFormat:@"lookLetterInterceptCount%@",APP_USER.userID]];
//    return lookCount;
//}

- (NSString *)chuangYiReadUrl{

    NSString *chuangYiReadUrl = [[NSUserDefaults standardUserDefaults] objectForKey:@"chuangYiReadUrl"];
    
    return chuangYiReadUrl;
}



//将对象归档
- (NSData *)dataOfArchiveObject:(id)object forKey:(NSString *)key
{

    NSMutableData *data = [NSMutableData data];
    //创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:data];
    //归档
    [archiver encodeObject:object forKey:key];
    //结束归档
    [archiver finishEncoding];
    return data;
}

//解档
- (id)unarchiveObject:(NSData *)data forKey:(NSString *)key
{
//创建解档对象
    NSKeyedUnarchiver *unArchived = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    //解档
    id object = [unArchived decodeObjectForKey:key];
    //结束解档
    [unArchived finishDecoding];
    return object;
}
@end
