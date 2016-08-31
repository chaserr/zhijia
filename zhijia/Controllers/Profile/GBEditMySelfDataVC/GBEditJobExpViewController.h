//
//  EditJobExpViewController.h
//  zhijia
//
//  Created by 张浩 on 16/5/4.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBTableViewController.h"
#import "GBTableViewControllers.h"
typedef void(^UpdateJobExp)(GBJobExp *jobExp);


@interface GBEditJobExpViewController : GBTableViewControllers

@property (nonatomic, strong) GBJobExp *jobExp;
@property (nonatomic, copy) UpdateJobExp updateJobExp;


@end
