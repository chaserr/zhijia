//
//  GBStartPageVC.m
//  zhijia
//
//  Created by 童星 on 16/6/10.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBStartPageVC.h"

@interface GBStartPageVC ()

@property (weak, nonatomic) IBOutlet UIButton *weixinLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *qqLoginBtn;
@property (weak, nonatomic) IBOutlet UIButton *sinaLoginBtn;

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@end

@implementation GBStartPageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [_loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forState:(UIControlStateHighlighted)];
    [_registerBtn setBackgroundImage:[UIImage imageWithColor:[UIColor blackColor]] forState:(UIControlStateHighlighted)];

    _loginBtn.layer.borderWidth = 1;
    _loginBtn.layer.borderColor = [UIColor blackColor].CGColor;
    _registerBtn.layer.borderWidth = 1;
    _registerBtn.layer.borderColor = [UIColor blackColor].CGColor;


}

#pragma mark -- life circle
- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarHidden = YES;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarHidden = NO;
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark -- Action


- (IBAction)loginAction:(UIButton *)sender {

    [AppNavigator openLoginViewController];


    
}
- (IBAction)registerAction:(UIButton *)sender {

    [AppNavigator openRegisterViewController];


}

- (IBAction)weixinLoginBtn:(UIButton *)sender {

    
}


- (IBAction)qqLoginBtn:(UIButton *)sender {

    
}
- (IBAction)sinaLoginBtn:(UIButton *)sender {
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
