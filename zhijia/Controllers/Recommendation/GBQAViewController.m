//
//  GBQAViewController.m
//  zhijia
//
//  Created by 童星 on 16/6/8.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBQAViewController.h"
#import "GBAddAnswerVC.h"
@interface GBQAViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView    *tableview;

@end

@implementation GBQAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];

}

#pragma mark -- life circle


#pragma mark -- tableviewDelegate/datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GBAnswerQuestionCell"];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"GBAnswerQuestion"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"问答";
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    GBAddAnswerVC *answerVC = [[GBAddAnswerVC alloc] init];
    [AppNavigator pushViewController:answerVC withCurrentView:self.view animated:YES];
}

#pragma mark --Action
- (void)createTableView{
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 49) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = RGBCOLOR(240, 240, 240);
    //    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    _tableview.tableFooterView = [UIView new];
    
//    [self.tableview registerClass:[GBRecommendCell class] forCellReuseIdentifier:kTimeLineTableViewCellId];
    
    
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
