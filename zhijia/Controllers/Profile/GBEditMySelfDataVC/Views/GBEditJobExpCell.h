//
//  GBEditJobExpCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/4.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBEditJobExpCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UITextField *detailContent;
@property (weak, nonatomic) IBOutlet UIButton *arrowBtn;
@property (nonatomic, strong) UITextField *txtFCurrent;

- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray*)titleArray;

@end
