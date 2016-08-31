//
//  GBLoginViewControl.h
//  zhijia
//
//  Created by nana on 16/3/19.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBLoginTextView.h"
#import "DeformationButton.h"

@interface GBLoginViewControl : UIViewController
@property (weak, nonatomic) IBOutlet UIView *loginView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginActiveIcon;
@property (weak, nonatomic) IBOutlet UIButton *cancelLoginBtn;
@property (weak, nonatomic) IBOutlet UITextField *loginAccountField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordField;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetPasswordBtn;
@property (weak, nonatomic) IBOutlet DeformationButton *loginBtn;
@property (weak, nonatomic) IBOutlet GBLoginTextView *userLoginBackView;
@property (weak, nonatomic) IBOutlet GBLoginTextView *passwordBackView;

@end
