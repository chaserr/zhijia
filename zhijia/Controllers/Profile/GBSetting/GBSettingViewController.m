//
//  GBSettingViewController.m
//  zhijia
//
//  Created by 张浩 on 16/5/6.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBSettingViewController.h"
#import "GBSettingCell.h"
#import "GBSettingWarnCell.h"
#import "UUInputAccessoryView.h"
#import "UserCenter.h"
#import "STAlertView.h"

@interface GBSettingViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView* tableview;
@property (nonatomic, strong) UIButton* logOutButon;
@property (nonatomic, strong) UIView* tableFootView;
@property (nonatomic, strong) STAlertView *alertView;


@end

@implementation GBSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self customlizeNavigationBarBackBtn];
    self.navigationTitleLabel.text = @"系统设置";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self createTableView];
    
}

#pragma mark -- UITableViewDelegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
            
        default:
            return 0;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell;
    if (indexPath.section == 0) {
        GBSettingCell *settingCell = [tableView dequeueReusableCellWithIdentifier:@"GBSettingCell" forIndexPath:indexPath];
        [settingCell.inputAnonymousBtn addTarget:self action:@selector(inputAnonymous:) forControlEvents:(UIControlEventTouchUpInside)];
        cell = settingCell;
        
    }else{
    
        GBSettingWarnCell *settingWarnCell = [tableView dequeueReusableCellWithIdentifier:@"GBSettingWarnCell" forIndexPath:indexPath];
        
        cell = settingWarnCell;
    }
    
    return cell;
    
}

#pragma mark -- action
- (void)createTableView{
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - 44) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    _tableview.scrollEnabled = NO;
    _tableview.rowHeight = 50.0f;
    [_tableview registerNib:[UINib nibWithNibName:@"GBSettingCell" bundle:nil] forCellReuseIdentifier:@"GBSettingCell"];
    [_tableview registerNib:[UINib nibWithNibName:@"GBSettingWarnCell" bundle:nil] forCellReuseIdentifier:@"GBSettingWarnCell"];
    
    
    
    self.tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    
    self.logOutButon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _logOutButon.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, 50);
    _logOutButon.backgroundColor = [UIColor colorWithRed:0.958 green:0.175 blue:0.245 alpha:1.000];
    [_logOutButon setTitle:@"退出登录" forState:(UIControlStateNormal)];
    [_logOutButon setTintColor:[UIColor whiteColor]];
    [_logOutButon.titleLabel setFont:GBSystemFont(15)];
    _logOutButon.layer.cornerRadius = 3;
    _logOutButon.layer.masksToBounds = YES;
    _logOutButon.adjustsImageWhenHighlighted = NO;
    [_logOutButon addTarget:self action:@selector(logOutAction) forControlEvents:(UIControlEventTouchUpInside)];
    [_tableFootView addSubview:_logOutButon];
    _tableview.tableFooterView = _tableFootView;
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)inputAnonymous:(UIButton *)sender{

    [[UUInputAccessoryView sharedInstance] showBlock:^(NSString *contentStr) {
        
        [sender setTitle:contentStr forState:(UIControlStateNormal)];
    } WithController:self];
}


- (void)logOutAction{

    DLog(@"退出登录");
//        [[CDChatManager manager] closeWithCallback: ^(BOOL succeeded, NSError *error) {
//                DLog(@"%@", error);
//            [[UserCenter sharedInstance] clearUser];
//            APPLICATION.keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[GBStartPageVC alloc] init]];
//            }];
//        [[UserCenter sharedInstance] clearUser];
//        APPLICATION.keyWindow.rootViewController = [[UINavigationController alloc] initWithRootViewController:[GBLoginVC alloc]];
    
    TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"退出登录" message:@"确定要退出登录吗？退出登录后你将收不到任何消息"];
        [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
        
        [[GBLoginManager getInstance] logout];

    }]];
    [alertView addAction:[TYAlertAction actionWithTitle:@"取消" style:TYAlertActionStyleCancle handler:^(TYAlertAction *action) {
        
    }]];
//
    TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationFade];
    [self presentViewController:alertController animated:YES completion:nil];
    
//    self.alertView = [[STAlertView alloc] initWithTitle:@"退出登录" message:@"确定要退出登录吗？退出登录后将不会收取到消息的通知" cancelButtonTitle:@"取消" otherButtonTitles:@"确定" cancelButtonBlock:^{
//    } otherButtonBlock:^{
//
//        [[GBLoginManager getInstance] logout];
//
//    }];

    
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
