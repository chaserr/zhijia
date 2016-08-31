//
//  GBUserSpaceHeadView.h
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBImageView.h"
@interface GBUserSpaceHeadView : UIView

@property (strong, nonatomic) IBOutlet UIView *GBUserSpaceHeaderView;
/** 背景图片 */
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
/** 用户图像 */
@property (weak, nonatomic) IBOutlet GBImageView *userProtrial;
/** 用户昵称 */
@property (weak, nonatomic) IBOutlet UILabel *userNIckname;
/** 用户工作 */
@property (weak, nonatomic) IBOutlet UIButton *userJob;
/** age */
@property (weak, nonatomic) IBOutlet UIButton *userAge;
/** 工作年限 */
@property (weak, nonatomic) IBOutlet UILabel *userJobAge;
/** 所在地 */
@property (weak, nonatomic) IBOutlet UILabel *userLocation;
/** 获得花数 */
@property (weak, nonatomic) IBOutlet UILabel *userFlowerCount;
/** 送花 */
@property (weak, nonatomic) IBOutlet UILabel *sendFlower;

+ (instancetype)defaultUserSpaceHeaderView:(CGRect)frame;

@end
