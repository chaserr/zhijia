//
//  GBRegisteNextStepCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/19.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCheckBox.h"

@interface GBRegisteNextStepCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *cellTitle;

//@property (weak, nonatomic) IBOutlet UIButton *cellRightDetail;

@property (weak, nonatomic) IBOutlet QCheckBox *cellRightDetail;
@property (weak, nonatomic) IBOutlet UIImageView *cellRightArrow;
@property (nonatomic, copy) void (^onTap)(GBRegisteNextStepCell *);

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setCellContentWithIndexPath:(NSIndexPath *)indexPath;

@end
