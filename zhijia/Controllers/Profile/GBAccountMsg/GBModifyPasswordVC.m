//
//  GBModifyPasswordVC.m
//  zhijia
//
//  Created by 张浩 on 16/5/6.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBModifyPasswordVC.h"
#import "GBModifyPasswordCell.h"
@interface GBModifyPasswordVC ()
@property (nonatomic , assign) int      secondsCount;
@property (nonatomic , retain) NSTimer  *timer;
@property (nonatomic, strong ) UIButton *verifyCodeBtn;
@property (nonatomic, strong) UILabel *verifyCodeLabel;
@property (nonatomic, strong) UIView *verifyCodeView;

@end

@implementation GBModifyPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.rowHeight = 50;
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self customlizeNavigationBarBackBtn];
    self.navigationTitleLabel.text = @"修改密码";
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"提交" style:UIBarButtonItemStylePlain target:self action:@selector(submitModifyPsd)];
        rightItem;
    });
    
}

#pragma mark -- tableviewDelegate Method

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

   return section == 0? 2: 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return section == 0? 15:20;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    GBModifyPasswordCell *cell = [GBModifyPasswordCell cellWithTableView:tableView withIdentifierStr:@"ModifyPasswordCellID"];
    [cell setContentMsgWithIndexPath:indexPath withDetailString:nil withParentController:self];

    if (indexPath.section == 0 && indexPath.row == 1) {
        
        self.verifyCodeLabel = cell.verifyCodeLabel;
        self.verifyCodeView = cell.vertifyView;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(getVerifyCode:)];
        [cell.verifyCodeLabel addGestureRecognizer:tap];
    }
    
    
    return cell;
}



#pragma mark -- action

- (void)getVerifyCode:(UITapGestureRecognizer *)sender{

    GBModifyPasswordCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    if ([cell.cellContent.text length] == 0) {
        
        [GBHUDVIEW showTips:@"请输入手机号" autoHideTime:1.0f];
    }
    else if(![CommonUtils isPhoneNumber:cell.cellContent.text] || cell.cellContent.text.length != 11){
    
        [GBHUDVIEW showTips:@"请输入正确的手机号" autoHideTime:1.0f];
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
    _verifyCodeLabel.text = [NSString stringWithFormat:@"%d秒后重新获取",_secondsCount];
    if (_secondsCount == 0) {
        [_timer invalidate];
        _verifyCodeLabel.text = [NSString stringWithFormat:@"获取验证码"];

        [_verifyCodeLabel setUserInteractionEnabled:YES];
    }
}

- (void)submitModifyPsd{

    DLog(@"提交修改后的密码");
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
