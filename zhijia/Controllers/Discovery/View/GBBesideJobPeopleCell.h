//
//  GBBesideJobPeopleCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/10.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBBesideJobPeopleCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIView *cellContent;
@property (weak, nonatomic) IBOutlet UIImageView *cellRightArrow;

- (void)setContentWithTableview:(UITableView *)tableview withIndexPath:(NSIndexPath *)indexPath withParentController:(id)parentController;

@end
