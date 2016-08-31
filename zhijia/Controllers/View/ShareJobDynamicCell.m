//
//  ShareJobDynamicCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/8.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "ShareJobDynamicCell.h"

@interface ShareJobDynamicCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingConst;

@end
@implementation ShareJobDynamicCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withIdentifies:(NSString *)identify
{
    ShareJobDynamicCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setContentWithTableview:(UITableView *)tableview withIndexPath:(NSIndexPath *)indexPath withParentController:(id)parentController{
    
    if (indexPath.row == 0) {
        _cellImageView.image = [UIImage imageNamed:@"geographicPosition"];
        _shareQQBtn.hidden = YES;
        _shareWeiboBtn.hidden = YES;
        _shareWeixinBtn.hidden = YES;
    }else{
    
        _cellTtileLabel.text = @"同步分享";
        self.leadingConst.constant = 0;

    }
    
}

- (IBAction)shareSinaAction:(QCheckBox *)sender {
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        if (_delegate && [_delegate respondsToSelector:@selector(didClickShareButton:withType:)]) {
            [_delegate didClickShareButton:sender withType:(GBShareBtnWithSina)];
            }
    }
}

- (IBAction)shareQzoneAction:(QCheckBox *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        if (_delegate && [_delegate respondsToSelector:@selector(didClickShareButton:withType:)]) {
            [_delegate didClickShareButton:sender withType:(GBShareBtnWithQzone)];
        }
    }
}
- (IBAction)shareWeChatAction:(QCheckBox *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        if (_delegate && [_delegate respondsToSelector:@selector(didClickShareButton:withType:)]) {
            [_delegate didClickShareButton:sender withType:(GBShareBtnWithWechat)];
        }
    }
    
}


- (void)updateConstraints{

    [super updateConstraints];
    
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
