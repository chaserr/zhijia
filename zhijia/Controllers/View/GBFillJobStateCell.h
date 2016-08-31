//
//  GBFillJobStateCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/7.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GBFillJobStateCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextView *fillJobStatetextView;
@property (weak, nonatomic) IBOutlet UILabel *placeholdText;

+ (instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withIdentifies:(NSString *)identify;

- (void)setContentWithTableview:(UITableView *)tableview withIndexPath:(NSIndexPath *)indexPath withParentController:(id)parentController;
@end
