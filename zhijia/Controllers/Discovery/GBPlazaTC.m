//
//  GBPlazaTC.m
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBPlazaTC.h"
#import "GBPlazaViewModel.h"
#import "GBPlazaTableViewCell.h"


@interface GBPlazaTC ()
@property(nonatomic,strong)GBPlazaViewModel *plazaViewModel;
@end

@implementation GBPlazaTC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.tableView setBackgroundColor:GBCommonColor];
    
    self.plazaViewModel = [GBPlazaViewModel ViewModel];
    
    //refreshlistener
    [self setupRefresh];
    
    //RAC
    [self setupRAC];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setupRefresh
{
    UIRefreshControl *refreshController = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:refreshController];
    
    [refreshController addTarget:self action:@selector(refreshControllStateChange:) forControlEvents:UIControlEventValueChanged];
    
    [refreshController beginRefreshing];
    
    [self refreshControllStateChange:refreshController];
}

-(void)setupRAC
{
//    @weakify(self);
//    [[RACObserve(self.plazaViewModel.response, posts)
//      filter:^BOOL(NSMutableArray<GBPostsModel>* value) {
//          return value.count > 0;
//      }]
//     subscribeNext:^(GBPlazaResponseModel *value) {
//         @strongify(self);
//         
//         NSLog(@"刷新!!!!");
//         
//         [self.tableView reloadData];
//     }];
}

#pragma mark - delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.plazaViewModel.response.posts.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBPostsModel *curPostData = [self.plazaViewModel.response.posts objectAtIndex:indexPath.row];
    return [GBPlazaTableViewCell calculateCellHeightWithPostsModel:curPostData];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"postsCell";
    GBPlazaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[GBPlazaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    GBPostsModel *curPostData = [self.plazaViewModel.response.posts objectAtIndex:indexPath.row];
    [cell setCurrentPostModel:curPostData];
    return cell;
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //cell.backgroundColor=[UIColor redColor];
}

#pragma mark - action
-(void)refreshControllStateChange:(UIRefreshControl *)refreshControl
{
//    [refreshControl endRefreshing];
//    
//    [self.tableView reloadData];
    [self performSelector:@selector(loadNewStatues:) withObject:refreshControl afterDelay:2.0f];
}

-(void)loadNewStatues:(UIRefreshControl *)refreshControl
{
    [refreshControl endRefreshing];
    
    [self.tableView reloadData];
}
@end
