//
//  CDIMService.m
//  LeanChat
//
//  Created by lzw on 15/4/3.
//  Copyright (c) 2015年 LeanCloud. All rights reserved.
//

#import "CDIMService.h"
#import "GBChatVC.h"
#import "GBUser.h"
#import "UserCenter.h"

@interface CDIMService ()

@end

@implementation CDIMService

+ (instancetype)service {
    static CDIMService *imService;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imService = [[CDIMService alloc] init];
    });
    return imService;
}

#pragma mark - user delegate

//- (void)cacheUserByIds:(NSSet *)userIds block:(AVBooleanResultBlock)block {
//    //[[CDCacheManager manager] cacheUsersWithIds:userIds callback:block];
//    block(YES,nil);
//}

//- (id <CDUserModel> )getUserById:(NSString *)userId {
//    GBUser *user = [[GBUser alloc] init];
//    GBUser *findUser = [[UserCenter sharedInstance] getUserById:userId];
//    
//    if (!findUser) {
//        user.userId = @"123456";
//        user.username = @"匿名用户";
//        user.avatarUrl = @"";
//        return user;
//    }
//    
//    user.userId = findUser.userId;
//    user.username = findUser.username;
//    user.avatarUrl = findUser.avatarUrl;
//    return user;
//}

//- (void)goWithConv:(AVIMConversation *)conv fromNav:(UINavigationController *)nav {
//    GBChatVC *chatVC = [[GBChatVC alloc] initWithConv:conv];
//    [nav pushViewController:chatVC animated:YES];
//}

//- (void)goWithUserId:(NSString *)userId fromVC:(UIViewController<BaseVCDelegate> *)vc {
//    [[CDChatManager manager] fetchConvWithOtherId:userId callback: ^(AVIMConversation *conversation, NSError *error) {
//        if ([self filterError:error withViewController:vc]) {
//            [self goWithConv:conversation fromNav:vc.navigationController];
//        }
//    }];
//}

//- (BOOL)alertError:(NSError *)error withVC:(UIViewController<BaseVCDelegate> *)viewController{
//    if (error) {
//        if ([viewController respondsToSelector:@selector(alert:)]) {
//            if (error.code == kAVIMErrorConnectionLost) {
//                [viewController alert:@"未能连接聊天服务"];
//            }
//            else if ([error.domain isEqualToString:NSURLErrorDomain]) {
//                [viewController alert:@"网络连接发生错误"];
//            }
//            else {
//#ifndef DEBUG
//                [viewController alert:[NSString stringWithFormat:@"%@", error]];
//#else
//                NSString *info = error.localizedDescription;
//                [viewController alert:info ? info : [NSString stringWithFormat:@"%@", error]];
//#endif
//            }
//        }
//        return YES;
//    }
//    return NO;
//}

//- (BOOL)filterError:(NSError *)error withViewController:(UIViewController<BaseVCDelegate> *)viewController{
//    return [self alertError:error withVC:viewController] == NO;
//}

@end
