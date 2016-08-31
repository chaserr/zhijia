//
//  AppGlobal.h
//  zhijia
//
//  Created by 张浩 on 16/5/6.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#ifndef AppGlobal_h
#define AppGlobal_h

#define APP_DELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define WeakObj(o) autoreleasepool{} __weak typeof(o) o##Weak = o;
#define StrongObj(o) autoreleasepool{} __strong typeof(o) o = o##Weak;




/** 默认tabBar高度 */
#define PHONE_TABBAR_HEIGHT                 49
/** 默认toolBar高度 */
#define PHONE_TOOLBAR_HEIGHT                49
/** 默认keyboard高度 */
#define PHONE_KEYBOARD_HEIGHT               216
/** 默认section高度 */
#define PHONE_TABLE_SECTION_HEIGHT          24
/** 状态条高度 */
#define PHONE_STATUSBAR_HEIGHT              20
/** 默认导航条高度 */
#define PHONE_NAVIGATIONBAR_HEIGHT          44


/** 位置判别 */
#define INDEXPATH_SUBVIEW_TABLEVIEW(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
indexPath;\
})\

#define CELL_SUBVIEW_TABLEVIEW(subview,tableview)\
({\
CGRect subviewFrame = [subview convertRect:subview.bounds toView:tableview];\
NSIndexPath *indexPath = [tableview indexPathForRowAtPoint:subviewFrame.origin];\
UITableViewCell *cell=[tableview cellForRowAtIndexPath:indexPath];\
(id)cell;\
})\




// 色值

#define RGBCOLORV(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]


#define GB_COLOR_GRAY                        RGBCOLORV(0x8b8b8b)//(0x999999)
#define GB_COLOR_LIGHT_GRAY                  RGBCOLORV(0xcbcbcb)
#define GB_COLOR_THEME                       RGBCOLORV(0xff8b0a)//(0xf25e3d)//主色值
#define GB_COLOR_SEPERATE_LINE               RGBCOLORV(0xd9d9d9)
#define GB_COLOR_BACKGROUND                  RGBCOLORV(0xf0f0f0)
#define GB_COLOR_TEXT_GREEN                  RGBCOLORV(0x5dbe6d)
#define GB_COLOR_LINE_GRAY                   RGBCOLORV(0xdcdcdc)
#define GB_COLOR_TITLE_BLACK                 RGBCOLORV(0x3c3939)
#define GB_COLOR_DETAIL_GRAY                 RGBCOLORV(0x8b8b8b)
#define GB_COLOR_DETAIL_THEME                RGBCOLORV(0xcf9a8f)
#define GB_COLOR_DETAIL_TEXT                 RGBCOLORV(0xe1e0e0)

// 字体
/* 系统字体大小 */
#define GB_FONTSIZE_EXTRA_LARGE              30.0
#define GB_FONTSIZE_DETAIL_LARGE             20.0
#define GB_FONTSIZE_LARGE                    18.0
#define GB_FONTSIZE_MIDDLE                   16.0
#define GB_FONTSIZE_SMALL                    14.0
#define GB_FONTSIZE_COMMON                   13.0
#define GB_FONTSIZE_EXTRA_SMALL              12.0
#define GB_FONTSIZE_SMALLEST                 10.0
#define GB_FONTSIZE_MORE_SMALL               11.0








/** 快速查询一段代码的执行时间 */
/** 用法
 TICK
 do your work here
 TOCK
 */

#define TICK NSDate *startTime = [NSDate date];
#define TOCK NSLog(@"Time:%f", -[startTime timeIntervalSinceNow]);




#endif /* AppGlobal_h */
