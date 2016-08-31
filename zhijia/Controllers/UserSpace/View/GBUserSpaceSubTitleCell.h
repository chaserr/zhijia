//
//  GBUserSpaceSubTitleCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBUserSpaceSubTitleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UIView *cellContentView;
@property (weak, nonatomic) IBOutlet UIImageView *cellRightArrow;

- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray*)titleArray withParentController:(id)parentController;

@end
