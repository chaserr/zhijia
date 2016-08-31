//
//  SustainManage.h
//  WalkOnTime
//
//  Created by tongxing on 15/7/13.
//  Copyright (c) 2015年 朝夕. All rights reserved.
//

#import <Foundation/Foundation.h>

#define  APP_SustainManage [SustainManage shareInstance]

@class UserMessage;
@interface SustainManage : NSObject

+ (SustainManage *)shareInstance;

//用户信息
- (void)synchronized;

//设置用户信息
- (void)setSendEnvelopSTiem:(NSString *)startTime;
- (void)setAskForContactCount:(NSInteger)askForContactCount;
- (void)setIsSendRedEnvelop:(NSInteger)isSendRedEnvelop;
- (void)setLookLetterInterceptCount:(NSInteger)lookLetterInterceptCount;

// 保存咪咕阅读url
- (void)setMiGuUrl:(NSString *)chuangYiReadUrl;


//获取用户信息
- (NSString *)sendEnvelopSTime;
- (NSInteger)askForContactCount;
- (NSInteger)isSendRedEnvelop;
- (NSInteger)lookLetterInterceptCount;

// 获取咪咕url
- (NSString *)chuangYiReadUrl;
//将对象归档
- (NSData *)dataOfArchiveObject:(id)object forKey:(NSString *)key;
//解档
- (id)unarchiveObject:(NSData *)data forKey:(NSString *)key;




@end
