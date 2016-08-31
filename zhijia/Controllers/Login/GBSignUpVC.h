//
//  GBSignUpVC.h
//  zhijia
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

static CGFloat kSignUpPadding = 15;
static CGFloat kSignUpTextFieldHeight = 50;
static CGFloat kSignUpConfirmButtonHeight = 44;
static CGFloat kSignUpConfirmButtonTopMargin = 30;
static CGFloat kSignUpTipsLabelBottonMargin = 50;
static CGFloat kSignUpTipLabelHeight = 20;

#import "GBViewController.h"
#import "GBSignUpViewModel.h"

@interface GBSignUpVC : GBViewController

@property(nonatomic,strong)GBSignUpViewModel *viewModel;

@end
