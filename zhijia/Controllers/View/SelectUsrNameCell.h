//
//  SelectUsrNameCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/8.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectUsrNameCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTtitle;
@property (weak, nonatomic) IBOutlet UIImageView *markImage;

+ (instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withIdentifies:(NSString *)identify;

- (void)setContentWithTableview:(UITableView *)tableview withIndexPath:(NSIndexPath *)indexPath withParentController:(id)parentController;
@end
