//
//  GBNotificationTC.m
//  zhijia
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBNotificationTC.h"
#import "GBUser.h"
#import "UserCenter.h"

@interface GBNotificationTC ()

@end

@implementation GBNotificationTC

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - delegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [UserCenter sharedInstance].dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tableviewcell"];
        cell.contentView.backgroundColor = [UIColor yellowColor];
    }
    
    GBUser *user = [[UserCenter sharedInstance].dataSource objectAtIndex:indexPath.row];
    
    cell.textLabel.text = user.username;
    cell.detailTextLabel.text = user.userId;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    GBUser *user = [[UserCenter sharedInstance].dataSource objectAtIndex:indexPath.row];
    [[CDIMService service] goWithUserId:user.userId fromVC:self];
}
@end
