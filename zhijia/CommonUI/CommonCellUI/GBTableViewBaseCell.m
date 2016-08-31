//
//  GBTableViewBaseCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBTableViewBaseCell.h"

@implementation GBTableViewBaseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray*)titleArray withParentController:(id)parentController{
    
//    switch (indexPath.row) {
//        case <#constant#>:
//            <#statements#>
//            break;
//            
//        default:
//            break;
//    }
}


@end
