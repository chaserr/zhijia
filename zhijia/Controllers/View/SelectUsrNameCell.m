//
//  SelectUsrNameCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/8.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "SelectUsrNameCell.h"

@interface SelectUsrNameCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *seperatorLeadingConst;

@end

@implementation SelectUsrNameCell


+ (instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withIdentifies:(NSString *)identify
{
    SelectUsrNameCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setContentWithTableview:(UITableView *)tableview withIndexPath:(NSIndexPath *)indexPath withParentController:(id)parentController{
    
    if (indexPath.row == 0) {
        _cellTtitle.text = @"使用真名";
//        [self setSelected:YES];
    }else{
        
        _cellTtitle.text = @"使用匿名";
        self.seperatorLeadingConst.constant = 0;
    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];


}

@end
