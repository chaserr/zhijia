//
//  GBDiscoverBesideCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/11.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBImageView.h"
@interface GBDiscoverBesideCell : UITableViewCell
/** 用户图像 */
@property (weak, nonatomic) IBOutlet GBImageView *UserProtrial;
/** 用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *userName;

@property (weak, nonatomic) IBOutlet UILabel *userLocation;
@property (weak, nonatomic) IBOutlet UILabel *userDistance;
@property (weak, nonatomic) IBOutlet UIView *userAgeBackView;
@property (weak, nonatomic) IBOutlet UIButton *userAge;
@property (weak, nonatomic) IBOutlet UILabel *userJobAge;
@property (weak, nonatomic) IBOutlet UILabel *userExpDescribe;
@property (weak, nonatomic) IBOutlet UILabel *userJobCircle;

@end
