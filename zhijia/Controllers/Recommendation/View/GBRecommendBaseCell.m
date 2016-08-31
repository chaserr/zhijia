//
//  GBRecommendBaseCell.m
//  zhijia
//
//  Created by 童星 on 16/5/25.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBRecommendBaseCell.h"

@implementation GBRecommendBaseCell

// 获取数据类型对应的cell
//+(NSString *)cellIdentifierForRow:(GBRecommendCellModel *)recommendCellModel{
//    
//    if (recommendCellModel.hasHead){
//        return @"ThreeFourthCell";
//    }else if (recommendCellModel.imgType){
//        return @"ThreeThirdCell";
//    }else if (recommendCellModel.imgextra){
//        return @"ThreeSecondCell";
//    }else{
//        return @"ThreeFirstCell";
//    }
//
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
