//
//  GBTitleOnBottomButton.h
//  zhijia
//
//  Created by 张浩 on 16/5/19.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface GBTitleOnBottomButton : UIButton

/** 图片和文字比例 */
@property (nonatomic, assign) CGFloat buttonImageRatio;

- (void)setTitle:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage;
@end
