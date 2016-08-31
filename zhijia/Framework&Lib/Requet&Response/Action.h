//
//  Action.h
//  zhijia
//
//  Created by TANHUAZHE on 7/17/15.
//  Copyright (c) 2015 Hahu. All rights reserved.
//
#import "SingletonHelper.h"
#import "Request.h"
#import "ActionDelegate.h"

@interface Action : NSObject
@property(nonatomic,weak)id<ActionDelegate> aDelegaete;
+(void)actionConfigHost:(NSString *)host client:(NSString *)client codeKey:(NSString *)codeKey rightCode:(NSInteger)rightCode msgKey:(NSString *)msgKey;
+ (id)Action;
- (id)initWithCache;
- (void)success:(Request *)msg;
- (void)error:(Request *)msg;
- (void)failed:(Request *)msg;
- (void)useCache;
- (void)readFromCache;
- (void)notReadFromCache;
//- (AFHTTPRequestOperation *)Send:(Request *) msg;
//- (AFHTTPRequestOperation *)Download:(Request *)msg;
AS_SINGLETON(Action)
@end