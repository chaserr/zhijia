//
//  GBChooseGenderVC.m
//  zhijia
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBChooseGenderVC.h"
#import "GBLoginBottomButton.h"

@interface GBChooseGenderVC ()
{
    CGFloat kChooseGenderDisplayWidth;
}
@property(nonatomic,strong)UIView *displayView;
@property(nonatomic,strong)UIButton *maleButton;
@property(nonatomic,strong)UIButton *femaleButton;
@property(nonatomic,strong)GBLoginBottomButton *joinInButton;
@property(nonatomic,strong)UIButton *currentButton;

@end

@implementation GBChooseGenderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kChooseGenderDisplayWidth= CGRectGetWidth(self.view.frame)-kChoosGenderPadding*2;
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = GBStarNavigationColor;
    
    self.navigationController.navigationBar.topItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
    
    [self.view addSubview:self.displayView];
    [self.displayView addSubview:self.joinInButton];
    [self.displayView addSubview:self.maleButton];
    [self.displayView addSubview:self.femaleButton];
    
    UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, kChooseGenderTipsMargin, kChooseGenderDisplayWidth, kChooseGenderTipsHeight)];
    tipsLabel.text = @"请选择您的性别";
    tipsLabel.textColor = UIColorFromRGB(0x3c4042);
    tipsLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *maleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kChooseGenderDisplayWidth/2-kChooseGenderButtonPadding-kChooseGenderButtonSize, kChooseGenderTipsHeight+kChooseGenderTipsMargin*2+kChooseGenderButtonSize+kChooseGenderButtonTitleMarginTop, kChooseGenderButtonSize, kChooseGenderButtonTitleHeight)];
    maleLabel.text = @"男生";
    maleLabel.textAlignment = NSTextAlignmentCenter;
    maleLabel.textColor = UIColorFromRGB(0x3c4042);
    [self.displayView addSubview:maleLabel];
    
    UILabel *femaleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kChooseGenderDisplayWidth/2+kChooseGenderButtonPadding, kChooseGenderTipsHeight+kChooseGenderTipsMargin*2+kChooseGenderButtonSize+kChooseGenderButtonTitleMarginTop, kChooseGenderButtonSize, kChooseGenderButtonTitleHeight)];
    femaleLabel.text = @"女生";
    femaleLabel.textAlignment = NSTextAlignmentCenter;
    femaleLabel.textColor = UIColorFromRGB(0x3c4042);
    [self.displayView addSubview:femaleLabel];
    
    [self.displayView addSubview:tipsLabel];
    
    [self addRACSignal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)displayView
{
    if (!_displayView) {
        _displayView = [[UIView alloc] initWithFrame:CGRectMake(kChoosGenderPadding, CGRectGetHeight(self.view.frame)/2-TOP_LAYOUT_LENGTH-kChooseGenderDisplayHeight/2, kChooseGenderDisplayWidth, kChooseGenderDisplayHeight)];
        _displayView.backgroundColor = [UIColor whiteColor];
    }
    return _displayView;
}
-(UIButton *)maleButton
{
    if (!_maleButton) {
        _maleButton = [[UIButton alloc] initWithFrame:CGRectMake(kChooseGenderDisplayWidth/2-kChooseGenderButtonPadding-kChooseGenderButtonSize, kChooseGenderTipsHeight+kChooseGenderTipsMargin*2, kChooseGenderButtonSize, kChooseGenderButtonSize)];
        [_maleButton setImage:[UIImage imageNamed:@"ic_male_normal"] forState:UIControlStateNormal];
        [_maleButton setImage:[UIImage imageNamed:@"ic_male_selected"] forState:UIControlStateSelected];
        [_maleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _maleButton;
}
-(UIButton *)femaleButton
{
    if (!_femaleButton) {
        _femaleButton = [[UIButton alloc] initWithFrame:CGRectMake(kChooseGenderDisplayWidth/2+kChooseGenderButtonPadding, kChooseGenderTipsHeight+kChooseGenderTipsMargin*2, kChooseGenderButtonSize, kChooseGenderButtonSize)];
        [_femaleButton setImage:[UIImage imageNamed:@"ic_female_normal"] forState:UIControlStateNormal];
        [_femaleButton setImage:[UIImage imageNamed:@"ic_female_selected"] forState:UIControlStateSelected];
        [_femaleButton addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _femaleButton;
}
-(GBLoginBottomButton *)joinInButton
{
    if (!_joinInButton) {
        _joinInButton = [[GBLoginBottomButton alloc] initWithFrame:CGRectMake(0, kChooseGenderDisplayHeight-kChooseGenderJoinInButtonHeight, CGRectGetWidth(self.view.frame)-kChoosGenderPadding*2, kChooseGenderJoinInButtonHeight)];
        [_joinInButton setTitle:@"加入救无聊" forState:UIControlStateNormal];
        [_joinInButton setTitleColor:UIColorFromRGB(0x3c4042) forState:UIControlStateNormal];
        [_joinInButton addTarget:self action:@selector(signUpAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _joinInButton;
}

#pragma Mark -- action
-(void)buttonAction:(UIButton *)sender
{
    if (self.currentButton && self.currentButton != sender) {
        self.currentButton.selected = NO;
    }
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.currentButton = sender;
    }else{
        self.currentButton = nil;
    }
}
-(void)signUpAction
{
    self.viewModel.signUpRequest.sex = (self.currentButton == self.maleButton) ? 1:0;
    self.viewModel.signUpRequest.requestNeedActive = YES;
}

#pragma Mark -- RAC
-(void)addRACSignal
{
    RAC(self.joinInButton,enabled)= [RACSignal combineLatest:@[RACObserve(self.maleButton, selected),RACObserve(self.femaleButton, selected)]
                                          reduce:^(NSNumber *selected1,NSNumber *selected2){
                                              return @([selected1 boolValue] || [selected2 boolValue]);}];

    
    [RACObserve(self.viewModel.signUpRequest, state) subscribeNext:^(id x) {
        if (self.viewModel.signUpRequest.failed) {
            [self showHUDText:self.viewModel.fetchVcodeRequest.message];
        }else if (self.viewModel.signUpRequest.sending){
            [self showProgress];
        }else if(self.viewModel.signUpRequest.succeed){
            [self.viewModel LoginIn:^(){
                [self hideProgress];
            }];
        }
    }];
}
@end
