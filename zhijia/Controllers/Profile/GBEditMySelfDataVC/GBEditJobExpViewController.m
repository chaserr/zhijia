//
//  EditJobExpViewController.m
//  zhijia
//
//  Created by 张浩 on 16/5/4.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBEditJobExpViewController.h"
#import "GBEditJobExpCell.h"
#import "GBFillJobContentDesCell.h"
#import "KMDatePicker.h"
@interface GBEditJobExpViewController ()<UITextFieldDelegate,UITextViewDelegate, KMDatePickerDelegate,UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray * titleArray;
@property (nonatomic, strong) UITextField *txtFCurrent;
@property (nonatomic, strong) UIButton *backButton;



@end

@implementation GBEditJobExpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationTitleLabel.text = @"编辑工作经验";
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveJobInfo)];
        rightItem;
    });
    
    UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:self.backButton];

    [self setLeftBarButtonItem:backBarBtnItem];
    
//    self.navigationItem.leftBarButtonItem =({
//        UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"userinfo_navigationbar_back_withtext"] style:UIBarButtonItemStylePlain target:self action:@selector(backAction)];
//        backBarBtnItem;
//    });
//    self.tableView.scrollEnabled = NO;
    self.tableView.tableFooterView = [UIView new];

    [self registerTableViewCell];

    
}

#pragma mark -- TableviewDelegate method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        
        return self.titleArray.count;
        
    }else{
    
        return 1;
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }else{
    
        return 45;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = nil;
    if (section == 1) {
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH - 20, 45)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont systemFontOfSize:16];
        label.text = @"工作内容描述";
        
        [view addSubview:label];
        
    }
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 50;
    }else{
    
        return 150;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *editJobExpCellId = @"GBEditJobExpCell";
    NSString *fillJobContentDesCellId = @"GBFillJobContentDesCell";
    UITableViewCell *cell ;

    switch (indexPath.section) {
        case 0:
        {
            GBEditJobExpCell *editJobExpCell = [tableView dequeueReusableCellWithIdentifier:editJobExpCellId forIndexPath:indexPath ];
            cell = editJobExpCell;
            
            [editJobExpCell setContentMsgWithIndexPath:indexPath withTitleArr:self.titleArray];
           
            if (indexPath.row == 3) {
                
                CGRect rect = [[UIScreen mainScreen] bounds];
                rect = CGRectMake(0.0, 0.0, rect.size.width, 216.0);
                
                // 年月日
                KMDatePicker *datePicker = [[KMDatePicker alloc]
                                            initWithFrame:rect
                                            delegate:self
                                            datePickerStyle:KMDatePickerStyleYearMonthYearMonth];
                editJobExpCell.detailContent.inputView = datePicker;
                _txtFCurrent = editJobExpCell.detailContent;

            }
            editJobExpCell.detailContent.delegate = self;

        
        }
            break;
            
        case 1:
        {
            GBFillJobContentDesCell *fillJobContentCell = [tableView dequeueReusableCellWithIdentifier:fillJobContentDesCellId forIndexPath:indexPath ];
            cell = fillJobContentCell;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width);
            [fillJobContentCell setContentMsgWithIndexPath:indexPath withTitleArr:nil];
            fillJobContentCell.contentDesc.delegate = self;

        }
            break;
            
            
        default:
            break;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0 && indexPath.row == 3) {

    }
}


#pragma mark -- TextFieldDelegate Method
- (void)textFieldDidBeginEditing:(UITextField *)textField {

}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField.text.length == 0) {
        return;
    }
    GBEditJobExpCell *cell = (GBEditJobExpCell *)[[textField superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                _jobExp.companyName = textField.text;
            }
                break;
            case 1:
            {
            
                _jobExp.departmentName = textField.text;

            }
                break;
            case 2:
            {
                _jobExp.jobPosition = textField.text;

            }
                break;
            case 3:
            {
                _jobExp.jobTime = textField.text;

            }
                break;
            default:
                break;
        }
    }
}

#pragma mark -- TextviewDelegate Method


- (void)textViewDidChange:(UITextView *)textView{
    GBFillJobContentDesCell *cell = (GBFillJobContentDesCell *)[[textView superview] superview];

    // 设置textView默认显示的文字
    if (textView.text.length == 0) {
        
        cell.placeholdLabel.hidden = NO;
    }else{
        
        cell.placeholdLabel.hidden = YES;
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        return;
    }
    _jobExp.jobContentDes = textView.text;

}

#pragma mark - KMDatePickerDelegate
- (void)datePicker:(KMDatePicker *)datePicker didSelectDate:(NSString *)datePickerDate {
    
    _txtFCurrent.text = datePickerDate;
}


#pragma mark -- Action
- (void)saveJobInfo{
    
    [self.view endEditing:YES];

    if (_jobExp.companyName ==nil || _jobExp.departmentName == nil || _jobExp.jobPosition == nil || _jobExp.jobTime == nil || _jobExp.jobContentDes == nil) {
        
        if (_jobExp.companyName == nil) {
            [MozTopAlertView showWithType:MozAlertTypeInfo text:@"请输入公司名称" parentView:self.view withAutoDuration:1.0f];
        }
        else if (_jobExp.departmentName == nil){
            
            [MozTopAlertView showWithType:MozAlertTypeInfo text:@"请输入部门名称" parentView:self.view withAutoDuration:1.0f];

            
        }
        else if (_jobExp.jobPosition == nil){
            [MozTopAlertView showWithType:MozAlertTypeInfo text:@"请输入职位名称" parentView:self.view withAutoDuration:1.0f];

            
        }else if (_jobExp.jobTime == nil){
            
            [MozTopAlertView showWithType:MozAlertTypeInfo text:@"请选择工作时间" parentView:self.view withAutoDuration:1.0f];

            
        }else{
            [MozTopAlertView showWithType:MozAlertTypeInfo text:@"请输入工作内容描述" parentView:self.view withAutoDuration:1.0f];
            
        }

    }else{
    
        self.updateJobExp(_jobExp);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)registerTableViewCell{
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GBEditJobExpCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GBEditJobExpCell"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"GBFillJobContentDesCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"GBFillJobContentDesCell"];
    
}

#pragma mark -- 懒加载
// 懒加载
- (NSMutableArray *)titleArray{
    
    if (!_titleArray) {
        _titleArray = [NSMutableArray arrayWithObjects:@"公司名称", @"所属部门", @"职位名称", @"任职时间", nil];
    }
    return _titleArray;
}

- (UIButton *)backButton{
    
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0.0, 0.0, 50.0, 44.0);
        [_backButton setImage:[UIImage imageNamed:@"userinfo_navigationbar_back_withtext"] forState:UIControlStateNormal];
        //做偏移操作
        _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}

- (void)backAction{

    [self.navigationController popViewControllerAnimated:YES];

//    [self alert:@"你没有保存，确定退出吗？"];
}



#pragma mark -- UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{

    switch (buttonIndex) {
        case 1:
        {
            [self.navigationController popViewControllerAnimated:YES];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.view endEditing:YES];
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    
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
