//
//  GBImageView.h
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface GBImageView : UIView
/** 头像 */
@property (nonatomic, strong) IBInspectable UIImageView* imageView;
/** 头像遮罩 */
@property (nonatomic, strong) IBInspectable UIImageView* maskImageView;
/** 占位图 */
@property (nonatomic, strong) IBInspectable UIImage* placeholder;
/** 是否显示遮罩 */
@property (nonatomic, assign) BOOL isShowMask;
/** 图片是否圆角图片 */
@property (nonatomic, assign) BOOL isCornerRadius;

@property (nonatomic, assign) id delegate;

@property (nonatomic, assign) NSInteger index;

/** 设置图片 */
- (void)setImage:(UIImage*)image;
/** 设置图片地址 */
- (void)setImageUrl:(NSString*)url;
/**设置是否接收点击事件,默认不接收;接收的话会跳转到对应的空间页面
 */
- (void)setActionEnable:(BOOL)isEnable;

- (void)updateContent:(NSDictionary*)contentDict withVC:(GBViewController*)viewController;
- (void) isclipImage:(BOOL) isCip;


@end
