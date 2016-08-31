//
//  GBAccountMsgVCViewController.m
//  zhijia
//
//  Created by 张浩 on 16/5/6.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBAccountMsgVCViewController.h"
#import "GBModifyPasswordVC.h"
@interface GBAccountMsgVCViewController ()

@property (nonatomic, strong) NSMutableArray* cellTitleArray;


@end

@implementation GBAccountMsgVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customlizeNavigationBarBackBtn];
    self.navigationTitleLabel.text = @"账户信息";
    self.tableView.rowHeight = 50;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    // Do any additional setup after loading the view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.cellTitleArray.count;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"accountCellId"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"accountCellId"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = self.cellTitleArray[indexPath.section];
    
    switch (indexPath.section) {
        case 0:
        {
            cell.detailTextLabel.text = @"13488837818";
        }
            break;
        case 1:
        {
            cell.detailTextLabel.text = @"13488837818@163.com";
        }
            break;
        case 2:
        {
            cell.detailTextLabel.text = @"修改";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
            break;
            
        default:
            break;
    }

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 2) {
        
        GBModifyPasswordVC *modifyPasswordVC = [[GBModifyPasswordVC alloc] init];
        [self.navigationController pushViewController:modifyPasswordVC animated:YES];
        
    }
}

// 懒加载
- (NSMutableArray *)cellTitleArray{
    
    if (!_cellTitleArray) {
        _cellTitleArray = [NSMutableArray arrayWithObjects:@"手机号",@"邮箱地址", @"密码设置", nil];
    }
    return _cellTitleArray;
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
