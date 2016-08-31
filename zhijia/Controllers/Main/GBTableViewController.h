//
//  GBTableViewController.h
//  zhijia
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBViewController.h"

@protocol GBSegmentControllerDelegate <NSObject>

-(UIScrollView *)streachScrollView;

@end

@interface GBTableViewController : UITableViewController<GBSegmentControllerDelegate,BaseVCDelegate>

@property (nonatomic, assign) UITableViewStyle tableViewStyle;


//@property (nonatomic,strong) UITableView *tableView;
//
//@property (nonatomic,strong) UIRefreshControl *refreshControl;

- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)setRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

@end
