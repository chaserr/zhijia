//
//  GBTabBarController.m
//  zhijia
//
//  Created by admin on 15/7/17.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBTabBarController.h"
#import "GBTabBar.h"

#import "GBProfileVC.h"
#import "GBDiscoveryVC.h"
#import "GBPlazaTC.h"
#import "GBRecommendationVC.h"
#import "GBMessageVC.h"
#import "UserCenter.h"
#import "GBHomeViewController.h"

@interface GBTabBarController ()

@end

@implementation GBTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.delegate = self;
    
    [self addAllChildVcs];
    
    [self addCustomTabBar];
    
    [self openIMClient];
}
+ (void)initialize
{
    [self setupTabbarTheme];
}
+ (void)setupTabbarTheme
{
    //设置底部tabbar的主题样式
    
//    UITabBarItem *appearance = [UITabBarItem appearance];
//    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -3.5f)];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName:GBTabbarFont(12.0f)} forState:UIControlStateNormal];
    
    [[UITabBar appearance] setTintColor:[UIColor colorWithWhite:0.312 alpha:1.000]];
    [[UITabBar appearance] setBarTintColor:[UIColor whiteColor]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)addAllChildVcs
{
    GBHomeViewController *home = [[GBHomeViewController alloc] init];
//    GBRecommendationVC *home = [[GBRecommendationVC alloc] init];
    [self addOneChildVc:home title:@"职加" imageName:@"icon_beside_normal"selectedImageName:@"icon_beside_highlight"];
    
    GBMessageVC *message = [[GBMessageVC alloc] init];
    [self addOneChildVc:message title:@"hi信" imageName:@"icon_hi_normal" selectedImageName:@"icon_hi_highlight"];
    
    GBDiscoveryVC *discoverVC = [[GBDiscoveryVC alloc] init];
    [self addOneChildVc:discoverVC title:@"身边" imageName:@"icon_discover_normal" selectedImageName:@"icon_discover_highlight"];
    
    
    GBProfileVC *profile = [[GBProfileVC alloc] init];
    [self addOneChildVc:profile title:@"我的" imageName:@"icon_me_normal" selectedImageName:@"icon_me_normal"];
    

}
- (void)addCustomTabBar {
    
//    GBTabBar *customTabBar = [[GBTabBar alloc] init];
//    
//    [self setValue:customTabBar forKey:@"tabBar"];
}
- (void)addOneChildVc:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName {
    
    //设置标题
    childVc.title = title;

    childVc.tabBarItem.image = [UIImage imageNamed:imageName];

    UIImage *selectedImage = [UIImage imageNamed:selectedImageName];
    if (IOS_7_OR_LATER) {
        
        selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
    }
    childVc.tabBarItem.selectedImage = selectedImage;
    
    GBNavigationController *nav = [[GBNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
}
-(void)openIMClient
{
    NSLog(@"ID:%@",[UserCenter sharedInstance].userID);
//    if([UserCenter sharedInstance].userID){
//        //WEAKSELF
//        [CDChatManager manager].userDelegate = [CDIMService service];
//        [[CDChatManager manager] openWithClientId:[UserCenter sharedInstance].userID callback: ^(BOOL succeeded, NSError *error) {
//            
//            if (!succeeded) {
//                DLog(@"%@",error);
//                [GBUtils showTextDialog:self.view message:[NSString stringWithFormat:@"通讯链接失败:%@",[error localizedDescription]]];
//            }else{
//                [GBUtils showTextDialog:self.view message:@"接入成功,现在可以愉快的聊天啦"];
//            }
//        }];
//    }
}


#pragma mark -- UITabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController NS_AVAILABLE_IOS(3_0){

    return YES;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{

    [AppNavigator getInstance].mainNav = (UINavigationController *)viewController;

    
}


@end
