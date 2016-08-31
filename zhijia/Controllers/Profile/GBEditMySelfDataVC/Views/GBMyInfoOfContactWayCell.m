//
//  GBMyInfoOfContactWayCell.m
//  zhijia
//
//  Created by 童星 on 16/3/29.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBMyInfoOfContactWayCell.h"

@interface GBMyInfoOfContactWayCell ()

@property (weak, nonatomic) IBOutlet UIButton *showMsgButton;

@end

@implementation GBMyInfoOfContactWayCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray *)titleArray withParentController:(id)parentController{
    
    switch (indexPath.row) {
            case 0:{
                _cellDetail.placeholder = @"输入邮箱";
            }
                 break;
            case 1:{
                
                _cellDetail.placeholder = @"输入手机号";
            }
                break;
            default:
                break;
        }
    
    _cellDetail.delegate = parentController;
    _cellTitle.text =  [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

}
- (IBAction)isShowContact:(UIButton *)sender {
    
    if ([[sender titleForState:(UIControlStateNormal)] isEqualToString:@"公开"]) {
        
        [sender setTitle:@"隐藏" forState:(UIControlStateNormal)];
        _cellDetail.secureTextEntry = YES;
    }else{
    
        [sender setTitle:@"公开" forState:(UIControlStateNormal)];
        _cellDetail.secureTextEntry = NO;

        
    }
}
@end
