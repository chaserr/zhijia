//
//  GBSignUpViewModel.m
//  zhijia
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBSignUpViewModel.h"
#import "UserCenter.h"

#pragma Mark -- Request

@implementation GBFetchVCodeRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/rgst_vcode";
    self.METHOD = @"POST";
}

@end

@implementation GBSignUpRequest

-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/users";
    self.METHOD = @"POST";
}

@end

#pragma Mark -- ViewModel

@implementation GBSignUpViewModel
-(void)loadSceneModel{
    [super loadSceneModel];
    //[self.action useCache];
//    self.response = nil;
//    self.dataArray = [NSMutableArray array];
//    @weakify(self);
//    _request = [LoginRequest RequestWithBlock:^{  // 初始化请求回调
//        @strongify(self)
//        [self SEND_IQ_ACTION:self.request];
//    }];
    @weakify(self);
    _fetchVcodeRequest = [GBFetchVCodeRequest RequestWithBlock:^{
        @strongify(self)
        [self SEND_IQ_ACTION:self.fetchVcodeRequest];
    }];
    
    _signUpRequest = [GBSignUpRequest RequestWithBlock:^{
        @strongify(self)
        [self SEND_IQ_ACTION:self.signUpRequest];
    }];
    

}

-(void)LoginIn:(gb_block_1)block
{
    NSError *error;
//    self.response = [[LoginResponseModel alloc] initWithDictionary:[self.signUpRequest.output objectForKey:@"data"] error:&error];//Model的ORM操作，dictionary to object
    
    [UserCenter sharedInstance].token = self.response.token;
    [UserCenter sharedInstance].userID = self.response.user_id;
    [UserCenter sharedInstance].cell = self.signUpRequest.cell;
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    APPLICATION.keyWindow.rootViewController = [mainSB instantiateInitialViewController];
    
    if(block){
        block();
    }
}
@end
