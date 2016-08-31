//
//  GBHttpService.h
//  zhijia
//
//  Created by 童星 on 16/5/23.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBHttpService : NSObject
typedef void (^HttpReuqestSucceedBlock)(NSString*reqId, NSDictionary* dic);
typedef void (^HttpRequestFailedBlock)(NSString*reqId, NSError* error);

/**
 * 单例
 */
+ (GBHttpService *)getInstance;

/**
 * @brief 设置请求头
 * @param headerDic HTTP请求头字典
 * @return N/A
 */
-(void)setHeaders:(NSDictionary*)headerDic;

/**
 * @brief 删除所有HTTP请求头
 */
-(void)removeAllHeaders;

/**
 * @brief Get请求
 * @param path 请求页面
 * @param onCompletion 返回结果
 * @param onError 失败错误
 * @return uniqueId;
 */


-(NSString*) sendGetWithURL:(NSString*)url httpHeader:(NSDictionary*)headerDic onCompletion:(HttpReuqestSucceedBlock) completionBlock onError:(HttpRequestFailedBlock) errorBlock;

/**
 * @brief Post请求
 * @param path 请求页面
 * @param body 数据内容
 * @param onCompletion 返回结果
 * @param onError 失败错误
 * @return uniqueId;
 */
-(NSString*) sendPostWithURL:(NSString*)url body:(NSMutableDictionary*)body httpHeader:(NSDictionary*)headerDic onCompletion:(HttpReuqestSucceedBlock) completionBlock onError:(HttpRequestFailedBlock) errorBlock;

/**
 * @brief 取消
 * @param uniqueId
 * @return 成功或失败
 */
-(BOOL) cancelWithUniqueId:(NSString*)uniqueId;

/**
 * @brief 取消所有
 */
-(void) cancelAll;
@end
