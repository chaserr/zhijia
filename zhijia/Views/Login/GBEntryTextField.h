//
//  GBEntryTextField.h
//  zhijia
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

static CGFloat kCDTextFieldCommonVerticalPadding = 10;
static CGFloat kCDTextFieldCommonHorizontalPadding = 10;

@interface GBEntryTextField : UITextField
@property (nonatomic, assign) CGFloat verticalPadding;
@property (nonatomic, assign) CGFloat horizontalPadding;
@end
