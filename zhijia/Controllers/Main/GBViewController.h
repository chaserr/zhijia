//
//  GBViewController.h
//  zhijia
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BaseVCDelegate <NSObject>

- (void)showNetworkIndicator;

- (void)hideNetworkIndicator;

- (void)showProgress;

- (void)hideProgress;

- (void)alert:(NSString *)msg;

- (void)runInMainQueue:(void (^)())queue;

- (void)runInGlobalQueue:(void (^)())queue;

- (void)runAfterSecs:(float)secs block:(void (^)())block;

- (void)showHUDText:(NSString *)text;

@end

typedef enum : NSInteger {
    GBViewControllerStylePlain = 0,
    GBViewControllerStylePresenting
}GBViewControllerStyle;

@interface GBViewController : UIViewController<BaseVCDelegate>
@property (nonatomic, strong) UILabel * navigationTitleLabel;

@property (nonatomic, assign) GBViewControllerStyle viewControllerStyle;

//设置返回按钮图片
- (void) setBackButtonImage:(UIImage *)backImage;
#pragma mark Navigation Text Button

- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem;
- (void)setRightBarButtonItem:(UIBarButtonItem *)barButtonItem;

- (UIBarButtonItem *)leftBarButtonItem;
- (UIBarButtonItem *)rightBarButtonItem;

- (void)customlizeNavigationBarBackBtn;

- (void)backAction;
//设置导航背景色
//- (void) setBarTintColor:(UIColor *) color;
@end
