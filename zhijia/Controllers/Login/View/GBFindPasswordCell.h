//
//  GBFindPasswordCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/18.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBFindPasswordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *cellTextfieldClear;

@property (weak, nonatomic) IBOutlet UIImageView *cellLeftImage;

@property (weak, nonatomic) IBOutlet UITextField *cellLetftDetail;

@property (weak, nonatomic) IBOutlet UIButton *vertifyCodeBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)setCellContentWithIndexPath:(NSIndexPath *)indexPath;
@end
