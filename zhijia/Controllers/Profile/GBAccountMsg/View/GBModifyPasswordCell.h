//
//  GBModifyPasswordCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/6.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBModifyPasswordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *vertifyView;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UITextField *cellContent;
@property (weak, nonatomic) IBOutlet UIButton *verifyCodeBtn;
@property (weak, nonatomic) IBOutlet UILabel *verifyCodeLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView withIdentifierStr:(NSString *)identifierStr;

- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withDetailString:(NSString *)detailString withParentController:(id)parentController;


@end
