//
//  GBHudView.h
//  zhijia
//
//  Created by 张浩 on 16/5/6.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//


#import <Foundation/Foundation.h>

#define GBHUDVIEW [GBHudView getInstance]
#define HUD_DEFAULT_HIDE_TIME 2.0f

@interface GBHudView : NSObject

+ (GBHudView*)getInstance;

- (void)showTips:(NSString*) tips autoHideTime:(NSTimeInterval)autoHideTimeInterval;
- (void)showTips:(NSString*) tips;
- (void)startAnimatingWithTitle:(NSString*)tilte;
- (void)showcaption:(NSString*)caption image:(UIImage*)image withTime:(NSInteger)time;


@end
