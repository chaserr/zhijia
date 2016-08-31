//
//  GBUserSpaceFooterView.m
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBUserSpaceFooterView.h"

@implementation GBUserSpaceFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:@"GBUserSpaceFooterView" owner:self options:nil];
        
        _sapceFooterView.frame = frame;
        [self addSubview:_sapceFooterView];
        
    }
    return self;
}

+ (instancetype)defaultUserSpaceFooterView:(CGRect)frame{
    
    return  [[GBUserSpaceFooterView alloc] initWithFrame:frame];
}

@end
