//
//  GBSearchResultViewController.m
//  zhijia
//
//  Created by 张浩 on 16/5/14.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBSearchResultViewController.h"
@interface GBSearchResultViewController ()<UITableViewDelegate, UITableViewDataSource>



@end

@implementation GBSearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    [self createTableView];
}

//- (void)createTableView{
//    
//    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 0) style:UITableViewStylePlain];
//    _tableView.delegate = self;
//    _tableView.dataSource = self;
//    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//    [self.view addSubview:_tableView];
//    
//    _tableView.tableFooterView = [UIView new];
//    self.automaticallyAdjustsScrollViewInsets = NO;
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.searchResults count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchResultCell" forIndexPath:indexPath];
    
    cell.textLabel.text = self.searchResults[indexPath.row];
    
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
