//
//  GBProfileViewController.m
//  zhijia
//
//  Created by admin on 15/7/21.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBProfileVC.h"
#import "GBStartPageVC.h"
#import "GBEditMySelfDataIndexVC.h"
#import "GBSettingViewController.h"
#import "GBAccountMsgVCViewController.h"
#import "GBAboutOurViewController.h"
#import "GBProfilePortraitCell.h"
@interface GBProfileVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableview;
@property (nonatomic, strong) NSMutableArray *cellForNumberArr;
@end

@implementation GBProfileVC

- (void)loadView{

    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.view = scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cellForNumberArr = [NSMutableArray arrayWithArray:@[@"editPersonData", @"myDynamic", @"myAnswer", @"aboutMe", @"accountMessage", @"setting"]];
    self.navigationTitleLabel.text = @"我的";
    [self createTableView];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}


- (void)createTableView{

    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = RGBCOLOR(240, 240, 240);
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    _tableview.tableFooterView = [UIView new];
    self.automaticallyAdjustsScrollViewInsets = NO;

}
#pragma mark -  tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.cellForNumberArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 70.0f;
    }else if (indexPath.section == 1){
    
        return 100.0f;
    }else{
    
        return 60.0f;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *profileOfEditDataCellId = @"profileOfEditDataCellId";
    NSString *profileOfCommonCellId = @"profileOfCommonCellId";
    NSString *profileOfMyDynamicCellId = @"profileOfMyDynamicCellId";
//    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
        // 个人资料
        GBProfilePortraitCell *cell = [GBProfilePortraitCell cellWithTableView:tableView];
    
        return cell;
    }
    
    
    else if (indexPath.section == 1){
        // 我的动态
       UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:profileOfMyDynamicCellId];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:profileOfMyDynamicCellId];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        cell.textLabel.text = @"我的动态";
        
        return cell;
    }else{
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:profileOfCommonCellId];

        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:profileOfCommonCellId];
            cell.contentView.backgroundColor = [UIColor whiteColor];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.section) {
            case 2:
            {
                cell.imageView.image = [UIImage imageNamed:@"myAnswer"];
                cell.textLabel.text = @"我的问答";
                
                cell.detailTextLabel.text = @"4个圈子";
            }
                break;
            case 3:
            {
                cell.imageView.image = [UIImage imageNamed:@"aboutOur"];
                cell.textLabel.text = @"关于我们";
            }
                break;
            case 4:
            {
                cell.imageView.image = [UIImage imageNamed:@"accountMessage"];
                
                cell.textLabel.text = @"账户信息";
            }
                break;
            case 5:
            {
                
                cell.imageView.image = [UIImage imageNamed:@"setting"];
                
                cell.textLabel.text = @"设置";

            }
                break;
            default:
                break;
        }
        return cell;

    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:
        {
        
            GBEditMySelfDataIndexVC *editMySelfDataVC = [[GBEditMySelfDataIndexVC alloc] init];
            [self.navigationController pushViewController:editMySelfDataVC animated:YES];
        }
            break;
        case 1:
        {


        }
            break;
//        case 2:
//            <#statements#>
//            break;
        case 3:
        {
            GBAboutOurViewController *aboutOur = [[GBAboutOurViewController alloc] init];
            [self.navigationController pushViewController:aboutOur animated:YES];
        }
            break;
        case 4:
        {
            GBAccountMsgVCViewController *accountVC = [[GBAccountMsgVCViewController alloc] init];
            [self.navigationController pushViewController:accountVC animated:YES];
        }
            break;
        case 5:
        {
            GBSettingViewController *settingVC = [[GBSettingViewController alloc] init];
            [self.navigationController pushViewController:settingVC animated:YES];
            
        }
            break;
        default:
            break;
    }
}


- (NSMutableArray *)cellForNumberArr{
    
    if (_cellForNumberArr == nil) {
        _cellForNumberArr = [NSMutableArray array];
        
    }
    return  _cellForNumberArr;
}

-(void)test
{
    GBViewController *testView=[[GBViewController alloc] init];
    [self.navigationController pushViewController:testView animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView == _tableview) {
        CGFloat sectionHeaderHeight = 15;
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y > 0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        }else if (scrollView.contentOffset.y >= sectionHeaderHeight){
        
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}

@end
