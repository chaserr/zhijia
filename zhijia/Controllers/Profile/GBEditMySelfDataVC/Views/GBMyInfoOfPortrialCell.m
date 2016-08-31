//
//  GBMyInfoOfPortrialCell.m
//  zhijia
//
//  Created by 童星 on 16/3/29.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBMyInfoOfPortrialCell.h"

@implementation GBMyInfoOfPortrialCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


+ (instancetype)defaultCellWithFrame:(CGRect)frame{
    return [[GBMyInfoOfPortrialCell alloc]initWithFrame:frame];
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self = (GBMyInfoOfPortrialCell *)[[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] lastObject];
        
    }
    return self;
}

@end
