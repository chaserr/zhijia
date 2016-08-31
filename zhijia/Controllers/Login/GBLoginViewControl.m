//
//  GBLoginViewControl.m
//  zhijia
//
//  Created by nana on 16/3/19.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBLoginViewControl.h"
#import "GBTabBarController.h"
#import "GBFindPasswordVC.h"
@interface GBLoginViewControl ()
{

    DeformationButton *deformationBtn;

}


@end

@implementation GBLoginViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    _loginView.layer.borderColor = UIColorFromRGB(0x345211).CGColor;
//    _loginView.layer.borderWidth = 0.5;
    _loginView.layer.cornerRadius = 5;
    DLog(@"%f", CGRectGetMinX(_loginView.frame));
    // 动态登录按钮
//    deformationBtn = [[DeformationButton alloc] initWithFrame:CGRectMake(CGRectGetMinX(_loginView.frame), CGRectGetMaxY(_loginView.frame) + 30, CGRectGetWidth(_loginView.frame), 44) withColor:RGBCOLORVA(0xe13536, 1)];
//    [deformationBtn.forDisplayButton setTitle:@"登录" forState:UIControlStateNormal];
//    [deformationBtn.forDisplayButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
//    [deformationBtn.forDisplayButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [deformationBtn.forDisplayButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 6, 0, 0)];
//    [deformationBtn addTarget:self action:@selector(loginBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:deformationBtn];


}

- (void)viewWillLayoutSubviews{

    [super viewWillLayoutSubviews];
    deformationBtn.frame = CGRectMake(CGRectGetMinX(_loginView.frame), CGRectGetMaxY(_loginView.frame) + 30, CGRectGetWidth(_loginView.frame), 44);
}
- (IBAction)findPasswordAction:(UIButton *)sender {
    
    GBFindPasswordVC *findPasswordVC = [[GBFindPasswordVC alloc] init];
    [self.navigationController pushViewController:findPasswordVC animated:YES];
}


#pragma mark -- Action

- (IBAction)registeAction:(UIButton *)sender {
    
    [AppNavigator openRegisterViewController];
}



- (IBAction)loginBtn:(id)sender {
    
    
    if(_loginAccountField.text.length == 0 || _loginPasswordField.text.length == 0)
    {
        [GBHUDVIEW showTips:[NSString stringWithFormat:@"请输入用户名或密码"] autoHideTime:2];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            return;
        });
    }
    
    [self hideKeyboard];
    // 测试账号：
//    NSDictionary *postDict = @{ @"account": @"ruick",
//                                @"password" : @"1"
//                                };
    _loginActiveIcon.hidden = NO;
    [_loginActiveIcon startAnimating];
    [[GBLoginManager getInstance] startLogin:_loginAccountField.text  password:_loginPasswordField.text verType:0 type:0 loginSuccess:^{
        [_loginActiveIcon stopAnimating];

        [self openTabBarViewController];
        
    } loginFiled:^{
        
        [_loginActiveIcon stopAnimating];
    }];
}

- (IBAction)cancelLogin:(id)sender {
    
//    [AppNavigator openStartPageViewController];
    [self openTabBarViewController];
}


- (void)openTabBarViewController{

    [AppNavigator openMainViewController];

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [GBLoginManager getInstance].loginState = EGBStatusNotLogin;

}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hideKeyboard
{
    [_loginAccountField resignFirstResponder];
    [_loginPasswordField resignFirstResponder];
    
}

- (void)dealloc
{
    [GBNetworking cancleRequest];
}

@end
