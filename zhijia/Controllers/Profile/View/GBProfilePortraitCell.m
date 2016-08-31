//
//  GBProfilePortraitCell.m
//  zhijia
//
//  Created by 童星 on 16/6/6.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBProfilePortraitCell.h"

@implementation GBProfilePortraitCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"GBProfilePortraitCell";
    GBProfilePortraitCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}






- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
