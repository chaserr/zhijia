//
//  AppNavigator.h
//  zhijia
//
//  Created by 张浩 on 16/5/4.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APP_NAVIGATOR [AppNavigator getInstance]


@interface AppNavigator : NSObject
@property (nonatomic, strong) UINavigationController* mainNav;

+ (AppNavigator*)getInstance;
+ (void)showModalViewController:(UIViewController*)viewController animated:(BOOL)animated;
+ (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated;
+ (void)popToViewController:(UIViewController *) viewController animated:(BOOL)animated;
+ (void)popViewControllerAnimated:(BOOL)animated;
+ (void)popToRootViewControllerAnimated:(BOOL)animated;
+ (void)openMainNavControllerWithRoot:(UIViewController *)rootViewController;

/**
 *  根据view获取view所在的控制器的导航
 *
 *  @param viewController push-> vc
 *  @param view           currentView
 *  @param animated       animation
 */
+ (void)pushViewController:(UIViewController*)viewController withCurrentView:(UIView *)view animated:(BOOL)animated;


/**
 *	打开主界面
 */
+ (void)openMainViewController;

/**
 *	打开登陆界面
 */
+ (void)openLoginViewController;

/**
 *	打开注册界面
 */
+ (void)openRegisterViewController;

/**
 *  打开选择登陆注册页面
 */

+ (void)openStartPageViewController;
@end
