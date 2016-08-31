//
//  GBCore.h
//  zhijia
//
//  Created by 童星 on 16/5/24.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#define GB_CORE [GBCore getInstance]


#import <Foundation/Foundation.h>
#import "GBUserServices.h"
// 模型类
#import "GBJobExp.h"
@interface GBCore : NSObject

@property (nonatomic, strong, readonly) GBUserServices *userService;

+ (GBCore*)getInstance;


@end
