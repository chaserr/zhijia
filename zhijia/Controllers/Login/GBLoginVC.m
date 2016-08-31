//
//  GBLoginViewController.m
//  zhijia
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBLoginVC.h"
#import "GBLoginBottomButton.h"
#import "LoginViewModel.h"
#import "LoginResponseModel.h"
#import "UserCenter.h"
#import "GBEntryTextField.h"
#import "GBUnderlineTextField.h"

@interface GBLoginVC ()<UITextFieldDelegate>
{
    CGFloat kLoginVCInputViewTotalHeight ;
    CGFloat kLoginVCDisplayViewTotalHeight;
    CGFloat kLoginVCAvatarImageViewMarginBottom;
}
@property(nonatomic,strong)GBUnderlineTextField *usernameTextField;
@property(nonatomic,strong)GBUnderlineTextField *passwordTextField;
@property(nonatomic,strong)GBLoginBottomButton *loginButton;
@property(nonatomic,strong)LoginViewModel *loginViewModel;
@property(nonatomic,strong)UIImageView *avatarImageView;
@property(nonatomic,strong)UIView *inputView;
@property(nonatomic,strong)UIView *displayView;
@end

@implementation GBLoginVC



- (void)viewDidLoad {
    [super viewDidLoad];
    kLoginVCAvatarImageViewMarginBottom = GBFourInch ? 20 : 50;
    kLoginVCInputViewTotalHeight= kLoginVCLoginButtonHeight + kLoginVCPasswordMarginBottom + kLoginVCTextFieldHeight * 2;
    kLoginVCDisplayViewTotalHeight = kLoginVCInputViewTotalHeight + kLoginVCAvatarImageViewSize +kLoginVCAvatarImageViewMarginBottom *2;
    
    self.title = @"登陆";
    
    self.view.backgroundColor = UIColorFromRGB(0xf7f7f7);
    
    self.viewControllerStyle = GBViewControllerStylePresenting;
    
    self.loginViewModel = [LoginViewModel ViewModel];
    
    [self.inputView addSubview:self.usernameTextField];
    [self.inputView addSubview:self.passwordTextField];
    [self.inputView addSubview:self.loginButton];
    
    [self.displayView addSubview:self.inputView];
    [self.displayView addSubview:self.avatarImageView];
    
    [self.view addSubview:self.displayView];
    
    //[[UserCenter sharedInstance] clearAccount];
    
    //RAC
    _usernameTextField.text=[UserCenter sharedInstance].cell;
    [self addRacSignal];
   
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
#pragma mark - Propertys

-(GBUnderlineTextField *)usernameTextField
{
    if (!_usernameTextField) {
        _usernameTextField = [[GBUnderlineTextField alloc] initWithFrame:CGRectMake(kLoginVCTextFieldPadding, 0, CGRectGetWidth(self.view.frame)-kLoginVCTextFieldPadding*2, kLoginVCTextFieldHeight)];
        _usernameTextField.textColor = [UIColor whiteColor];
        _usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
        _usernameTextField.font = [UIFont fontWithName:@"Heiti SC" size:16.0];
        _usernameTextField.delegate = self;
        _usernameTextField.horizontalPadding = 5;
        _usernameTextField.returnKeyType = UIReturnKeyNext;
        [_usernameTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return _usernameTextField;
}
-(GBUnderlineTextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[GBUnderlineTextField alloc] initWithFrame:CGRectMake(kLoginVCTextFieldPadding, CGRectGetMaxY(self.usernameTextField.frame), CGRectGetWidth(self.view.frame)-kLoginVCTextFieldPadding*2, kLoginVCTextFieldHeight)];
        _passwordTextField.textColor = [UIColor whiteColor];
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
        _passwordTextField.font = [UIFont fontWithName:@"Heiti SC" size:16.0];
        _passwordTextField.delegate = self;
        _passwordTextField.returnKeyType = UIReturnKeyDone;
        _passwordTextField.horizontalPadding = 5;
        [_passwordTextField addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    }
    return _passwordTextField;
}
-(GBLoginBottomButton *)loginButton
{
    if (!_loginButton) {
        _loginButton = [[GBLoginBottomButton alloc] initWithFrame:CGRectMake(kLoginVCTextFieldPadding, CGRectGetMaxY(_passwordTextField.frame)+kLoginVCPasswordMarginBottom, CGRectGetWidth(_passwordTextField.frame), kLoginVCLoginButtonHeight)];
        [_loginButton setTitle:@"登陆" forState:UIControlStateNormal];
    }
    return _loginButton;
}

-(UIView *)inputView
{
    if (!_inputView) {
        _inputView = [[UIView alloc] initWithFrame:CGRectMake(0, kLoginVCAvatarImageViewMarginBottom*2+kLoginVCAvatarImageViewSize, CGRectGetWidth(self.view.frame),kLoginVCInputViewTotalHeight)];
    }
    return _inputView;
}

-(UIImageView *)avatarImageView
{
    if(!_avatarImageView)
    {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.frame)-kLoginVCAvatarImageViewSize/2 , kLoginVCAvatarImageViewMarginBottom, kLoginVCAvatarImageViewSize, kLoginVCAvatarImageViewSize)];
        [_avatarImageView.layer setCornerRadius:kLoginVCAvatarImageViewSize/2];
        _avatarImageView.backgroundColor = [UIColor whiteColor];
    }
    return _avatarImageView;
}
-(UIView *)displayView
{
    if (!_displayView) {
        _displayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), kLoginVCDisplayViewTotalHeight)];
    }
    return _displayView;
}
#pragma  mark - Actions

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *viewTouched = [touches anyObject];
    if (![viewTouched isKindOfClass:[UITextField class]]) {
        [self.usernameTextField resignFirstResponder];
        [self.passwordTextField resignFirstResponder];
    }
}
-(void)loginIn:(id)sender
{
//    self.loginViewModel.request.account = self.usernameTextField.text;
//    self.loginViewModel.request.password = self.passwordTextField.text;
//    self.loginViewModel.request.requestNeedActive = YES;
    
//    UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    APPLICATION.keyWindow.rootViewController = [mainSB instantiateInitialViewController];
}

