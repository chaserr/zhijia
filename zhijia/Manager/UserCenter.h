//
//  AuthCenter.h
//  zhijia
//
//  Created by TANHUAZHE on 7/18/15.
//  Copyright (c) 2015 Hahu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonHelper.h"

@class GBUser;

static NSString *tokenKey=@"token_key";
static NSString *userIdKey=@"userId_key";
static NSString *cellKey=@"cell_key";

@interface UserCenter : NSObject
AS_SINGLETON(UserCenter)
@property(nonatomic,retain)NSString *token;
@property(nonatomic,retain)NSString *userID;
@property(nonatomic,retain)NSString *cell;

//作假
@property(nonatomic,strong)NSMutableArray *dataSource;

-(BOOL)currentUser;
-(void)clearUser;
-(void)clearAccount;
-(NSString *)getUserNameById:(NSString *)userId;
-(NSString *)getProfileName;
-(GBUser *)getUserById:(NSString *)userId;
@end
