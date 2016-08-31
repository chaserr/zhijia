//
//  GBTableViewControllers.m
//  zhijia
//
//  Created by 张浩 on 16/5/5.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBTableViewControllers.h"

@implementation GBTableViewControllers


- (id) init
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (id) initWithStyle:(UITableViewStyle) style
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _tableViewStyle = style;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    CGRect bounds = self.view.bounds;
    CGRect tableRect;
    
    UIViewController* viewController = self.parentViewController;
    if (viewController && [viewController isKindOfClass:[UINavigationController class]])
    {
        tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height);
    }
    else
    {
        tableRect = CGRectMake(0, 0, bounds.size.width, bounds.size.height/* - PHONE_NAVIGATIONBAR_HEIGHT - PHONE_STATUSBAR_HEIGHT*/);
    }
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:tableRect style:_tableViewStyle];
    self.tableView = tableView;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.allowsSelection = YES;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    
    CGRect tableHeaderRect = CGRectMake(0, 64, CGRectGetWidth(self.tableView.bounds), 0.01);
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:tableHeaderRect];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
//    self.tableView.mj_header = [YYCustomFreshHeadView headerWithRefreshingTarget:self refreshingAction:@selector(pullToRefreshTriggered)];
    
//    [self.tableView.mj_header beginRefreshing];
    
//    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullToLoadMoreTriggered)];
}

- (void)viewDidLoad{

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (self.tableView != nil)
    {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [self.tableView setEditing:NO animated:animated];
}

- (void)reloadData
{
    [self.tableView reloadData];
}

#pragma mark 下拉刷新通知
- (void)pullToRefreshTriggered{
    DLog(@"pullToRefreshTriggered");
}
#pragma mark 上拉加载更多通知
- (void)pullToLoadMoreTriggered{
    DLog(@"pullToLoadMoreTriggered");
}
#pragma mark 下拉刷新结束
- (void)pullToRefreshFinished{
//    [_tableView.mj_header endRefreshing];
}
#pragma mark 上拉加载更多结束
- (void)pullToLoadMoreFinished{
//    [_tableView.mj_footer endRefreshing];
}

#pragma mark TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return  0.01;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleNone;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    return nil;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    return indexPath;
}
@end
