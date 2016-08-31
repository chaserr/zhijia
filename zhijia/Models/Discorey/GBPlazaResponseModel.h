//
//  GBPlazaResponse.h
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "Model.h"
#import "GBPaginationModel.h"
#import "GBPostsModel.h"


@interface GBPlazaResponseModel : Model
@property(nonatomic,strong)GBPaginationModel *pagination;
@property(nonatomic,strong)NSMutableArray<GBPostsModel> *posts;
@end
