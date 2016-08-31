//
//  GBDiscoverBesidePeopleVC.m
//  zhijia
//
//  Created by 张浩 on 16/5/11.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

static NSString * const BesideCellID = @"besideCell";
#import "GBDiscoverBesidePeopleVC.h"
#import "GBDiscoverBesideCell.h"
#import "GBSystemSearchController.h"
#import "CYLSearchMainViewController.h"
@interface GBDiscoverBesidePeopleVC ()

@end

@implementation GBDiscoverBesidePeopleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customlizeNavigationBarBackBtn];
    self.navigationTitleLabel.text = @"发现身边";
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"筛选" style:UIBarButtonItemStylePlain target:self action:@selector(filterPeople)];
        rightItem;
    });
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"GBDiscoverBesideCell" bundle:nil] forCellReuseIdentifier:BesideCellID];
}

#pragma mark -- UITableViewDelegate / DataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 105;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GBDiscoverBesideCell *besideCell = [tableView dequeueReusableCellWithIdentifier:BesideCellID forIndexPath:indexPath];
    [besideCell.UserProtrial setActionEnable:YES];
    
    return besideCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

#pragma mark -- Action

- (void)filterPeople{
    
    // 系统自带的搜索框
//    GBSystemSearchController *searchBesideVC = [[GBSystemSearchController alloc] init];
    // 自定义的搜索框
    CYLSearchMainViewController *searchBesideVC = [[CYLSearchMainViewController alloc] init];
    [AppNavigator pushViewController:searchBesideVC animated:YES];
    DLog(@"过滤");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
