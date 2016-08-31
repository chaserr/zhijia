//
//  GBError.h
//  zhijia
//
//  Created by 童星 on 16/5/23.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GBError : NSError


/**
 * @brief 构造Error
 *
 * @param error NSError 对象
 * @return 返回错误对象.
 */
+ (GBError*)errorWithNSError:(NSError*)error;

/**
 * @brief 构造Error
 *
 * @param code 错误代码
 * @param errorMessage 错误信息
 *
 * @return 返回错误对象.
 */
+ (GBError*)errorWithCode:(NSInteger)code errorMessage:(NSString*)errorMsg;

/**
 * @brief 返回相关错误码
 * @return 错误码
 */
- (NSInteger)errorCode;

/**
 * @brief 错误信息
 * @return 错误信息
 */
- (NSString*)errorMsg;
@end
