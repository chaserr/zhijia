//
//  GBMediumViewController.m
//  zhijia
//
//  Created by 张浩 on 16/5/16.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBMediumViewController.h"
#import "CAPSPageMenu.h"
#import "Test1ViewController.h"
#import "CustomTakePhotoViewController.h"
#import "SCCaptureCameraController.h"
@interface GBMediumViewController ()
@property (nonatomic) CAPSPageMenu *pageMenu;


// 自定义半透明模糊导航条
@property (nonatomic, strong) UIVisualEffectView *visualEfView;
@property (nonatomic, strong) UIButton           *backLeftBtn;
@property (nonatomic, strong) UIButton           *cameraBtn;
@property (nonatomic, strong) UIView *navigationBarView;
@property (nonatomic, strong) UILabel *navBarTitleLabel;


@end

@implementation GBMediumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (!self.navigationController) {
        if ([UIApplication sharedApplication].statusBarHidden == NO) {
            //iOS7，需要plist里设置 View controller-based status bar appearance 为NO
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
        }
    }
//    [self setupNavbarView];
//    [self setupNavbarButtons];
    
    
    Test1ViewController *controller1 = [[Test1ViewController alloc] init];
    controller1.title = @"照片";
    CustomTakePhotoViewController *vedioVC = [[CustomTakePhotoViewController alloc]init];
    vedioVC.title = @"视频";
    @WeakObj(self);
    vedioVC.recordVedioBlock = ^(NSURL *vedioPath){
    
        @StrongObj(self);
        if (vedioPath) {
            self.mediumDataBlock(nil, vedioPath);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    };
    
    SCCaptureCameraController *con = [[SCCaptureCameraController alloc] init];
    
    con.dismissBlock = ^(UIImage *takePhotoImage){
    
        @StrongObj(self);
        if (UIImagePNGRepresentation(takePhotoImage) == nil) {
            
            self.mediumDataBlock(UIImageJPEGRepresentation(takePhotoImage, 1), nil);
            
        } else {
            
            self.mediumDataBlock(UIImagePNGRepresentation(takePhotoImage), nil);
        }
        [self dismissViewControllerAnimated:YES completion:nil];

        
    };
    NSArray *controllerArray = @[con,vedioVC, controller1];

    NSDictionary *parameters = @{
                                 CAPSPageMenuOptionScrollMenuBackgroundColor: [UIColor blackColor],
                                 CAPSPageMenuOptionViewBackgroundColor: [UIColor blackColor],
                                 CAPSPageMenuOptionSelectionIndicatorColor: [UIColor clearColor],
                                 CAPSPageMenuOptionBottomMenuHairlineColor: [UIColor clearColor],
                                 CAPSPageMenuOptionMenuItemFont: [UIFont fontWithName:@"HelveticaNeue" size:13.0],
                                 CAPSPageMenuOptionMenuHeight: @(20.0),
                                 CAPSPageMenuOptionMenuItemWidth: @(90.0),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES),
                                 CAPSPageMenuOptionCenterMenuItems: @(YES),
                                 CAPSPageMenuOptionEnableHorizontalBounce: @(NO),
                                 CAPSPageMenuOptionSelectedMenuItemLabelColor:[UIColor colorWithRed:1.000 green:0.824 blue:0.022 alpha:1.000],
                                 };
    
    _pageMenu = [[CAPSPageMenu alloc] initWithViewControllers:controllerArray frame:CGRectMake(0.0, 0, self.view.frame.size.width, self.view.frame.size.height) options:parameters];
    _pageMenu.view.backgroundColor = [UIColor clearColor];
    _pageMenu.centerMenuItems = YES;
    [self.view addSubview:_pageMenu.view];
}


#pragma mark -- Action

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    if ([UIApplication sharedApplication].statusBarHidden == YES) {
        //iOS7，需要plist里设置 View controller-based status bar appearance 为NO
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    }
}

- (void)setupNavbarView
{
    CGRect naviBarRect = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    
    _navigationBarView= [[UIView alloc] initWithFrame:naviBarRect];
    _navigationBarView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_navigationBarView];
    
//    self.visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
//    _visualEfView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _navigationBarView.height);
//    _visualEfView.alpha = 1;
//    [_navigationBarView addSubview:_visualEfView];
    
    CGRect navBarTitleRect = [UtilFunc bottomCenterRect:naviBarRect width:250 height:44 offset:0];
    navBarTitleRect = CGRectInset(navBarTitleRect, 0, 8);
    _navBarTitleLabel = [[UILabel alloc] initWithFrame:navBarTitleRect];
    _navBarTitleLabel.textColor = [UIColor whiteColor];
    //    _navBarTitleLabel.text = @"露脸";
    _navBarTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_navBarTitleLabel setFont:GBBoldFont(18)];
    [_navigationBarView addSubview:_navBarTitleLabel];
    
}

// 导航
- (void)setupNavbarButtons
{
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
//    UIImage *backImage = [UIImage imageNamed:@"userinfo_navigationbar_back_withtext"];
    //    UIImage* image = [UIImage imageNamed:@"common_navbar_back"];
    [buttonBack setTitle:@"取消" forState:(UIControlStateNormal)];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 44);
    rect = [UtilFunc bottomRect:rect height:44 offset:0];
    rect = CGRectInset(rect, 12, 4);
    
    buttonBack.frame = CGRectMake(10, 0, 50,44);
    buttonBack.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
//    [buttonBack setImage:backImage forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.backLeftBtn = buttonBack;
    [self.view addSubview:buttonBack];
    
//    // 更多按钮()
//    _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
//    rect = [UtilFunc bottomRect:rect height:44 offset:0];
//    rect = CGRectInset(rect, 12, 4);
//    
//    CGRect moreBtnRects = CGRectMake( (SCREEN_WIDTH - 38) - 10, 20 , 38, 44);
//    _cameraBtn.frame = moreBtnRects;
//    [_cameraBtn setImage:[UIImage imageNamed:@"userspace_share"] forState:UIControlStateNormal];
//    [_cameraBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_cameraBtn];
    
}

- (void)backBtnClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
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
