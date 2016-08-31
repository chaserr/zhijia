//
//  GBUserSpaceFooterView.h
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBImageView.h"
@interface GBUserSpaceFooterView : UIView

@property (strong, nonatomic) IBOutlet UIView *sapceFooterView;

@property (weak, nonatomic) IBOutlet GBImageView *userPortrial;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *userJobDescription;
@property (weak, nonatomic) IBOutlet UIButton *HiUserButton;
@property (weak, nonatomic) IBOutlet UIButton *addFriendsBtn;

+ (instancetype)defaultUserSpaceFooterView:(CGRect)frame;


@end
