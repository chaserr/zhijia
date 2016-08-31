//
//  GBHudView.m
//  zhijia
//
//  Created by 张浩 on 16/5/6.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBHudView.h"
#import "MBProgressHUD.h"

static GBHudView* instance = nil;
__unused static const CGFloat kProgressMin = 0.01f;

@interface GBHudView (Private)

- (void)setHudCaption:(NSString*)caption image:(UIImage*)image acitivity:(BOOL)bAcitve;
- (void)showHudAutoHideAfter:(NSTimeInterval)time;
- (void)hideHudTime:(NSString*)obj;

@end

@interface GBHudView ()

@property (nonatomic, strong) NSString* showingCaption;
@property (nonatomic, strong) MBProgressHUD* hud;
@property (nonatomic, strong) UIView* parentView;
@property (nonatomic, strong) NSString * title;

@end

@implementation GBHudView

+ (GBHudView*)getInstance
{
    @synchronized(self) {
        if (instance == nil)
        {
            instance = [[GBHudView alloc] init];
        }
    }
    return instance;
}

- (void)showTips:(NSString *)tips autoHideTime:(NSTimeInterval)autoHideTimeInterval
{
    [self showHudOnView:[[UIApplication sharedApplication].delegate  window] caption:tips image:nil acitivity:NO autoHideTime:autoHideTimeInterval];
}

- (void)showTips:(NSString *)tips
{
    [self showHudOnView:[[UIApplication sharedApplication].delegate  window] caption:tips image:nil acitivity:NO autoHideTime:1 ];
}

- (void)startAnimatingWithTitle:(NSString*)tilte
{
    _title = tilte;
    if (tilte)
    {
        [self showHudOnView:[[UIApplication sharedApplication].delegate window] caption:tilte image:nil acitivity:YES autoHideTime:0 ];
        
        //[self showHudOnView:[[UIApplication sharedApplication].delegate window] caption:tilte image:[UIImage imageNamed:@"hud_refresh_icon"] acitivity:YES autoHideTime:0];
        
    }
    else
    {
        [self showHudOnView:[[UIApplication sharedApplication].delegate window] caption:@"加载中" image:nil acitivity:YES autoHideTime:0 ];
        
        //[self showHudOnView:[[UIApplication sharedApplication].delegate window] caption:@"加载中" image:[UIImage imageNamed:@"hud_refresh_icon"] acitivity:YES autoHideTime:0];
        
    }
}
#pragma mark - public method
// 在window上显示hud
// 参数：
// caption:标题
// bActive：是否显示转圈动画
// time：自动消失时间，如果为0，则不自动消失
- (void)showHudOnWindow:(NSString*)caption
                  image:(UIImage*)image
              acitivity:(BOOL)bAcitve
           autoHideTime:(NSTimeInterval)time
{
    UIView* v = [[UIApplication sharedApplication].delegate window];
    [self showHudOnView:v
                caption:caption
                  image:image
              acitivity:bAcitve
           autoHideTime:time];
}

// 在当前的view上显示hud
- (void)showHudOnView:(UIView*)view
              caption:(NSString*)caption
                image:(UIImage*)image
            acitivity:(BOOL)bAcitve
         autoHideTime:(NSTimeInterval)time
{
    // 删除此view上原有的hud
    NSArray* array = [MBProgressHUD allHUDsForView:view];
    for (MBProgressHUD* obj in array) {
        [obj hide:NO];
    }
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = caption;
    
    if (!bAcitve)
    {
        hud.mode = MBProgressHUDModeText;
    }
    else
    {
        hud.mode = MBProgressHUDModeIndeterminate;
    }
    
    if (image != nil)
    {
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = [self rotate360DegreeWithImageView:[[UIImageView alloc] initWithImage:image]];
        
    }
    
    if (time > 0.0f)
    {
        [hud hide:YES afterDelay:time];
    }
    
    
}

- (void)showcaption:(NSString*)caption
              image:(UIImage*)image
           withTime:(NSInteger)time
{
    // 删除此view上原有的hud
    UIView* view = [[UIApplication sharedApplication].delegate window];
    NSArray* array = [MBProgressHUD allHUDsForView:view];
    for (MBProgressHUD* obj in array) {
        [obj hide:NO];
    }
    
    MBProgressHUD* hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = caption;
    
    
    if (image != nil) {
        hud.mode = MBProgressHUDModeCustomView;
        
        //将图标的尺寸变为原尺寸两倍
        CGRect imageRect = CGRectMake(0, 0, image.size.width * 2, image.size.height * 2);
        
        hud.customView = [[UIView alloc] initWithFrame:imageRect];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, hud.customView.width, hud.customView.height)];
        imageView.image = image;
        [hud.customView addSubview:imageView];
        
    }
    if (time == 0) {
        [hud hide:YES afterDelay:3];
    }
    else {
        [hud hide:YES afterDelay:time];
    }
    
}

- (UIImageView *)rotate360DegreeWithImageView:(UIImageView *)imageView
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    animation.byValue = @(M_PI*2);//M_PI/3
    animation.duration = 1.0;
    animation.repeatCount = INFINITY;
    animation.cumulative = YES;
    animation.removedOnCompletion = NO;
    
    //在图片边缘添加一个像素的透明区域，去图片锯齿
    CGRect imageRrect = CGRectMake(0, 0,imageView.frame.size.width, imageView.frame.size.height);
    UIGraphicsBeginImageContext(imageRrect.size);
    [imageView.image drawInRect:CGRectMake(1,1,imageView.frame.size.width-2,imageView.frame.size.height-2)];
    imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [imageView.layer addAnimation:animation forKey:nil];
    return imageView;
}

// 隐藏hud
- (void)hideHudInView:(UIView*)parentView
{
    NSArray* array = [MBProgressHUD allHUDsForView:parentView];
    for (MBProgressHUD* obj in array)
    {
        [obj hide:YES];
        [obj removeFromSuperview];
    }
}

- (void)hideHudInView:(UIView*)parentView after:(NSTimeInterval)time
{
    NSArray* array = [MBProgressHUD allHUDsForView:parentView];
    for (MBProgressHUD* obj in array)
    {
        [obj hide:YES afterDelay:time];
    }
}

#pragma mark - Centering Indicator View

- (void)placeAtTheCenterWithView:(UIView*)view
{
    CGSize windowSize = APP_DELEGATE.window.size;
    CGSize indicatorSize;
        indicatorSize = [view intrinsicContentSize];

    CGFloat x = (windowSize.width - indicatorSize.width) / 2;
    CGFloat y = (windowSize.height - indicatorSize.height) / 2;
    
    //    CGFloat x = (windowSize.width - 126) / 2;
    //    CGFloat y = (windowSize.height - 40) / 2;
    
    //    CGRect rect = CGRectMake(x, y, indicatorSize.width, indicatorSize.height);
    CGRect rect = CGRectMake(x, y, 126, 40);
    
    view.frame = rect;
}



@end
