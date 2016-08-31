//
//  AuthCenter.m
//  zhijia
//
//  Created by TANHUAZHE on 7/18/15.
//  Copyright (c) 2015 Hahu. All rights reserved.
//

#import "UserCenter.h"
#import "GBUser.h"

@implementation UserCenter
DEF_SINGLETON(UserCenter)

-(instancetype)init{
    self = [super init];
    if(self){
        self.token = [[NSUserDefaults standardUserDefaults] objectForKey:tokenKey];
        self.userID = [[NSUserDefaults standardUserDefaults] objectForKey:userIdKey];
        self.cell = [[NSUserDefaults standardUserDefaults] objectForKey:cellKey];
        [self LoadUser];
        
        self.dataSource = [[NSMutableArray alloc] init];
        
        GBUser *user1 = [[GBUser alloc] init];
        user1.userId = @"b7e5f0dcd20385de854170dd99ea09d02a90b8b3";
        user1.username = @"刘德华";
        user1.avatarUrl = @"";
        user1.cell = @"75493212135";
        
        
        GBUser *user2 = [[GBUser alloc] init];
        user2.userId = @"39f9425650e0c32e8c4fdddeb309626fdcf3074a";
        user2.username = @"梁朝伟";
        user2.avatarUrl = @"";
        user2.cell = @"50486798723";
        
        GBUser *user3 = [[GBUser alloc] init];
        user3.userId = @"dab86c3feaebafd68f8e7cc92d47cc712c10b646";
        user3.username = @"李四";
        user3.avatarUrl = @"";
        user3.cell = @"69077380798";
        
        GBUser *user4 = [[GBUser alloc] init];
        user4.userId = @"afce90c1321634c37e9d99806301c672deda8989";
        user4.username = @"张三";
        user4.avatarUrl = @"";
        user4.cell = @"61396405258";
        
        [self.dataSource addObject:user1];
        [self.dataSource addObject:user2];
        [self.dataSource addObject:user3];
        [self.dataSource addObject:user4];
        
    }
    return self;
}
-(void)LoadUser
{
    [RACObserve(self, token) subscribeNext:^(NSString *value) {
        if (value.isNotEmpty) {
            [[NSUserDefaults standardUserDefaults] setObject:value forKey:tokenKey];
        }else{
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:tokenKey];
        }
        
    }];
    
    [RACObserve(self, userID) subscribeNext:^(NSString *value) {
        if (value.isNotEmpty) {
            [[NSUserDefaults standardUserDefaults] setObject:value forKey:userIdKey];
        }else{
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:userIdKey];
        }
        
    }];
    
    [RACObserve(self, cell) subscribeNext:^(NSString *value) {
        if (value.isNotEmpty) {
            [[NSUserDefaults standardUserDefaults] setObject:value forKey:cellKey];
        }else{
            [[NSUserDefaults standardUserDefaults] removeObjectForKey:cellKey];
        }
    }];
}
-(BOOL)currentUser
{
    if (self.token.isNotEmpty && self.userID.isNotEmpty) {
        return YES;
    }
    return NO;
}
-(void)clearUser
{
    self.token = nil;
    self.userID = nil;
}
-(void)clearAccount
{
    self.cell = nil;
}

-(NSString *)getUserNameById:(NSString *)userId
{
    for (GBUser *user in self.dataSource) {
        if ([user.userId isEqualToString:userId]) {
            return user.username;
        }
    }
    return @"匿名";
}
-(NSString *)getProfileName
{
    for (GBUser *user in self.dataSource) {
        if ([user.userId isEqualToString:self.userID]) {
            return user.username;
        }
    }
    return @"匿名";
}
-(GBUser *)getUserById:(NSString *)userId
{
    for (GBUser *user in self.dataSource) {
        if ([user.userId isEqualToString:userId]) {
            return user;
        }
    }
    return nil;
}
@end
