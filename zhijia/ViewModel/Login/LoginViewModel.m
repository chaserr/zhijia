//
//  LoginViewModel.m
//  zhijia
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "LoginViewModel.h"
#import "UserCenter.h"

#pragma Mark -- Request

@implementation LoginRequest
-(void)loadRequest{
    [super loadRequest];
    self.PATH = @"/login";
    self.METHOD = @"POST";
}

@end

#pragma Mark -- ViewModel

@implementation LoginViewModel
-(void)loadSceneModel{
    [super loadSceneModel];
    //[self.action useCache];
    self.response = nil;
    self.dataArray = [NSMutableArray array];
    @weakify(self);
    _request = [LoginRequest RequestWithBlock:^{  // 初始化请求回调
        @strongify(self)
        [self SEND_IQ_ACTION:self.request];
    }];
    
    /*
    [[RACObserve(self.request, state) //监控 网络请求的状态
      filter:^BOOL(NSNumber *state) { //过滤请求状态
          @strongify(self);
          return self.request.succeed;
      }]
     subscribeNext:^(NSNumber *state) {
         @strongify(self);
         NSError *error;
         self.response = [[LoginResponseModel alloc] initWithDictionary:[self.request.output objectForKey:@"data"] error:&error];//Model的ORM操作，dictionary to object
         
         [UserCenter sharedInstance].token = self.response.token;
         [UserCenter sharedInstance].userID = self.response.user_id;
         [UserCenter sharedInstance].cell = self.request.cell;
         
         UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
         APPLICATION.keyWindow.rootViewController = [mainSB instantiateInitialViewController];
        
     }];
     */
}
-(void)LoginIn:(gb_block_1)block
{
    NSError *error;
//    self.response = [[LoginResponseModel alloc] initWithDictionary:[self.request.output objectForKey:@"data"] error:&error];//Model的ORM操作，dictionary to object
    
    [UserCenter sharedInstance].token = self.response.token;
    [UserCenter sharedInstance].userID = self.response.user_id;
    [UserCenter sharedInstance].cell = self.request.cell;
    
    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    APPLICATION.keyWindow.rootViewController = [mainSB instantiateInitialViewController];
    
    if(block){
       block();
    }
}
@end
