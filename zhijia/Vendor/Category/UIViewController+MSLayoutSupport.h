//
//  UIViewController+MSLayoutSupport.h
//  zhijia
//
//  Created by admin on 15/8/1.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (MSLayoutSupport)

- (id<UILayoutSupport>)ms_navigationBarTopLayoutGuide;

- (id<UILayoutSupport>)ms_navigationBarBottomLayoutGuide;

@end
