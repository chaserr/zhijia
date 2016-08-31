//
//  GBProfilePortraitCell.h
//  zhijia
//
//  Created by 童星 on 16/6/6.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBProfilePortraitCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *userPortrait;

@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *jobPosition;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
