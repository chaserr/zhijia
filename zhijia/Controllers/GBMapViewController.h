//
//  GBMapViewController.h
//  zhijia
//
//  Created by 童星 on 16/6/8.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBViewController.h"

typedef void(^LocationBlock)(NSString *location);
@interface GBMapViewController : GBViewController

@property (nonatomic, copy) LocationBlock locationBlock;
@end
