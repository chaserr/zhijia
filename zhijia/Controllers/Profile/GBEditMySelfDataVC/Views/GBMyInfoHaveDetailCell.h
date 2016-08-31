//
//  GBMyInfoHaveDetailCell.h
//  zhijia
//
//  Created by 童星 on 16/3/29.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GBMyInfoHaveDetailCell;

@protocol GBMyInfoHaveDetailCellDelegate <NSObject>


@end

@interface GBMyInfoHaveDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *arrowImg;
@property (weak, nonatomic) IBOutlet UILabel *cellTitle;
@property (weak, nonatomic) IBOutlet UITextField *cellDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightMarginConsTocell;

//@property (weak, nonatomic) IBOutlet UILabel *cellDetail;
@property (nonatomic, assign) id<GBMyInfoHaveDetailCellDelegate> delegate;

+ (instancetype)defaultCellWithFrame:(CGRect)frame;

- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray*)titleArray withDetailString:(NSString *)detailString withParentController:(id)parentController;

@end

