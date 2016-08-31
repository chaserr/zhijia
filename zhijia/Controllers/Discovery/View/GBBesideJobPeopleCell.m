//
//  GBBesideJobPeopleCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/10.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBBesideJobPeopleCell.h"
#import "GBUserPotrialScrollerView.h"

@interface GBBesideJobPeopleCell ()
@property (nonatomic, strong) NSArray *photoArray;

@property (nonatomic, strong) GBUserPotrialScrollerView *portrialView;

@end

@implementation GBBesideJobPeopleCell


- (void)setContentWithTableview:(UITableView *)tableview withIndexPath:(NSIndexPath *)indexPath withParentController:(id)parentController{

    if (indexPath.section == 0) {
        
        _cellContent.hidden = NO;
        _cellRightArrow.hidden = NO;
        [self createDynamicPhotoWithArray:self.photoArray];

    }
}

- (void)createDynamicPhotoWithArray:(NSArray *)photoArray{
    
    [self layoutIfNeeded];
    self.portrialView = [[GBUserPotrialScrollerView alloc] initWithFrame:CGRectMake(0, 0, self.cellContent.width, self.cellContent.height) withImageArray:photoArray];
    _portrialView.minimumLineSpacing = 10.0f;
    _portrialView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _portrialView.itemSize = CGSizeMake(self.cellContent.height, self.cellContent.height);
    _portrialView.isOpenUserSpace = YES;
    [self.cellContent addSubview:_portrialView];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// 懒加载
- (NSArray *)photoArray{
    
    if (!_photoArray) {
        _photoArray = [NSArray arrayWithObjects:@"testPhoto", @"testPhoto", @"testPhoto",@"testPhoto",@"testPhoto",@"testPhoto",@"testPhoto",@"testPhoto",@"testPhoto",@"testPhoto", nil];
    }
    return _photoArray;
}
@end
