//
//  GBResponse.h
//  zhijia
//
//  Created by 童星 on 16/5/23.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#ifndef GBResponse_h
#define GBResponse_h

#import "GBError.h"

typedef enum
{
    EGBResponseResultSucceed        =   0,
    EGBResponseResultFailed         =   1,
    
}EGBResponseResult;

typedef enum
{
    EGBUnknowError = -1000,              //未知错误
    EGBTimeOutError = -999,              //连接超时
    EGBNetWorkError = -998,              //网络错误
    EGBTokenError = -99,                 //从token中获取用户失败
    EGBServerAbnormal = -500,            //服务器异常
    EGBServerError = -995,               //服务器错误
    EGBContentViolate = -994             //内容包含违禁词
    
}EGBErrorCode;

/*
 *  @brief 通用的请求响应
 *  @param result 返回结果
 *  @param dict 返回具体内容 Value Key
 */
typedef void (^GBResponse)(NSInteger result, NSURLSessionDataTask * _Nullable task, id _Nullable response, GBError* _Nullable error);

/*
 *  @brief 下载静态图片的请求响应
 *  @param result 返回结果
 *  @param image 返回图片
 *  @param url 返回图片地址
 */
typedef void (^GBResponseImage)(NSInteger result, id image, NSString* url, GBError* error);

/*
 *  @brief 下载文件的的请求响应
 *  @param result 返回结果
 *  @param path 返回文件路径
 */
typedef void (^GBResponseFile)(NSInteger result, NSString* path, GBError* error);

/*
 *  @brief 上传下载进度响应
 *  @param progress 请求进度
 */
typedef void (^GBProgress)(double progress);



#endif /* GBResponse_h */
