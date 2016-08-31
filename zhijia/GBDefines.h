//
//  GBDefines.h
//  zhijia
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#ifndef zhijia_GBDefines_h
#define zhijia_GBDefines_h

//常用key

#define USE_US 0
#if !USE_US

#define AVOSAppID @"eezic9itl05w0iierbr02bschjgva8qmzjcjkzfmno2f18x9"
#define AVOSAppKey @"ekpng1ahbh8rxtqj34vpvzwqesw2aqjgmlwi4vuoj32v2o3f"

#else

#define AVOSAppID @""
#define AVOSAppKey @""
#endif

#define GBCommonColor                   UIColorFromRGB(0x3A3A3C)
#define GBTabbarColor                   UIColorFromRGB(0x1B1C1F)
#define GBTabbarFont(s)                 [UIFont fontWithName:@"Helvetica-Bold" size:s]
#define GBNavigationBarColor            UIColorFromRGB(0x1B1C1F)
#define GBNavigationBarFont(s)          [UIFont fontWithName:@"Kailasa-Bold" size:s]
#define GBFont(s)                       [UIFont fontWithName:@"Heiti SC" size:s]
#define GBBoldFont(s)                   [UIFont fontWithName:@"Helvetica-Bold" size:s]
#define GBSystemFont(s)                 [UIFont systemFontOfSize:s]

#define GBStarNavigationColor           [UIColor colorWithRed:59/255.0 green:64/255.0 blue:70/255.0 alpha:1.0]

#define RGBCOLOR(r, g, b) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : 1]
#define RGBACOLOR(r, g, b, a) [UIColor colorWithRed : (r) / 255.0 green : (g) / 255.0 blue : (b) / 255.0 alpha : (a)]
#define UIColorFromRGB(rgb) [UIColor colorWithRed : ((rgb) & 0xFF0000 >> 16) / 255.0 green : ((rgb) & 0xFF00 >> 8) / 255.0 blue : ((rgb) & 0xFF) / 255.0 alpha : 1.0]

#define RGBCOLORVA(rgbValue, alphaValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:alphaValue]

#define RGBRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define SCREEN_BOUNDS   [UIScreen mainScreen].bounds

#ifdef DEBUG
#define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ## __VA_ARGS__);
#else
#   define DLog(...)
#endif

#define WEAKSELF  typeof(self) __weak weakSelf = self;

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)
#define IOS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define APPLICATION  [UIApplication sharedApplication]

#define FROM_USER @"fromUser"
#define TO_USER @"toUser"
#define STATUS @"status"
#define INSTALLATION @"installation"
#define SETTING @"setting"

#define TOP_LAYOUT_LENGTH   64
#define BOTTOM_LAYOUT_LENGTH    49

#define GBFourInch ([UIScreen mainScreen].bounds.size.height < 568.0)

typedef void (^gb_block_1)();

#endif
