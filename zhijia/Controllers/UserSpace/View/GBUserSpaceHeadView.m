//
//  GBUserSpaceHeadView.m
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBUserSpaceHeadView.h"

@implementation GBUserSpaceHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"GBUserSpaceHeadView" owner:self options:nil];
        
        _GBUserSpaceHeaderView.frame = frame;
        [self addSubview:_GBUserSpaceHeaderView];
        
    }
    return self;
}

+ (instancetype)defaultUserSpaceHeaderView:(CGRect)frame{
    
    return  [[GBUserSpaceHeadView alloc] initWithFrame:frame];
}


@end
