//
//  CDIMService.h
//  LeanChat
//
//  Created by lzw on 15/4/3.
//  Copyright (c) 2015年 LeanCloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CDIMService : NSObject

+ (instancetype)service;

- (void)goWithUserId:(NSString *)userId fromVC:(UIViewController *)vc;

@end
