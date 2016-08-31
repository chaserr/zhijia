//
//  LoginResponseModel.h
//  zhijia
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "Model.h"

@interface LoginResponseModel : Model
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *user_id;

@end
