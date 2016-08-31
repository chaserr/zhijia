//
//  ShareJobDynamicCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/8.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"

@protocol ShareJobDynamicCellDelegate <NSObject>

- (void)didClickShareButton:(QCheckBox *)sender withType:(GBShareBtnWithType)shareBtnWithType;

@end

@interface ShareJobDynamicCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTtileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageView;
@property (weak, nonatomic) IBOutlet QCheckBox *shareWeiboBtn;
@property (weak, nonatomic) IBOutlet QCheckBox *shareQQBtn;
@property (weak, nonatomic) IBOutlet QCheckBox *shareWeixinBtn;
@property (nonatomic, assign) id<ShareJobDynamicCellDelegate> delegate;
@property (nonatomic, assign) GBShareBtnWithType shareBtnWithType;
+ (instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withIdentifies:(NSString *)identify;

- (void)setContentWithTableview:(UITableView *)tableview withIndexPath:(NSIndexPath *)indexPath withParentController:(id)parentController;
@end
