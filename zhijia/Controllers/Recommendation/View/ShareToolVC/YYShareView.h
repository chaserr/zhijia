//
//  YYShareView.h
//  YouYuanClient
//
//  Created by 童星 on 16/2/22.
//  Copyright © 2016年 SEU. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum {
    
    kShareTool_WeiXinFriends = 0, // 好友
    kShareTool_WeiXinCircleFriends, // 朋友圈
    kShareTool_SinaWeibo
}ShareToolType;

@protocol YYShareViewDelegate <NSObject>

- (void)shareToDestinationType:(ShareToolType)shareToolType;

@end

@interface YYShareView : UIView

@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

@property (nonatomic, assign)id<YYShareViewDelegate> delegate;

+ (instancetype)createViewFromNib;

+ (instancetype)createViewFromNibName:(NSString *)nibName;

@end
