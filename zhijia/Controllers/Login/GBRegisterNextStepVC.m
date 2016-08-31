//
//  GBRegisterNextStepVC.m
//  zhijia
//
//  Created by 张浩 on 16/5/19.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBRegisterNextStepVC.h"
#import "GBRegisteNextStepCell.h"
#import "MHDatePicker.h"
#import "GBTitleOnBottomButton.h"
#import "UUInputAccessoryView.h"
@interface GBRegisterNextStepVC ()<GBUploadPhotoDelegate,QBImagePickerControllerDelegate>
@property (strong, nonatomic) MHDatePicker *selectDatePicker;

@property (nonatomic, strong) UIButton* finishButon;
@property (nonatomic, strong) UIView* tableFootView;
@property (nonatomic, strong) UIView* tableHeaderView;
/** uploadPhotoBtn */
@property (nonatomic, strong) GBTitleOnBottomButton *uploadPhotoBtn;
/** showPortrait */
@property (nonatomic, strong) GBImageView *portraitImage;

@property (nonatomic, strong) NSMutableArray *cellTitleArray;

@end

@implementation GBRegisterNextStepVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self customlizeNavigationBarBackBtn];
    
    UIView *customTitleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 176, 46)];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 120, 46)];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = @"填写个人资料";
    UIButton *stepBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    stepBtn.frame = CGRectMake(CGRectGetMaxX(titleLabel.frame) + 5,  (46 - 18)*0.5, 35, 18);
    [stepBtn setTitle:@"2/2" forState:(UIControlStateNormal)];
    [stepBtn setBackgroundImage:[UIImage imageNamed:@"register_navigation_step"] forState:(UIControlStateNormal)];
    [stepBtn.titleLabel setFont:GBSystemFont(14)];
    [stepBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    stepBtn.userInteractionEnabled = NO;
    [customTitleView addSubview:stepBtn];
    [customTitleView addSubview:titleLabel];
    self.navigationItem.titleView = customTitleView;
    
    
    self.tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 70)];
    
    self.finishButon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _finishButon.frame = CGRectMake(20, 20, SCREEN_WIDTH - 40, 50);
    
    [_finishButon setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.783 green:0.794 blue:0.786 alpha:1.000]] forState:UIControlStateDisabled];
    [_finishButon setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:0.392 green:0.812 blue:1.000 alpha:1.000]] forState:(UIControlStateNormal)];
    [_finishButon setTitle:@"完成注册" forState:(UIControlStateNormal)];
    [_finishButon setTitleColor:[UIColor colorWithWhite:0.588 alpha:1.000] forState:(UIControlStateDisabled)];
    [_finishButon setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [_finishButon.titleLabel setFont:GBSystemFont(17)];
    _finishButon.layer.cornerRadius = 3;
    _finishButon.layer.masksToBounds = YES;
    _finishButon.adjustsImageWhenHighlighted = NO;
    [_finishButon addTarget:self action:@selector(registerAction:) forControlEvents:(UIControlEventTouchUpInside)];
    _finishButon.enabled = NO;
    [_tableFootView addSubview:_finishButon];
    
    self.tableView.tableFooterView = _tableFootView;
    
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 210)];
    self.portraitImage = [[GBImageView alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 142) * 0.5, CGRectGetMidY(_tableHeaderView.frame) - 142 * 0.5, 142, 142)];
    _portraitImage.backgroundColor = [UIColor whiteColor];
    self.uploadPhotoBtn = [[GBTitleOnBottomButton alloc] initWithFrame:CGRectMake(0, 0, 142, 142)];
    UIImage *normalImage = [UIImage imageNamed:@"registe_uploadPortrailt_camera"];
    [_uploadPhotoBtn setTitle:@"上传头像" image:normalImage selectImage:nil];
    _uploadPhotoBtn.center = _portraitImage.center;
    _uploadPhotoBtn.buttonImageRatio = 0.5;
    _uploadPhotoBtn.imageView.contentMode = UIViewContentModeBottom;
    [_uploadPhotoBtn addTarget:self action:@selector(uploadPhotoAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [_tableHeaderView addSubview:_portraitImage];
    [_tableHeaderView addSubview:_uploadPhotoBtn];
    self.tableView.tableHeaderView = _tableHeaderView;
    

}


#pragma mark -- UITableviewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.cellTitleArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    GBRegisteNextStepCell *cell = [GBRegisteNextStepCell cellWithTableView:tableView];
    cell.cellTitle.text = self.cellTitleArray[indexPath.row];

    [cell setCellContentWithIndexPath:indexPath];
    @WeakObj(self);
    cell.onTap = ^(GBRegisteNextStepCell *cell){
        @StrongObj(self);
        switch (indexPath.row) {
            case 0:{
            
                [cell.cellRightDetail bk_addEventHandler:^(id sender) {
                    
                    [[UUInputAccessoryView sharedInstance] showBlock:^(NSString *contentStr) {
                        
                        [cell.cellRightDetail setTitle:contentStr forState:(UIControlStateNormal)];
                        [cell.cellRightDetail setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
                        
                    } WithController:self];
                    
                } forControlEvents:(UIControlEventTouchUpInside)];
            }
            case 1:
            {
            
            cell.cellRightDetail.selected =!cell.cellRightDetail.selected;

            }
                break;
            case 2:
            {
                [self createDatePicker:cell];
            }
                break;
                
            default:
                break;
        }
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    GBRegisteNextStepCell *cell = [tableView cellForRowAtIndexPath:indexPath];

    switch (indexPath.row) {
        case 2:
        {
            
            [self createDatePicker:cell];

        }
            break;
            
        default:
            break;
    }
}


- (void)intoSelectView
{
    if ([UIDevice isHigherIOS8]) {
        QBImagePickerController *imagePickerController = [QBImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.mediaType = QBImagePickerMediaTypeAny;
        imagePickerController.allowsMultipleSelection = YES;
        imagePickerController.showsNumberOfSelectedAssets = YES;
        imagePickerController.maximumNumberOfSelection = 1;
        imagePickerController.minimumNumberOfSelection = 1;
        [self presentViewController:imagePickerController animated:YES completion:^{
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        }];
        
    }
    //    else {
    //        YYQBImagePickerController *imagePickerController = [YYQBImagePickerController new];
    //        imagePickerController.delegate = self;
    //        imagePickerController.allowsMultipleSelection = YES;
    //        imagePickerController.maximumNumberOfSelection = 6 - _imageArray.count;
    //        imagePickerController.minimumNumberOfSelection = 1;
    //        imagePickerController.filterType = QBImagePickerControllerFilterTypePhotos;
    //        imagePickerController.allowsMultipleSelection = YES;
    //        YYNavViewController * navieControrller = [[YYNavViewController alloc] initWithRootViewController:imagePickerController];
    //        [self presentViewController:navieControrller animated:YES completion:^{
    //
    //            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    //        }];
    //    }
}

-(void)selectedImage:(NSDictionary*)image{

    _uploadPhotoBtn.hidden = YES;
    [self.portraitImage setImage:[image objectForKey:@"image"]];
    
//    UIImage *acceptImage = image
}



#pragma mark -- Action
- (void)uploadPhotoAction:(UIButton *)sender{
    
    [[GBPhotoManager getInstance] setIsSelectMutibleImage:NO];
    [[GBPhotoManager getInstance] uploadPhoto:EGBUploadPhotoType_portrait];
    [[GBPhotoManager getInstance] setIsFromDynamic:YES];
    [[GBPhotoManager getInstance] setDelegate:self];
}

- (void)createDatePicker:(GBRegisteNextStepCell *)cell{

    _selectDatePicker = [[MHDatePicker alloc] init];
    _selectDatePicker.isBeforeTime = YES;
    [_selectDatePicker setMaxSelectDate:[NSDate new]];
    _selectDatePicker.datePickerMode = UIDatePickerModeDate;
    __weak typeof(self) weakSelf = self;
    [_selectDatePicker didFinishSelectedDate:^(NSDate *selectedDate) {
        
        NSString *contentStr = [weakSelf dateStringWithDate:selectedDate DateFormat:@"yyyy-MM-dd"];
        [cell.cellRightDetail setTitle:contentStr forState:(UIControlStateNormal)];
    }];
}

- (NSString *)dateStringWithDate:(NSDate *)date DateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    NSString *str = [dateFormatter stringFromDate:date];
    return str ? str : @"";
}

- (void)registerAction:(id)sender{

    DLog(@"完成注册");
    
}

- (void)backAction{
    
    [AppNavigator popViewControllerAnimated:YES];
}
// 懒加载
- (NSMutableArray *)cellTitleArray{
    
    if (!_cellTitleArray) {
        _cellTitleArray = [NSMutableArray arrayWithObjects:@"真实姓名", @"性别", @"生日", @"职业", nil];
        
    }
    return _cellTitleArray;
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
