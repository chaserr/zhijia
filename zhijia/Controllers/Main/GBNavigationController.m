//
//  GBNavigationContrller.m
//  zhijia
//
//  Created by admin on 15/7/17.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBNavigationController.h"

@interface GBNavigationController ()

@end

@implementation GBNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+ (void)initialize
{
    [self setupNavigationBarTheme];
    
    //[self setupBarButtonItemTheme];
}
+ (void)setupNavigationBarTheme {
    
    UINavigationBar *appearance = [UINavigationBar appearance];

    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    textAttrs[NSFontAttributeName] = GBNavigationBarFont(18);
    
    //[appearance setBackgroundImage:[UIImage imageWithName:@"navigation_bg"] forBarMetrics:UIBarMetricsDefault];
    [appearance setBarTintColor:[UIColor whiteColor]];
    textAttrs[NSShadowAttributeName] = [[NSShadow alloc] init];
    
    [appearance setTitleTextAttributes:textAttrs];
    appearance.tintColor = [UIColor blackColor];
    appearance.translucent = YES;
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    // 判断是否为栈底控制器
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
        //设置导航子控制器按钮的加载样式
//        UINavigationItem *vcBtnItem= [viewController navigationItem];
//        
//        vcBtnItem.leftBarButtonItem = [UIBarButtonItem BarButtonItemWithImageName:@"navigationbar_back_withtext" highImageName:@"navigationbar_back_withtext_highlighted" title:[[self.childViewControllers lastObject] title] target:self action:@selector(back)];
//        vcBtnItem.backBarButtonItem = [[UIBarButtonItem alloc]
//                                                 initWithTitle:@""
//                                                 style:UIBarButtonItemStylePlain
//                                                 target:nil
//                                                 action:nil];
        
    }
    
    [super pushViewController:viewController animated:YES];
}
- (void)back
{
    [self popViewControllerAnimated:YES];
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
