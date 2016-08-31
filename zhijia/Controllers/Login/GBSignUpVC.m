//
//  GBSignUpVC.m
//  zhijia
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBSignUpVC.h"
#import "GBUnderlineTextField.h"
#import "GBChooseGenderVC.h"
#import "GBLoginBottomButton.h"

@interface GBSignUpVC ()<UITextFieldDelegate>
{
    CGFloat kSignUpDisplayHeight;
    CGFloat kSignUpDisplayWidth;
}
@property(nonatomic,strong)UIView *displayView;
@property(nonatomic,strong)UILabel *tipsLabel;
@property(nonatomic,strong)GBUnderlineTextField *cellTextField;
@property(nonatomic,strong)GBUnderlineTextField *passwordTextField;
@property(nonatomic,strong)GBUnderlineTextField *vcodeTextField;
@property(nonatomic,strong)GBLoginBottomButton *confirmButton;

@property(nonatomic,strong)UIButton *getVCodeButton;

@property(nonatomic,assign)CGFloat refreshSec;

@property(nonatomic,strong)NSTimer *timer;
@end

@implementation GBSignUpVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"创建账户";
    
    kSignUpDisplayHeight = kSignUpTipLabelHeight + kSignUpTipsLabelBottonMargin +kSignUpTextFieldHeight *3 +kSignUpConfirmButtonHeight +kSignUpConfirmButtonTopMargin;
    kSignUpDisplayWidth = CGRectGetWidth(self.view.frame)-kSignUpPadding *2;
    
    self.viewControllerStyle = GBViewControllerStylePresenting;
    
    self.view.backgroundColor = GBStarNavigationColor;
    
    [self.displayView addSubview:self.tipsLabel];
    [self.displayView addSubview:self.cellTextField];
    [self.displayView addSubview:self.passwordTextField];
    [self.displayView addSubview:self.vcodeTextField];
    [self.displayView addSubview:self.getVCodeButton];
    [self.displayView addSubview:self.confirmButton];
    
    [self.view addSubview:self.displayView];
    
    self.refreshSec=60.0f;
    self.timer=[NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(vcodeStateUpdated) userInfo:nil repeats:YES];
    [self.timer setFireDate:[NSDate distantFuture]];
    
    self.viewModel = [GBSignUpViewModel ViewModel];
    
    [self addRACSignal];
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
    
    [self hideKeyBoard];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}
#pragma Mark - Property

-(UILabel *)tipsLabel
{
    if (!_tipsLabel) {
        _tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, kSignUpDisplayWidth, kSignUpTipLabelHeight)];
        _tipsLabel.font = GBFont(17);
        _tipsLabel.text = @"请输入11位手机号码";
        _tipsLabel.textAlignment = NSTextAlignmentCenter;
        _tipsLabel.textColor = [UIColor whiteColor];
    }
    return _tipsLabel;
}

