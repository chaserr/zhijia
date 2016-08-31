//
//  GBTableViewControllers.h
//  zhijia
//
//  Created by 张浩 on 16/5/5.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBViewController.h"

@interface GBTableViewControllers : GBViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView * tableView;
@property (nonatomic, readonly) UITableViewStyle tableViewStyle;

- (void)pullToRefreshTriggered;


- (void)pullToLoadMoreTriggered;

// 下拉刷新结束
- (void)pullToRefreshFinished;

- (void)pullToLoadMoreFinished;

- (id)initWithStyle:(UITableViewStyle)style;
// 重新加载数据
- (void)reloadData;

@end
