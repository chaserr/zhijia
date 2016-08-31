//
//  GBModifyPasswordCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/6.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBModifyPasswordCell.h"

@implementation GBModifyPasswordCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifierStr:(NSString *)identifierStr
{
    GBModifyPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifierStr];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withDetailString:(NSString *)detailString withParentController:(id)parentController{

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
            
                self.cellTitle.text = @"手机号";
                self.cellContent.placeholder = @"请输入手机号";
            }
                break;
            case 1:
            {
                self.cellTitle.text = @"验证码";
                self.cellContent.placeholder = @"请输入验证码";
                self.vertifyView.hidden = NO;
            }
                break;
                
            default:
                break;
        }
    }else{
    
        self.cellTitle.text = @"输入新密码";
        self.cellContent.placeholder = @"请输入新密码";
    }
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
