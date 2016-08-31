//
//  GBPagination.h
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "Model.h"

@interface GBPaginationModel : Model

@property(nonatomic,assign)int page;
@property(nonatomic,assign)int page_size;
@property(nonatomic,assign)int total;
@property(nonatomic,assign)BOOL is_end;
@end
