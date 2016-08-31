//
//  GBMyInfoOfContactWayCell.h
//  zhijia
//
//  Created by 童星 on 16/3/29.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBMyInfoOfContactWayCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITextField *cellDetail;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
//@property (weak, nonatomic) IBOutlet UILabel *cellDetail;


- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray*)titleArray withParentController:(id)parentController;

@end
