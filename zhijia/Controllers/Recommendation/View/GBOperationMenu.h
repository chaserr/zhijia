//
//  GBOperationMenu.h
//  zhijia
//
//  Created by 童星 on 16/5/25.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBOperationMenu : UIView

@property (nonatomic, copy) void (^likeButtonClickedOperation)();
@property (nonatomic, copy) void (^commentButtonClickedOperation)();
@property (nonatomic, copy) void (^shareButtonClickedOperation)();
@property (nonatomic, copy) void (^flowerButtonClickedOperation)();

@end
