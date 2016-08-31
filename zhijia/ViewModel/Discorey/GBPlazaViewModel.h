//
//  GBPlazaViewModel.h
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "ViewModel.h"
#import "GBPlazaRequest.h"
#import "GBPlazaResponseModel.h"

@interface GBPlazaViewModel : ViewModel
@property(nonatomic,retain)GBPlazaRequest *request;
@property(nonatomic,retain)GBPlazaResponseModel *response;
@end
