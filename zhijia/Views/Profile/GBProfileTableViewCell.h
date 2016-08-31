//
//  GBProfileTableViewCell.h
//  zhijia
//
//  Created by 童星 on 16/3/16.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBProfileTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *cellImg;
@property (weak, nonatomic) IBOutlet UILabel *cellName;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

@end
