//
//  GBJobExpCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/5.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBJobExpCell : UITableViewCell

/** 公司名称 */
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
/** 部门名称 */
@property (weak, nonatomic) IBOutlet UILabel *departmentNameLabel;
/** 职位名称 */
@property (weak, nonatomic) IBOutlet UILabel *jobPositionLabel;
/** 任职时间 */
@property (weak, nonatomic) IBOutlet UILabel *jobTimeLabel;
/** 工作内容描述 */
@property (weak, nonatomic) IBOutlet UILabel *jobContentDesLabel;

@property (assign, nonatomic) CGFloat cellHeight;

@property (nonatomic, strong) GBJobExp* jobExp;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
