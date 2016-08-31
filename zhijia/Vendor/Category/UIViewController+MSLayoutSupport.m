//
//  UIViewController+MSLayoutSupport.m
//  zhijia
//
//  Created by admin on 15/8/1.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "UIViewController+MSLayoutSupport.h"

@implementation UIViewController (MSLayoutSupport)

- (id<UILayoutSupport>)ms_navigationBarTopLayoutGuide {
    if (self.parentViewController &&
        ![self.parentViewController isKindOfClass:UINavigationController.class]) {
        return self.parentViewController.ms_navigationBarTopLayoutGuide;
    } else {
        return self.topLayoutGuide;
    }
}

- (id<UILayoutSupport>)ms_navigationBarBottomLayoutGuide {
    if (self.parentViewController &&
        ![self.parentViewController isKindOfClass:UINavigationController.class]) {
        return self.parentViewController.ms_navigationBarBottomLayoutGuide;
    } else {
        return self.bottomLayoutGuide;
    }
}


@end
