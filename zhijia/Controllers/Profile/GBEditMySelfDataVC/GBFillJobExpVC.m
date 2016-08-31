//
//  GBFill work experience  work experience GBFillJobExpVC.m
//  zhijia
//
//  Created by 张浩 on 16/5/4.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBFillJobExpVC.h"
#import "GBEditJobExpViewController.h"
#import "GBJobExpCell.h"
@interface GBFillJobExpVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UIButton *addJobExpBtn;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray* jobExpArray;
@property (nonatomic, strong) GBJobExp* jobExp;

@end

@implementation GBFillJobExpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self customlizeNavigationBarBackBtn];
    self.navigationTitleLabel.text = @"工作经验";
    
    [self createTableView];

    // 测试数据
    GBJobExp *job = [[GBJobExp alloc] init];
    job.companyName = @"0";
    job.departmentName = @"0";
    job.jobPosition = @"0";
    job.jobTime = @"0";
    job.jobContentDes = @"打开的空间按不卡不卡会不会把卡号不对酒店可骄傲不打卡不打卡上道具卡不到看见俺上班的刷卡机不读卡机不打开撒不到";
    [self.jobExpArray addObject:job];
    GBJobExp *job1 = [[GBJobExp alloc] init];
    job1.companyName = @"1";
    job1.departmentName = @"1";
    job1.jobPosition = @"1";
    job1.jobTime = @"1";
    job1.jobContentDes = @"我带我活动我店里拿我的卡价位的就卡死的卡死的卡死机卡速度可那是你打开那大家的那块就能大大阿达到了";
    [self.jobExpArray addObject:job1];
    
    
}


- (void)createAddJobExp{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 80)];
    
    UIButton *button = [UIButton buttonWithType:(UIButtonTypeSystem)];
    button.frame = CGRectMake(20, 15, SCREEN_WIDTH - 40, 50);
    button.backgroundColor = [UIColor whiteColor];
    [button.titleLabel setFont:[UIFont systemFontOfSize:17]];
    [button setTitle:@"添加工作经验" forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"add"] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(addJobExp:) forControlEvents:(UIControlEventTouchUpInside)];
    self.addJobExpBtn = button;
    [view addSubview:button];
    self.tableView.tableHeaderView = view;
}

- (void)createTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:(UITableViewStylePlain)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
    // 添加工作经验按钮
    [self createAddJobExp];
    _tableView.tableFooterView = [UIView new];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark -- tableviewDelegate/Datasource 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.jobExpArray.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

// 预估高度
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GBJobExpCell *cell = [GBJobExpCell cellWithTableView:tableView];
    cell.jobExp = [self.jobExpArray objectAtIndex:indexPath.section];
    
    return cell;
}

/**
 *  返回每一行的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GBJobExp *jobExp = self.jobExpArray[indexPath.section];
    return jobExp.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }else{
    
        return 20;
    }
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated{

    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{

    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        // 使用的是section
        [self.jobExpArray removeObjectAtIndex:indexPath.section];
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:(UITableViewRowAnimationLeft)];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    
}

// 设置cell的delete为删除
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{

    return @"删除";
}

#pragma mark -- action
- (void)addJobExp:(id)sender{

    __weak __typeof(self)weakSelf = self;
    GBEditJobExpViewController *editJobExpVC = [[GBEditJobExpViewController alloc] init];
    editJobExpVC.jobExp = [[GBJobExp alloc] init];
    
    editJobExpVC.updateJobExp = ^(GBJobExp *jobExp){
        __strong __typeof(weakSelf)strongSelf = weakSelf;
//        strongSelf.jobExp = [[GBJobExp alloc] init];
        [strongSelf.jobExpArray addObject:jobExp];
        
       strongSelf.jobExpArray = [[[strongSelf.jobExpArray reverseObjectEnumerator] allObjects] mutableCopy];
        [strongSelf.tableView reloadData];
    };
    [self.navigationController pushViewController:editJobExpVC animated:YES];
    
}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

// 懒加载
- (NSMutableArray *)jobExpArray{
    
    if (!_jobExpArray) {
        _jobExpArray = [[NSMutableArray alloc] init];
    }
    return _jobExpArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
