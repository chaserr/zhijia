 //
//  GBEditMySelfDataIndexVC.m
//  zhijia
//
//  Created by 童星 on 16/3/16.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBEditMySelfDataIndexVC.h"
#import "GBSelectIndustryVC.h"
#import "GBSelectIndustryVC.h"
#import "GBMyInfoOfPortrialCell.h"
#import "GBMyInfoHaveDetailCell.h"
#import "GBMyInfoOfContactWayCell.h"
#import "GBFillMyTagsVC.h"
#import "GBFillPersonalSignature.h"
#import "YHCPickerView.h"
#import "GBFillJobExpVC.h"

@interface GBEditMySelfDataIndexVC ()<UITableViewDelegate,UITableViewDataSource,GBMyInfoHaveDetailCellDelegate,YHCPickerViewDelegate, UITextFieldDelegate>{

    GBSelectIndustryVC *industryVC;
    YHCPickerView *objYHCPickerView;

}
@property (nonatomic, strong) UITableView    *tableview;
@property (nonatomic, strong) NSMutableArray *sectionCountArray;
@property (nonatomic, strong) NSMutableArray *cellCountArray;
@property (nonatomic, strong) NSMutableArray *countriesArray;
@property (nonatomic, copy) NSString *detailString;


@end

@implementation GBEditMySelfDataIndexVC

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"common_pic_shadow_bg_highlighted"]];
    
    self.navigationTitleLabel.text = @"编辑资料";
    [self customlizeNavigationBarBackBtn];
    // 语法糖
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveMySelfData)];
        rightItem;
    });
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShowNotification:)
     name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillHideNotification:)
     name:UIKeyboardWillHideNotification object:nil];
    
    [self createTableView];
    
    [self refreshData];
    
 

}

- (void)refreshData{

    NSString *url = GB_CONFIG.getuserUrl;
    [GBNetworking postWithUrl:url params:nil success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseDict) {
        
        DLog(@"%@", responseDict);
        
    } fail:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        [GBHUDVIEW showTips:@"网络错误" autoHideTime:2];
    }];
}

