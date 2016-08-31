//
//  AppDefine.h
//  zhijia
//
//  Created by 张浩 on 16/5/4.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#ifndef AppDefine_h
#define AppDefine_h


#define Global_tintColor [UIColor colorWithRed:0 green:(190 / 255.0) blue:(12 / 255.0) alpha:1]

#define Global_mainBackgroundColor SDColor(248, 248, 248, 1)

#define TimeLineCellHighlightedColor [UIColor colorWithRed:0.369 green:0.573 blue:0.733 alpha:1.000]




// 浏览大图返回小图界面
#define kNotificationBackSmallIcon                  @"kNotificationBackSmallIcon"

// 任何对服务器的请求如果失败都会发该通知给UI
#define kNotificationServerError                         @"kNotificationServerError"

//登陆监听
#define kNotificationLoginStateChanged              @"kNotificationLoginStateChanged"

//网络状态改变
#define KNotifcationNetworkReachabilityChanged      @"KNotifcationNetworkReachabilityChanged"

//前后台状态改变
#define KNotifcationApplicationDidEnterBackground   @"KNotifcationApplicationDidEnterBackground"
#define KNotifcationApplicationWillEnterForeground  @"KNotifcationApplicationWillEnterForeground"

//程序突然退出时发送界面通知
#define kNotificationWillTerminate                  @"kNotificationWillTerminate"

//获取地理位置完成
#define kNotificationGetLocationInfo                @"kNotificationGetLocationInfo"

//用户设置位置发生变化
#define kNotificationUserSetLocationChange          @"kNotificationUserSetLocationChange"

#define kNotificationMessageNoticeMessage           @"kNotificationMessageNoticeMessage"

//个人信息更新通知个人空间刷新信息
#define kNotificationMyInfoChangeNotify             @"kNotificationMyInfoChange"
typedef enum {
    YYScanImageComeMyPhoto = 1,
    YYScanImageComeUserSpace,
    YYScanImageComeReleaseDynimic,
    
} YYScanImageType;

typedef enum
{
    EYYAudioTypeUnknown                 = 0,              //未知类型
    EYYAudioTypeMP3                     = 1,              //MP3
    EYYAudioTypeAMR                     = 2,              //AMR
    EYYAudioTypeAAC                     = 3               //AAC
}EYYAudioType;

typedef enum : NSUInteger {
    EGBUploadPhotoType_portrait         =1,             //上传头像
    EGBUploadPhotoType_Default                          //上传普通图片
} EGBUploadPhotoType;

typedef enum : NSUInteger {
    GBShareBtnWithSina,
    GBShareBtnWithQzone,
    GBShareBtnWithWechat,
} GBShareBtnWithType;



#endif /* AppDefine_h */