-(void)keyboardWillShow:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardH = keyboardF.size.height;

    CGFloat displayChangeValue = 0;
    
    if (CGRectGetMaxY(self.displayView.frame) > CGRectGetHeight(self.view.frame)-keyboardH) {
        displayChangeValue = CGRectGetMaxY(self.displayView.frame) - (CGRectGetHeight(self.view.frame)-keyboardH);
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        self.displayView.transform = CGAffineTransformMakeTranslation(0, - displayChangeValue - kLoginVCTextFieldPadding);
    }];
}
-(void)keyboardWillHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.displayView.transform = CGAffineTransformIdentity;//回复之前的位置
    }];
}
#pragma mark - functions

-(void)loginIn
{
    self.loginViewModel.request.cell = self.usernameTextField.text;
    self.loginViewModel.request.password = self.passwordTextField.text;
    self.loginViewModel.request.requestNeedActive = YES;
}
-(void)loginFailed:(NSString *)errMsg
{
    [self showHUDText:errMsg];
}

#pragma mark - delegate

-(void)textFieldDidChange
{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.usernameTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else{
        [self loginIn];
    }
    return textField == self.passwordTextField;
}

#pragma mark - RAC

-(void)addRacSignal
{
    @weakify(self);
    
    RACSignal* signal = [RACSignal combineLatest:@[self.usernameTextField.rac_textSignal,self.passwordTextField.rac_textSignal,RACObserve(self.loginViewModel.request, state)]
                                          reduce:^(NSString *account,NSString *password,NSString *state){
                                              return @(account.length > 0 && password.length > 0 && state != RequestStateSending);}];
    RAC(_loginButton,enabled) = signal;
    
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self loginIn];
    }];
    
    
//    [[RACObserve(self.loginViewModel, response) filter:^BOOL(LoginResponse *value) {
//        return value != nil;
//    }] subscribeNext:^(LoginResponse *value) {
//        UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//        APPLICATION.keyWindow.rootViewController = [mainSB instantiateInitialViewController];
//        NSLog(@"数据到了");
//    }];
    
    [[RACObserve(self.loginViewModel.request, state) filter:^BOOL(NSNumber *state) {
        @strongify(self);
        return self.loginViewModel.request.failed;
    }] subscribeNext:^(id x) {
        @strongify(self);
        NSLog(@"错误:%@",self.loginViewModel.request.message);
        [self loginFailed:self.loginViewModel.request.message];
    }];
    
    [RACObserve(self.loginViewModel.request, state) subscribeNext:^(NSString *state) {
        @strongify(self);
        
//        if (self.loginViewModel.request.failed) {
//            [self hideProgress];
//            [self loginFailed:self.loginViewModel.request.message];
//        }else if(self.loginViewModel.request.sending){
//            [self showProgress];
//        }else if(self.loginViewModel.request.succeed){
            [self.loginViewModel LoginIn:^(){
                [self hideProgress];
            }];
//        }
    }];

}
@end