- (void)registerTableViewCell{

    [self.tableview registerNib:[UINib nibWithNibName:@"GBMyInfoOfPortrialCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GBMyInfoOfPortrialCell"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"GBMyInfoHaveDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"profileOfDetailCellId"];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"GBMyInfoOfContactWayCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"profileOfContactCellId"];
}
- (void)createTableView{
    
    self.sectionCountArray = [NSMutableArray arrayWithObjects:@"基本信息", @"工作信息", @"联系方式", nil];
    NSArray *arrayWithBaseMsg = @[@"头像", @"真实姓名", @"年       龄", @"所属行业", @"公司名称", @"职        位", @"技能标签", @"个性签名"];
    NSArray *arrayWithJobMsg = @[@"工作年限", @"教育背景", @"工作经验", @"目前薪资"];
    NSArray *arrayWithContactWay = @[@"邮箱", @"手机号"];
    self.cellCountArray = [NSMutableArray arrayWithObjects:arrayWithBaseMsg, arrayWithJobMsg, arrayWithContactWay, nil];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = RGBCOLOR(240, 240, 240);
    _tableview.separatorInset = UIEdgeInsetsMake(0, 5, 0, 0);
//    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    _tableview.tableFooterView = [UIView new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self registerTableViewCell];

}

- (void)saveMySelfData{

    DLog(@"save message");
}

#pragma mark -  tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return _sectionCountArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [[_cellCountArray objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 50.0f;

    }else{
        
        return 60.0f;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    return [_sectionCountArray objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *profileOfContactCellId = @"profileOfContactCellId";
    NSString *profileOfMyDetailCellId = @"profileOfDetailCellId";
    NSString *profileOfMyProtrialCellId = @"GBMyInfoOfPortrialCell";
    UITableViewCell *cell ;

    if (indexPath.section == 0 && indexPath.row == 0) {
        
        GBMyInfoOfPortrialCell *portrialcell = [tableView dequeueReusableCellWithIdentifier:profileOfMyProtrialCellId forIndexPath:indexPath];
        cell = portrialcell;

    }
    else if (indexPath.section == 2){
    
        GBMyInfoOfContactWayCell *contactCell = [tableView dequeueReusableCellWithIdentifier:profileOfContactCellId forIndexPath:indexPath];

        [contactCell setContentMsgWithIndexPath:indexPath withTitleArr:_cellCountArray withParentController:self];

        cell = contactCell;
    }
    else {
    
        GBMyInfoHaveDetailCell *commonCell = [tableView dequeueReusableCellWithIdentifier:profileOfMyDetailCellId forIndexPath:indexPath];
        
        [commonCell setContentMsgWithIndexPath:indexPath withTitleArr:_cellCountArray withDetailString:_detailString withParentController:self];
        cell = commonCell;
    
    }
    

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        
        switch (indexPath.row) {
            case 0:
            {
                DLog(@"头像");
            }
                break;
            case 3:
            {
                industryVC = [[GBSelectIndustryVC alloc] init];
                [self.navigationController pushViewController:industryVC animated:YES];
                
            }
                break;
            case 6:
            {
                DLog(@"至少3个标签");
                GBFillMyTagsVC *fillTagVC = [[GBFillMyTagsVC alloc] init];
                [self.navigationController pushViewController:fillTagVC animated:YES];
                
            }
                break;
            case 7:
            {
                DLog(@"填写个人签名");
                GBFillPersonalSignature *fillPersonSign = [[GBFillPersonalSignature alloc] init];
                [self.navigationController pushViewController:fillPersonSign animated:YES];
            }
                break;
                
            default:
                break;
        }
    }else if(indexPath.section == 1){
    
        switch (indexPath.row) {
            case 1:
            {
                    objYHCPickerView = [[YHCPickerView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT ) withNSArray:self.countriesArray];
                    objYHCPickerView.delegate = self;
                    [self.view addSubview:objYHCPickerView];
                    [objYHCPickerView showPicker];
                
            }
                break;
            case 2:
            {
                DLog(@"填写工作经历");
                GBFillJobExpVC *fillJobExp = [[GBFillJobExpVC alloc] init];
                [self.navigationController pushViewController:fillJobExp animated:YES];
            }
                break;
                
            default:
                break;
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

//    [self.tableview endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)keyboardWillShowNotification:(id)notification{
    
    NSDictionary *userInfo = [notification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    //    int width = keyboardRect.size.width;
    
    
    objYHCPickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - height);
    [objYHCPickerView layoutIfNeeded];
    
}

-(void)keyboardWillHideNotification:(id)notification{
    
    objYHCPickerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    [objYHCPickerView layoutIfNeeded];

}

#pragma mark -- YHCPickerViewDelegate Method
-(void)selectedRow:(int)row withString:(NSString *)text{
    
    self.detailString = text;
    NSIndexPath *te=[NSIndexPath indexPathForRow:1 inSection:1];//刷新第2个section的第二行
    [self.tableview reloadRowsAtIndexPaths:[NSArray arrayWithObjects:te,nil] withRowAnimation:UITableViewRowAnimationNone];

}

#pragma mark -- UITextFieldDelegate Method
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    UITableViewCell *cell = CELL_SUBVIEW_TABLEVIEW(textField, self.tableview);
    if ([cell isKindOfClass:[GBMyInfoOfContactWayCell class ]]) {
        if ([((GBMyInfoOfContactWayCell *)cell).cellTitle.text isEqualToString:@"手机号"]) {
            
            if(![CommonUtils isValidateMobileNumber:textField.text]){
                
                TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"提示" message:@"请输入正确的手机号！"];
                
                [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
                    
                }]];
                
                TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationFade];
                
                [alertController setDismissComplete:^{
                    textField.text = nil;
                }];
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }
        
        if ([((GBMyInfoOfContactWayCell *)cell).cellTitle.text isEqualToString:@"邮箱"]) {
            
            if(![CommonUtils isValidateEMail:textField.text]){
                
                TYAlertView *alertView = [TYAlertView alertViewWithTitle:@"提示" message:@"请输入正确的邮箱！"];
                
                [alertView addAction:[TYAlertAction actionWithTitle:@"确定" style:TYAlertActionStyleDestructive handler:^(TYAlertAction *action) {
                    
                }]];
                TYAlertController *alertController = [TYAlertController alertControllerWithAlertView:alertView preferredStyle:TYAlertControllerStyleAlert transitionAnimation:TYAlertTransitionAnimationFade];
                
                [alertController setDismissComplete:^{
                    textField.text = nil;
                }];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }

        }
    }else if ([cell isKindOfClass:[GBMyInfoHaveDetailCell class]]){
    
        if (((GBMyInfoHaveDetailCell *)cell).rightMarginConsTocell.active) {
            ((GBMyInfoHaveDetailCell *)cell).rightMarginConsTocell.constant = 5;
        }
    }

}


// 懒加载
- (NSMutableArray *)countriesArray{

    if (!_countriesArray) {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"school" ofType:@"plist"];
        _countriesArray = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    }
    return _countriesArray;
}

- (void)backAction{

    [self.navigationController popViewControllerAnimated:YES];
}


@end
