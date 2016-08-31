//
//  AppNavigator.m
//  zhijia
//
//  Created by 张浩 on 16/5/5.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "AppNavigator.h"
#import "AppDelegate.h"
#import "GBLoginViewControl.h"
#import "GBStartPageVC.h"
#import "GBRegistFirstViewController.h"
static AppNavigator * navigator = nil;

@implementation AppNavigator

@synthesize mainNav = _mainNav;

#pragma mark - instance method

+ (AppNavigator*)getInstance
{
    @synchronized(self)
    {
        if (navigator == nil)
        {
            navigator = [[AppNavigator alloc] init];
            
        }
    }
    return navigator;
}


+ (void)showModalViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    UIViewController *presentCon = [[AppNavigator getInstance].mainNav presentedViewController];
    
    if (presentCon && [presentCon isKindOfClass:[GBNavigationController class]])
    {
        [(GBNavigationController*)presentCon presentViewController:viewController animated:animated completion:Nil];
    }
    else
    {
        [[AppNavigator getInstance].mainNav presentViewController:viewController animated:animated completion:Nil];
    }
    
}

+ (void)openMainNavControllerWithRoot:(UIViewController *)rootViewController
{
    AppDelegate* delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    
    animation.duration = 0.3;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.type = kCATransitionFade;
    animation.subtype = kCATransitionFromRight;
    [delegate.window.layer addAnimation:animation forKey:@"animation"];
    
//    GBNavigationController* nav = [[GBNavigationController alloc] initWithRootViewController:rootViewController];
    
    delegate.window.rootViewController = rootViewController;
//    [AppNavigator getInstance].mainNav = nav;
    
}

+ (void)pushViewController:(UIViewController*)viewController animated:(BOOL)animated
{
    // 如果不使用系统默认动画的话那么就使用自定义的淡入淡出动画
    if(animated == NO)
    {
        AppDelegate* delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        animation.type = kCATransitionFade;
        animation.subtype = kCATransitionFromRight;
        
        [delegate.window.layer addAnimation:animation forKey:@"animation"];
    }
    
    UIViewController *presentCon = [AppNavigator getInstance].mainNav;
    if (presentCon && [presentCon isKindOfClass:[GBNavigationController class]])
    {
        [(GBNavigationController*)presentCon pushViewController:viewController animated:animated];
    }
    else
    {
        [[AppNavigator getInstance].mainNav pushViewController:viewController animated:animated];
    }
}

+ (void)pushViewController:(UIViewController*)viewController withCurrentView:(UIView *)view animated:(BOOL)animated
{
    // 如果不使用系统默认动画的话那么就使用自定义的淡入淡出动画
    if(animated == NO)
    {
        AppDelegate* delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.5;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        animation.type = kCATransitionFade;
        animation.subtype = kCATransitionFromRight;
        
        [delegate.window.layer addAnimation:animation forKey:@"animation"];
    }
    
    GBNavigationController *nav = (GBNavigationController *)[view getCurrentViewController].navigationController;
    [nav pushViewController:viewController animated:YES];
    
    
}



+ (void)popViewControllerAnimated:(BOOL)animated
{
    // 如果不使用系统默认动画的话那么就使用自定义的淡入淡出动画
    if(animated == NO)
    {
        AppDelegate* delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        CATransition *animation = [CATransition animation];
        animation.delegate = self;
        animation.duration = 0.3;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.type = kCATransitionFade;
        animation.subtype = kCATransitionFromRight;
        
        [delegate.window.layer addAnimation:animation forKey:@"animation"];
    }
    
    UIViewController *presentCon = [[AppNavigator getInstance].mainNav presentedViewController];
    if (presentCon && [presentCon isKindOfClass:[GBNavigationController class]])
    {
        [(GBNavigationController*)presentCon popViewControllerAnimated:animated];
    }
    else
    {
        [[AppNavigator getInstance].mainNav popViewControllerAnimated:animated];
    }
}

+ (void)popToRootViewControllerAnimated:(BOOL)animated
{
    [[AppNavigator getInstance].mainNav popToRootViewControllerAnimated:animated];
}

+ (void)popToViewController:(UIViewController *) viewController animated:(BOOL)animated
{
    [[AppNavigator getInstance].mainNav popToViewController:viewController animated:animated];
}

/**
 *  打开tabBarViewcontroller界面
 */
+ (void)openMainViewController
{
    
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [main instantiateInitialViewController];
    [self openMainNavControllerWithRoot:viewController];
}

/**
 *  打开选择登陆注册页面
 */
+ (void)openStartPageViewController{
    
    GBStartPageVC* viewController = [[GBStartPageVC alloc] init];
    GBNavigationController* nav = [[GBNavigationController alloc] initWithRootViewController:viewController];
    [AppNavigator getInstance].mainNav = nav;
    [self openMainNavControllerWithRoot:nav];
}

/**
 *	打开登陆界面
 */
+ (void)openLoginViewController{

    GBLoginViewControl * viewController = [[GBLoginViewControl alloc] initWithNibName:@"GBLoginViewControl" bundle:nil];
    GBNavigationController* nav = [[GBNavigationController alloc] initWithRootViewController:viewController];
    [AppNavigator getInstance].mainNav = nav;

    [self openMainNavControllerWithRoot:nav];

}

/**
 *	打开注册界面
 */
+ (void)openRegisterViewController{

    GBRegistFirstViewController *viewController = [[GBRegistFirstViewController alloc] init];
    GBNavigationController* nav = [[GBNavigationController alloc] initWithRootViewController:viewController];
    [AppNavigator getInstance].mainNav = nav;
    [self openMainNavControllerWithRoot:nav];


}

//获取当前viewcontroller
-(UIViewController *)getCurrentRootViewController {
    
    UIViewController *result;
    // Try to find the root view controller programmically
    // Find the top window (that is not an alert view or other window)
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
            {
                break;
            }
        }
    }
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
    {
        result = topWindow.rootViewController;
    }
    else
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    return result;
}
@end
