//
//  GBFindPasswordVCViewController.m
//  zhijia
//
//  Created by 张浩 on 16/5/18.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBFindPasswordVC.h"
#import "GBFindPasswordCell.h"
@interface GBFindPasswordVC ()<UITextFieldDelegate>
@property (nonatomic , assign) int      secondsCount;
@property (nonatomic , retain) NSTimer  *timer;

/** placeholderArray */
@property (nonatomic, strong) NSMutableArray *placeholderArray;
@property (nonatomic, strong ) UIButton *verifyCodeBtn;

@property (nonatomic, strong) UIButton* finishButon;
@property (nonatomic, strong) UIView* tableFootView;

/** 存储每一个cell的textfield的内容 */
@property (nonatomic, strong) NSMutableDictionary *cellTextfieldText;


@end

@implementation GBFindPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self customlizeNavigationBarBackBtn];
    self.navigationTitleLabel.text = @"找回密码";
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.tableView.tableHeaderView = view;
    self.tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    
    self.finishButon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _finishButon.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, 50);
    _finishButon.backgroundColor = [UIColor colorWithRed:0.392 green:0.812 blue:1.000 alpha:1.000];
    [_finishButon setTitle:@"完成" forState:(UIControlStateNormal)];
    [_finishButon setTintColor:[UIColor whiteColor]];
    [_finishButon.titleLabel setFont:GBSystemFont(15)];
    _finishButon.layer.cornerRadius = 3;
    _finishButon.layer.masksToBounds = YES;
    _finishButon.adjustsImageWhenHighlighted = NO;
    [_finishButon addTarget:self action:@selector(finishAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_tableFootView addSubview:_finishButon];
    self.tableView.tableFooterView = _tableFootView;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- UITableviewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.placeholderArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 52;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GBFindPasswordCell *cell = [GBFindPasswordCell cellWithTableView:tableView];
    [cell setCellContentWithIndexPath:indexPath];
    cell.cellLetftDetail.placeholder = self.placeholderArray[indexPath.row];
    cell.cellLetftDetail.delegate = self;
    [cell.cellLetftDetail addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [cell.cellTextfieldClear addTarget:self action:@selector(clearTextFieldText:) forControlEvents:(UIControlEventTouchUpInside)];
    
    if (indexPath.row == 1) {
        
        self.verifyCodeBtn = cell.vertifyCodeBtn;
        [self.verifyCodeBtn addTarget:self action:@selector(getVerifyCode:) forControlEvents:(UIControlEventTouchUpInside)];
    }

    
    return cell;
}

#pragma mark -- TextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{

    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{


}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    GBFindPasswordCell *cell = CELL_SUBVIEW_TABLEVIEW(textField, self.tableView);

    [self.cellTextfieldText setValue:textField.text forKey:textField.placeholder];
    
    [cell.cellLeftImage setHighlighted:NO];

    if ([textField.placeholder isEqualToString:@"请再次输入密码"]) {
        
       NSString *tefieldText = [_cellTextfieldText objectForKey:@"请输入密码"];
        if (textField.text != tefieldText ) {
            [MozTopAlertView showWithType:MozAlertTypeInfo text:@"输入密码不一致，请重新填写" parentView:self.view withAutoDuration:1];

        }
    }
    
}


#pragma mark -- Action

- (void)finishAction:(UIButton *)sender{

    DLog(@"完成找回密码ANDInfo:%@", self.cellTextfieldText);
    
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

- (void)clearTextFieldText:(UIButton *)sender {
    
    GBFindPasswordCell *cell = CELL_SUBVIEW_TABLEVIEW(sender, self.tableView);

    cell.cellLetftDetail.text = nil;
    [self textFieldDidChange:cell.cellLetftDetail];
}

- (void)backAction{

    [AppNavigator popViewControllerAnimated:YES];
}
// 懒加载
- (NSMutableArray *)placeholderArray{
    
    if (!_placeholderArray) {
        _placeholderArray = [NSMutableArray arrayWithObjects:@"请输入手机号", @"请输入验证码", @"请输入密码", @"请再次输入密码", nil];
        
    }
    return _placeholderArray;
}

// 懒加载
- (NSMutableDictionary *)cellTextfieldText{
    
    if (!_cellTextfieldText) {
        _cellTextfieldText = [[NSMutableDictionary alloc] init];
    }
    return _cellTextfieldText;
}




@end