-(GBUnderlineTextField *)cellTextField
{
    if (!_cellTextField) {
        _cellTextField = [[GBUnderlineTextField alloc] initWithFrame:CGRectMake(0, kSignUpTipLabelHeight+kSignUpTipsLabelBottonMargin ,kSignUpDisplayWidth,kSignUpTextFieldHeight)];
        _cellTextField.textColor = [UIColor whiteColor];
        _cellTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"手机号" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
        _cellTextField.font = [UIFont fontWithName:@"Heiti SC" size:16.0];
        _cellTextField.delegate = self;
        _cellTextField.returnKeyType = UIReturnKeyNext;
        _cellTextField.horizontalPadding = 5;
    }
    return _cellTextField;
}
-(GBUnderlineTextField *)passwordTextField
{
    if (!_passwordTextField) {
        _passwordTextField = [[GBUnderlineTextField alloc] initWithFrame:CGRectMake(0, kSignUpTipLabelHeight+kSignUpTipsLabelBottonMargin+kSignUpTextFieldHeight,kSignUpDisplayWidth,kSignUpTextFieldHeight)];
        _passwordTextField.textColor = [UIColor whiteColor];
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"密码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
        _passwordTextField.font = [UIFont fontWithName:@"Heiti SC" size:16.0];
        _passwordTextField.delegate = self;
        _passwordTextField.returnKeyType = UIReturnKeyNext;
        _passwordTextField.horizontalPadding = 5;
    }
    return _passwordTextField;
}
-(GBUnderlineTextField *)vcodeTextField
{
    if (!_vcodeTextField) {
        _vcodeTextField = [[GBUnderlineTextField alloc] initWithFrame:CGRectMake(0, kSignUpTipLabelHeight+kSignUpTipsLabelBottonMargin+kSignUpTextFieldHeight*2,kSignUpDisplayWidth/2,kSignUpTextFieldHeight)];
        _vcodeTextField.textColor = [UIColor whiteColor];
        _vcodeTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"验证码" attributes:@{NSForegroundColorAttributeName:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]}];
        _vcodeTextField.font = [UIFont fontWithName:@"Heiti SC" size:16.0];
        _vcodeTextField.delegate = self;
        _vcodeTextField.returnKeyType = UIReturnKeyDone;
        _vcodeTextField.horizontalPadding = 5;
    }
    return _vcodeTextField;
}
-(UIButton *)getVCodeButton
{
    if (!_getVCodeButton) {
        _getVCodeButton = [[UIButton alloc] initWithFrame:CGRectMake(kSignUpDisplayWidth/2, kSignUpTipLabelHeight+kSignUpTipsLabelBottonMargin+kSignUpTextFieldHeight*2,kSignUpDisplayWidth/2,kSignUpTextFieldHeight)];
        [_getVCodeButton setTitleColor:[UIColor colorWithRed:46/255.0 green:234/255.0 blue:214/255.0 alpha:1] forState:UIControlStateNormal];
        [_getVCodeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [_getVCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_getVCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getVCodeButton addTarget:self action:@selector(getVcodeAction) forControlEvents:UIControlEventTouchUpInside];
        [_getVCodeButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, 10, 0)];
        _getVCodeButton.titleLabel.font = GBFont(16);
    }
    return _getVCodeButton;
}
-(GBLoginBottomButton *)confirmButton
{
    if(!_confirmButton)
    {
        _confirmButton = [[GBLoginBottomButton alloc] initWithFrame:CGRectMake(0, kSignUpDisplayHeight-kSignUpConfirmButtonHeight, kSignUpDisplayWidth, kSignUpConfirmButtonHeight)];
        [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(joinInAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}
-(UIView *)displayView
{
    if (!_displayView) {
        _displayView = [[UIView alloc] initWithFrame:CGRectMake(kSignUpPadding, CGRectGetHeight(self.view.frame)/2-TOP_LAYOUT_LENGTH-kSignUpDisplayHeight/2, kSignUpDisplayWidth, kSignUpDisplayHeight)];
        _displayView.backgroundColor = [UIColor clearColor];
    }
    return _displayView;
}

#pragma Mark - Action
-(void)keyboardWillShow:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGRect keyboardF = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat keyboardH = keyboardF.size.height;
    
    CGFloat displayChangeValue = 0;
    
    if (CGRectGetMaxY(self.displayView.frame)-kSignUpConfirmButtonHeight -kSignUpConfirmButtonTopMargin > CGRectGetHeight(self.view.frame)-keyboardH) {
        displayChangeValue = CGRectGetMaxY(self.displayView.frame) -kSignUpConfirmButtonHeight -kSignUpConfirmButtonTopMargin- (CGRectGetHeight(self.view.frame)-keyboardH);
    }
    
    [UIView animateWithDuration:duration animations:^{
        
        self.displayView.transform = CGAffineTransformMakeTranslation(0, - displayChangeValue - kSignUpPadding);
    }];
}
-(void)keyboardWillHide:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        self.displayView.transform = CGAffineTransformIdentity;//回复之前的位置
    }];
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIView *viewTouched = [touches anyObject];
    if (![viewTouched isKindOfClass:[UITextField class]]) {
        [self hideKeyBoard];
    }
}
-(void)hideKeyBoard
{
    [self.cellTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.vcodeTextField resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.cellTextField) {
        [self.passwordTextField becomeFirstResponder];
    }else if(textField == self.passwordTextField){
        [self.vcodeTextField becomeFirstResponder];
    }else{
        [self hideKeyBoard];
    }
    return textField == self.vcodeTextField;
}
-(void)joinInAction
{
    self.viewModel.signUpRequest.cell = self.cellTextField.text;
    self.viewModel.signUpRequest.password = self.passwordTextField.text;
    self.viewModel.signUpRequest.vcode = self.vcodeTextField.text;
    GBChooseGenderVC *desVC = [[GBChooseGenderVC alloc] init];
    desVC.viewModel = self.viewModel;
    [self.navigationController pushViewController:desVC animated:YES];
}

-(void)vcodeStateUpdated
{
    self.refreshSec-=1;
    if(self.refreshSec>0)
    {
        NSString *str=[NSString stringWithFormat:@"%ds重新获取",(int)self.refreshSec];
        [self.getVCodeButton setTitle:str forState:UIControlStateNormal];
    }
    else
    {
        self.getVCodeButton.enabled=YES;
        [self.getVCodeButton setTitle:@"重新获取" forState:UIControlStateNormal];
        [self.timer setFireDate:[NSDate distantFuture]];
    }
}
-(void)getVcodeAction
{
    self.viewModel.fetchVcodeRequest.cell = self.cellTextField.text;
    self.viewModel.fetchVcodeRequest.requestNeedActive = YES;
}

#pragma  Mark -- RAC
-(void)addRACSignal
{
    RAC(self.confirmButton,enabled) = [RACSignal combineLatest:@[self.cellTextField.rac_textSignal,self.passwordTextField.rac_textSignal,self.vcodeTextField.rac_textSignal]
                                          reduce:^(NSString *account,NSString *password,NSString *vcode){
                                              return @(account.length > 0 && password.length > 0 && vcode.length);}];
    
    [RACObserve(self.viewModel.fetchVcodeRequest, state) subscribeNext:^(id x) {
        if (self.viewModel.fetchVcodeRequest.failed) {
            [self hideProgress];
            [self showHUDText:self.viewModel.fetchVcodeRequest.message];
        }else if (self.viewModel.fetchVcodeRequest.sending){
            [self showProgress];
        }else if(self.viewModel.fetchVcodeRequest.succeed){
            [self hideProgress];
            [self showHUDText:@"验证码已发送至您的手机"];
            self.refreshSec = 60;
            [self.timer setFireDate:[NSDate distantPast]];
            self.getVCodeButton.enabled=NO;
        }
    }];
}
@end
