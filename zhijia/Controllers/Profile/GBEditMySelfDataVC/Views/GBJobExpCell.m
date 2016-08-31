//
//  GBJobExpCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/5.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBJobExpCell.h"

@implementation GBJobExpCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"JobExpCellID";
    GBJobExpCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    // 为了保证计算出来的数值 跟 真正显示出来的效果 一致
    self.jobContentDesLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 30;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setJobExp:(GBJobExp *)jobExp{

    _jobExp = jobExp;
    self.companyNameLabel.text = jobExp.companyName;
    self.departmentNameLabel.text = jobExp.departmentName;
    self.jobPositionLabel.text = jobExp.jobPosition;
    self.jobTimeLabel.text = jobExp.jobTime;
    self.jobContentDesLabel.text = jobExp.jobContentDes;
    
    [self layoutIfNeeded];
    jobExp.cellHeight = CGRectGetMaxY(self.jobContentDesLabel.frame) + 10;
    
}

@end
