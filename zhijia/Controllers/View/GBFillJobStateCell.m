//
//  GBFillJobStateCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/7.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//



#import "GBFillJobStateCell.h"

@interface GBFillJobStateCell ()

@end

@implementation GBFillJobStateCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withIdentifies:(NSString *)identify
{
    GBFillJobStateCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];

    if (cell == nil) {

        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setContentWithTableview:(UITableView *)tableview withIndexPath:(NSIndexPath *)indexPath withParentController:(id)parentController{
    
    _fillJobStatetextView.delegate = parentController;

}

// 懒加载

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _fillJobStatetextView.textContainerInset = UIEdgeInsetsMake(CGRectGetHeight(_fillJobStatetextView.frame) * 0.5 +8, 0, 0, 0);

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
