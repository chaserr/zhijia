//
//  LoginViewModel.h
//  zhijia
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "ViewModel.h"
#import "LoginResponseModel.h"

@interface LoginRequest : Request
@property(nonatomic,retain)NSString *cell;
@property(nonatomic,retain)NSString *password;

@end

@interface LoginViewModel : ViewModel
@property(nonatomic,retain)LoginResponseModel *response;
@property(nonatomic,retain)LoginRequest *request;
@property(nonatomic,retain)NSMutableArray *dataArray;

-(void)LoginIn:(gb_block_1)block;
@end
