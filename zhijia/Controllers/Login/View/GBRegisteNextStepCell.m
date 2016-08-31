//
//  GBRegisteNextStepCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/19.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBRegisteNextStepCell.h"
@interface GBRegisteNextStepCell ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightConstraint;

@end

@implementation GBRegisteNextStepCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"JobExpCellID";
    GBRegisteNextStepCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
    }
    return cell;
}

- (void)setCellContentWithIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
        {
            [_cellRightDetail setTitle:@"请填写真实姓名" forState:(UIControlStateNormal)];
            [_cellRightDetail setTitleColor:[UIColor colorWithWhite:0.666 alpha:1.000] forState:(UIControlStateNormal)];
            _cellRightArrow.hidden = YES;
            [self updateConstraintsIfNeeded];
        }
            break;
        case 1:
        {
            [_cellRightDetail setChecked:YES];
            [_cellRightDetail setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.285 green:0.501 blue:0.722 alpha:1.000]] forState:(UIControlStateSelected)];
            [_cellRightDetail setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.871 green:0.457 blue:0.774 alpha:1.000]] forState:(UIControlStateNormal)];
            [_cellRightDetail setTitle:@"女" forState:(UIControlStateNormal)];
            [_cellRightDetail setTitle:@"男" forState:(UIControlStateSelected)];

            [_cellRightDetail setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
            [_cellRightDetail setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            _cellRightArrow.hidden = YES;
            [self updateConstraintsIfNeeded];

        }
            break;
        case 2:
        {
            [_cellRightDetail setTitle:@"1990-08-09" forState:(UIControlStateNormal)];

        }
            break;
        case 3:
        {
            [_cellRightDetail setTitle:@"请选择" forState:(UIControlStateNormal)];
            [_cellRightDetail setTitleColor:[UIColor colorWithWhite:0.666 alpha:1.000] forState:(UIControlStateNormal)];

        }
            break;
        default:
            break;
    }
}


- (void)updateConstraints{

    [super updateConstraints];
    if (_cellRightArrow.hidden) {

        self.rightConstraint.constant = 18;
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [_cellRightDetail addTarget:self action:@selector(onTapAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

- (void)onTapAction:(id)sender{

    if (self.onTap) {
        self.onTap(self);
    }

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
