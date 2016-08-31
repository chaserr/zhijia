//
//  GBSignUpViewModel.h
//  zhijia
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "ViewModel.h"
#import "LoginResponseModel.h"

@interface GBFetchVCodeRequest : Request

@property(nonatomic,copy)NSString *cell;


@end

@interface GBSignUpRequest : Request

@property(nonatomic,copy)NSString *cell;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,copy)NSString *vcode;
@property(nonatomic,assign)int sex;

@end

@interface GBSignUpViewModel : ViewModel

@property(nonatomic,strong)GBFetchVCodeRequest *fetchVcodeRequest;
@property(nonatomic,strong)GBSignUpRequest *signUpRequest;

@property(nonatomic,strong)LoginResponseModel *response;

-(void)LoginIn:(gb_block_1)block;

@end
