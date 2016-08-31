//
//  GBRecommendCell.h
//  zhijia
//
//  Created by 童星 on 16/5/25.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBRecommendBaseCell.h"

typedef void(^AddFlowerCountBlock)(NSIndexPath *indexPath);

@protocol GBRecommendCellDelegate <NSObject>

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;
- (void)didClickShareButtonInCell:(UITableViewCell *)cell;
- (void)didClickFlowerButtonInCell:(UITableViewCell *)cell;

@end

@class GBRecommendCellModel;
@interface GBRecommendCell : GBRecommendBaseCell

@property (nonatomic, strong) UIImageView *flowerCountView;

@property (nonatomic, weak) id<GBRecommendCellDelegate> delegate;

@property (nonatomic, strong) GBRecommendCellModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) AddFlowerCountBlock addFlowerCountBlock;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@end
