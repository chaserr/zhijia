//
//  GBViewController.m
//  zhijia
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBViewController.h"

@interface GBViewController ()<UINavigationControllerDelegate>
@property(nonatomic, strong)UIButton *backButton;

@end

@implementation GBViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewControllerStyle = GBViewControllerStylePlain;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = YES; // 透明设置为YES

    // 滑动返回
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)])
    {
        self.navigationController.interactivePopGestureRecognizer.delegate = nil;
    }
    self.navigationController.delegate = self;

    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 176, 46)];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font =[UIFont boldSystemFontOfSize:18];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor = [UIColor colorWithWhite:0.306 alpha:1.000];
    titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    titleLabel.text = @"";
    self.navigationTitleLabel = titleLabel;
    self.navigationItem.titleView = titleLabel;
    
    self.navigationController.navigationBarHidden = NO;

}

- (void)dismissViewController:(id)sender {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

//-(void)setViewControllerStyle:(GBViewControllerStyle)viewControllerStyle
//{
//    _viewControllerStyle = viewControllerStyle;
//    
//    if (self.viewControllerStyle == GBViewControllerStylePresenting) {
//        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController:)];
//        [self.navigationItem.leftBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:GBBoldFont(15)} forState:UIControlStateNormal];
//    }
//    
//    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
//                                             initWithTitle:@""
//                                             style:UIBarButtonItemStylePlain
//                                             target:nil
//                                             action:nil];
//}

#pragma mark Navigation Text Button

- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    if ([UIDevice isHigherIOS7])
    {
        negativeSpacer.width = -10;
    }
    else
    {
        negativeSpacer.width = 4.0;
    }
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barButtonItem, nil];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    if ([UIDevice isHigherIOS7])
    {
        negativeSpacer.width = -10;
    }
    else
    {
        negativeSpacer.width = 4.0;
    }
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barButtonItem, nil];
}

- (UIBarButtonItem *)leftBarButtonItem
{
    if (self.navigationItem.leftBarButtonItems != nil && self.navigationItem.leftBarButtonItems.count == 0)
    {
        return nil;
    }
    
    return self.navigationItem.leftBarButtonItems.lastObject;
}

- (UIBarButtonItem *)rightBarButtonItem
{
    if (self.navigationItem.rightBarButtonItem != nil && self.navigationItem.rightBarButtonItems.count == 0)
    {
        return nil;
    }
    
    return self.navigationItem.rightBarButtonItems.lastObject;
}

- (void)customlizeNavigationBarBackBtn
{
    // 自定义返回按钮
    _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _backButton.frame = CGRectMake(0.0, 0.0, 50.0, 44.0);
    [_backButton setImage:[UIImage imageNamed:@"common_navbar_back"] forState:UIControlStateNormal];
    //做偏移操作
    _backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    //[backButton setBackgroundColor:[UIColor yellowColor]];
    UIBarButtonItem *backBarBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_backButton];
    backBarBtnItem.style = UIBarButtonItemStylePlain;
    
    [self setLeftBarButtonItem:backBarBtnItem];
}

-  (void) setBackButtonImage:(UIImage *)backImage
{
    [_backButton setImage:backImage forState:UIControlStateNormal];
    
}

- (void)backAction
{
//    [self.navigationController popViewControllerAnimated:YES];
    [AppNavigator popViewControllerAnimated:YES];
}
#pragma mark - util

-(void)alert:(NSString*)msg{
    UIAlertView *alertView=[[UIAlertView alloc]
                            initWithTitle:nil message:msg delegate:nil
                            cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

-(void)showNetworkIndicator{
    UIApplication* app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible=YES;
}

-(void)hideNetworkIndicator{
    UIApplication* app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible=NO;
}

-(void)showProgress{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideProgress{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(void)showHUDText:(NSString*)text{
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = text;
    //hud.margin=10.f;
    hud.removeFromSuperViewOnHide = YES;
    hud.animationType = MBProgressHUDAnimationZoomOut;
    hud.mode = MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
}

-(void)runInMainQueue:(void (^)())queue{
    dispatch_async(dispatch_get_main_queue(), queue);
}

-(void)runInGlobalQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), queue);
}

-(void)runAfterSecs:(float)secs block:(void (^)())block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, secs*NSEC_PER_SEC), dispatch_get_main_queue(), block);
}

@end
