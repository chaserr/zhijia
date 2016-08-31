//
//  GBChooseGenderVC.h
//  zhijia
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//
static CGFloat kChoosGenderPadding = 15;
static CGFloat kChooseGenderDisplayHeight = 255;
static CGFloat kChooseGenderJoinInButtonHeight = 52;

static CGFloat kChooseGenderButtonPadding = 30;
static CGFloat kChooseGenderButtonSize = 63;
static CGFloat kChooseGenderTipsHeight = 20;
static CGFloat kChooseGenderTipsMargin = 30;
static CGFloat kChooseGenderButtonTitleHeight = 20;
static CGFloat kChooseGenderButtonTitleMarginTop = 5;

#import "GBViewController.h"
#import "GBSignUpViewModel.h"

@interface GBChooseGenderVC : GBViewController

@property(nonatomic,strong)GBSignUpViewModel *viewModel;

@end
