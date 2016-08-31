//
//  GBFindPasswordCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/18.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBFindPasswordCell.h"

@interface GBFindPasswordCell ()
@property (nonatomic, strong) NSMutableArray *cellLeftImageArray;
@property (nonatomic, strong) NSMutableArray *cellLeftHighLightImageArray;


@end

@implementation GBFindPasswordCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"JobExpCellID";
    GBFindPasswordCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
        
        
    }
    return cell;
}

- (void)setCellContentWithIndexPath:(NSIndexPath *)indexPath{

    _cellLeftImage.image = [UIImage imageNamed:self.cellLeftImageArray[indexPath.row]];
    _cellLeftImage.highlightedImage = [UIImage imageNamed:self.cellLeftHighLightImageArray[indexPath.row]];
    switch (indexPath.row) {
        case 1:
            _vertifyCodeBtn.hidden = NO;

            break;
        case 2:
            _cellLetftDetail.secureTextEntry = YES;
            
            break;
        case 3:
            _cellLetftDetail.secureTextEntry = YES;
            
            break;
            
        default:
            break;
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

// 懒加载
- (NSMutableArray *)cellLeftImageArray{
    
    if (!_cellLeftImageArray) {
        _cellLeftImageArray = [NSMutableArray arrayWithObjects:@"findPassword_iPhone_icon", @"findPassword_checkCode_icon", @"findPassword_password_icon", @"findPassword_password_icon", nil];
    }
    return _cellLeftImageArray;
}

// 懒加载
- (NSMutableArray *)cellLeftHighLightImageArray{
    
    if (!_cellLeftHighLightImageArray) {
        _cellLeftHighLightImageArray = [NSMutableArray arrayWithObjects:@"findPassword_iPhone_icon_highlight", @"findPassword_checkCode_icon_highlight", @"findPassword_password_icon_highlight", @"findPassword_password_icon_highlight",  nil];
    }
    return _cellLeftHighLightImageArray;
}









@end
