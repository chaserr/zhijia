//
//  GBMediumViewController.h
//  zhijia
//
//  Created by 张浩 on 16/5/16.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBViewController.h"

typedef void(^MediumDataBlock)(NSData *data, NSURL *vedioUrl);

@interface GBMediumViewController : GBViewController

@property (nonatomic, copy) MediumDataBlock mediumDataBlock;

@end
