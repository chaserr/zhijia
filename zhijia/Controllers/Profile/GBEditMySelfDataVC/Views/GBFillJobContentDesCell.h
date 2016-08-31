//
//  GBFillJobContentDesCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/4.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBFillJobContentDesCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *placeholdLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentDesc;

- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray*)titleArray;

@end
