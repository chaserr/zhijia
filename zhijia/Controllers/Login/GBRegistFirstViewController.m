//
//  GBRegistFirstViewController.m
//  zhijia
//
//  Created by 张浩 on 16/5/18.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBRegistFirstViewController.h"
#import "GBFindPasswordCell.h"
#import "QCheckBox.h"
#import "GBRegisterNextStepVC.h"
@interface GBRegistFirstViewController ()<QCheckBoxDelegate,UITextFieldDelegate>

@property (nonatomic , assign) int      secondsCount;
@property (nonatomic , retain) NSTimer  *timer;

/** placeholderArray */
@property (nonatomic, strong) NSMutableArray *placeholderArray;
@property (nonatomic, strong ) UIButton *verifyCodeBtn;

@property (nonatomic, strong) UIButton* nextButon;
@property (nonatomic, strong) UIView* tableFootView;
@property (nonatomic, strong) QCheckBox *registerDelegateBtn;
@property (nonatomic, strong) UITextField *passwordField;
@property (nonatomic, strong) UITextField *telephoneField;

@end

@implementation GBRegistFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIView *customTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 176, 46)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 46)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"填写个人资料";
    UIButton *stepBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    stepBtn.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5,  (46 - 18)*0.5, 35, 18);
    [stepBtn setTitle:@"1/2" forState:(UIControlStateNormal)];
    [stepBtn setBackgroundImage:[UIImage imageNamed:@"register_navigation_step"] forState:(UIControlStateNormal)];
    [stepBtn.titleLabel setFont:GBSystemFont(14)];
    [stepBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    stepBtn.userInteractionEnabled = NO;
    [customTitleView addSubview:stepBtn];
    [customTitleView addSubview:titleLabel];
    self.navigationItem.titleView = customTitleView;
    
    
    self.tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    
    QCheckBox *registerDelegateBtn = [[QCheckBox alloc] init];
    registerDelegateBtn.frame = CGRectMake(20, 24, SCREEN_WIDTH - 40, 30);
    [registerDelegateBtn setTitle:@"已阅读协议并同意注册《用户注册协议》" forState:(UIControlStateNormal)];
    [registerDelegateBtn setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
    [registerDelegateBtn setBackgroundColor:[UIColor clearColor]];
    [registerDelegateBtn.titleLabel setFont:GBSystemFont(15)];
    [registerDelegateBtn setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
    [registerDelegateBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 10)];
    [registerDelegateBtn setChecked:NO];
    registerDelegateBtn.delegate = self;
    self.registerDelegateBtn = registerDelegateBtn;
    
    [_tableFootView addSubview:registerDelegateBtn];
    
    self.nextButon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _nextButon.frame = CGRectMake(20, CGRectGetMaxY(registerDelegateBtn.frame) + 34, SCREEN_WIDTH - 40, 50);
    [_nextButon setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.783 green:0.794 blue:0.786 alpha:1.000]] forState:UIControlStateDisabled];
    [_nextButon setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.392 green:0.812 blue:1.000 alpha:1.000]] forState:(UIControlStateNormal)];
    [_nextButon setTitle:@"下一步" forState:(UIControlStateNormal)];
    [_nextButon setTitleColor:[UIColor colorWithWhite:0.588 alpha:1.000] forState:(UIControlStateDisabled)];
    [_nextButon setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_nextButon.titleLabel setFont:GBSystemFont(17)];
    _nextButon.layer.cornerRadius = 3;
    _nextButon.layer.masksToBounds = YES;
    _nextButon.adjustsImageWhenHighlighted = NO;
    [_nextButon addTarget:self action:@selector(nextStepAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    _nextButon.enabled = NO;
    [_tableFootView addSubview:_nextButon];
    
    self.tableView.tableFooterView = _tableFootView;
    
    self.tableView.scrollEnabled = NO;
    
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"登录" style:UIBarButtonItemStylePlain target:self action:@selector(loginAction:)];
        rightItem;
    });

}

#pragma mark -- UITableviewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.placeholderArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GBFindPasswordCell *cell = [GBFindPasswordCell cellWithTableView:tableView];
    [cell setCellContentWithIndexPath:indexPath];
    cell.cellLetftDetail.delegate = self;
    [cell.cellLetftDetail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

    cell.cellLetftDetail.placeholder = self.placeholderArray[indexPath.row];
    if (indexPath.row == 0) {
        
        self.telephoneField = cell.cellLetftDetail;

    }else if (indexPath.row == 1) {
        
        self.verifyCodeBtn = cell.vertifyCodeBtn;
        [self.verifyCodeBtn addTarget:self action:@selector(getVerifyCode:) forControlEvents:(UIControlEventTouchUpInside)];
    }else if (indexPath.row == 2){
    
        self.passwordField = cell.cellLetftDetail;
    }
    
    
    return cell;
}

