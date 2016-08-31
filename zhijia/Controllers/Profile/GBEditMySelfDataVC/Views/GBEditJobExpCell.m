//
//  GBEditJobExpCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/4.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBEditJobExpCell.h"
#import "KMDatePicker.h"

@interface GBEditJobExpCell ()

@end

@implementation GBEditJobExpCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray*)titleArray{

    switch (indexPath.row) {
        case 0:
        {
        self.detailContent.placeholder = @"请输入公司名称";
        }
            break;
        case 1:
        {
            self.detailContent.placeholder = @"请输入所属部门";

            
        }
            break;
        case 2:
        {
            self.detailContent.placeholder = @"请输入职位名称";

            
        }
            break;
        case 3:
        {
            [self.arrowBtn setImage:[UIImage imageNamed:@"next"] forState:(UIControlStateNormal)];
            _detailContent.inputAccessoryView = [[UIView alloc] init];
;
//            self.detailContent.enabled = NO;

            
        }
            break;
            
            
        default:
            break;
    }
    
    self.titleLabel.text = [titleArray objectAtIndex:indexPath.row];
}


- (IBAction)clearText:(id)sender {
    
    _detailContent.text = nil;
}



@end