#pragma mark -- Action

- (void)loginAction:(id)sender{

    [AppNavigator openLoginViewController];
}


- (void)nextStepAction:(UIButton *)sender{
    
    GBRegisterNextStepVC *nextStepVC = [[GBRegisterNextStepVC alloc] init];
    [AppNavigator pushViewController:nextStepVC animated:YES];
}

- (void)textFieldDidChange:(UITextField *)textField{
    
    
    GBFindPasswordCell *cell = CELL_SUBVIEW_TABLEVIEW(textField, self.tableView);
    NSIndexPath *indexPath = INDEXPATH_SUBVIEW_TABLEVIEW(textField, self.tableView);
    GBFindPasswordCell *nextCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:indexPath.row + 1 inSection:0]];
    if (textField.text.length) {
        [cell.cellLeftImage setHighlighted:YES];
        if ([textField.placeholder isEqualToString:@"请输入手机号"]) {
            cell.cellTextfieldClear.hidden = NO;
            
            [nextCell.vertifyCodeBtn setBackgroundColor:[UIColor colorWithRed:0.169 green:0.657 blue:1.000 alpha:1.000]];
            [nextCell.vertifyCodeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
            nextCell.vertifyCodeBtn.enabled = YES;
            
        }
        
    }else{
        
        
        if ([textField.placeholder isEqualToString:@"请输入手机号"]) {
            cell.cellTextfieldClear.hidden = YES;
            nextCell.vertifyCodeBtn.enabled = NO;
            
            [nextCell.vertifyCodeBtn setBackgroundColor:[UIColor colorWithRed:0.773 green:0.779 blue:0.795 alpha:1.000]];
            [nextCell.vertifyCodeBtn setTitleColor:[UIColor colorWithWhite:0.170 alpha:1.000] forState:(UIControlStateNormal)];
            
            
        }
        
        [cell.cellLeftImage setHighlighted:NO];
        
    }
}

- (void)getVerifyCode:(UIButton *)sender{
    
    GBFindPasswordCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([cell.cellLetftDetail.text length] == 0) {
        
        [GBHUDVIEW showTips:@"请输入手机号" autoHideTime:1.0];
    }
    else if(![CommonUtils isPhoneNumber:cell.cellLetftDetail.text] || cell.cellLetftDetail.text.length != 11){
        
        [GBHUDVIEW showTips:@"请输入正确的手机号" autoHideTime:1.0];
    }else{
        
        _secondsCount = 60;
        
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerFire) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
        [_verifyCodeBtn setUserInteractionEnabled:NO];
        
    }
}

- (void)timerFire
{
    //60秒倒计时
    _secondsCount--;
    [_verifyCodeBtn setTitle:[NSString stringWithFormat:@"%d秒后重新获取",_secondsCount] forState:(UIControlStateNormal)];
    if (_secondsCount == 0) {
        [_timer invalidate];
        [_verifyCodeBtn setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        [_verifyCodeBtn setUserInteractionEnabled:YES];
    }
}

- (BOOL)shouldSelectedCheckBox:(QCheckBox *)checkbox checked:(BOOL)checked{

    if (!checked) {
        
        if (_telephoneField.text.length == 0) {
            [GBHUDVIEW showTips:@"请输入手机号" autoHideTime:1];
            return NO;
        }else if (_passwordField.text.length == 0){
            
            [GBHUDVIEW showTips:@"请输入密码" autoHideTime:1];
            
            return NO;
            
        }else{
            
            _nextButon.enabled = YES;
            return YES;
            
        }
        
    }else{
        
        _nextButon.enabled = NO;
        return YES;
        
    }
}





- (void)backAction{
    
    [AppNavigator popViewControllerAnimated:YES];
}
// 懒加载
- (NSMutableArray *)placeholderArray{
    
    if (!_placeholderArray) {
        _placeholderArray = [NSMutableArray arrayWithObjects:@"请输入手机号", @"请输入验证码", @"请输入密码", nil];
        
    }
    return _placeholderArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
