//
//  YYShareToolViewConroller.m
//  YouYuanClient
//
//  Created by 童星 on 16/2/22.
//  Copyright © 2016年 SEU. All rights reserved.
//  微信分享

#define dismissAnimationTime 0.3
#import "YYShareToolViewConroller.h"
#import "WXApi.h"
#import "YYShareView.h"
#import "UMSocial.h"

#import "SendMessageToWXReq+requestWithTextOrMediaMessage.h"
#import "WXMediaMessage+messageConstruct.h"
#import "WXApiManager.h"
@interface YYShareToolViewConroller ()<YYShareViewDelegate>
@property (nonatomic, strong) UIButton      *backView;
@property (nonatomic, assign) BOOL        visible;;
@property (nonatomic, strong) YYShareView *shareView;

@end

@implementation YYShareToolViewConroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect mainScreenBounds = [UIScreen mainScreen].bounds;
    self.view.frame = mainScreenBounds;
    self.view.backgroundColor = [UIColor clearColor];
//    [self popShareView];

}

- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
//    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        [self downToUpShareView];
//    }else{
//        
//        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"当前手机没有安装微信客户端,请安装后再试" cancelButtonTitle:@"返回" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
//            [self.view removeFromSuperview];
//            [self removeFromParentViewController];
//            
//        }];
//    }

}

#pragma mark - 分享

- (void)initWhithTitle:(NSString *)title detailInfo:(NSString*)info
                 image:(UIImage *)image imageUrl:(NSString *)imageUrl{
    self.shareTitle = title;
    self.detailInfo = info;
    self.shareImage = image;
    self.shareImageURL = imageUrl;
    
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        [self popShareView];
    }else{
    
        [UIAlertView bk_showAlertViewWithTitle:@"提示" message:@"当前手机没有安装微信客户端,请安装后再试" cancelButtonTitle:@"返回" otherButtonTitles:nil handler:^(UIAlertView *alertView, NSInteger buttonIndex) {
            [self.view removeFromSuperview];
            [self removeFromParentViewController];
            
        }];
    }

}


- (void)downToUpShareView{

    self.backView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.shareView = [YYShareView createViewFromNibName:@"YYShareView"];
    _shareView.delegate = self;
    _shareView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 185);
//    _shareView.layer.cornerRadius = 5;
//    _shareView.layer.shadowOffset = CGSizeZero;
//    _shareView.layer.shadowOpacity = 0.3;
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    _shareView.transform = CGAffineTransformIdentity;
    _shareView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_shareView.bounds cornerRadius:_shareView.layer.cornerRadius].CGPath;
    [_backView addSubview:_shareView];
    
    [UIView animateWithDuration:dismissAnimationTime animations:^{
        _shareView.y = SCREEN_HEIGHT - 185;
    } completion:nil];
    
    [self.backView bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:dismissAnimationTime animations:^{
            _shareView.y = SCREEN_HEIGHT;
            self.backView.alpha = 0.1;

        } completion:^(BOOL finished) {
            [self.backView removeFromSuperview];
            [_shareView removeFromSuperview];

            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];
        
    } forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.shareView.closeBtn bk_addEventHandler:^(id sender) {
        [UIView animateWithDuration:dismissAnimationTime animations:^{
            _shareView.y = SCREEN_HEIGHT;
            self.backView.alpha = 0.1;
            
        } completion:^(BOOL finished) {
            [self.backView removeFromSuperview];
            [_shareView removeFromSuperview];

            [self.view removeFromSuperview];
            [self removeFromParentViewController];
        }];

    } forControlEvents:(UIControlEventTouchUpInside)];
    
}

- (void)popShareView{
    
    self.backView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    _backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    
    self.shareView = [YYShareView createViewFromNibName:@"YYShareView"];
    _shareView.delegate = self;
    _shareView.frame = CGRectMake((SCREEN_WIDTH - 300)*0.5, (SCREEN_HEIGHT - 214)*0.5 , 300, 214);
    _shareView.layer.cornerRadius = 5;
    _shareView.layer.shadowOffset = CGSizeZero;
    _shareView.layer.shadowOpacity = 0.3;
    [[UIApplication sharedApplication].keyWindow addSubview:_backView];
    _shareView.transform = CGAffineTransformIdentity;
    _shareView.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:_shareView.bounds cornerRadius:_shareView.layer.cornerRadius].CGPath;
    [_backView addSubview:_shareView];
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
    animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.5;
    animation.delegate = self;
    [_shareView.layer addAnimation:animation forKey:@"bouce"];
    
    [self.backView addTarget:self action:@selector(closeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.shareView.closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    

}
    

- (void)transitionOutCompletion:(void(^)(void))completion withBackView:(UIView *)view
{
    
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    animation.values = @[@(1), @(1.2), @(0.01)];
    animation.keyTimes = @[@(0), @(0.4), @(1)];
    animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
    animation.duration = 0.35;
    animation.delegate = self;
    [animation setValue:completion forKey:@"handler"];
    [view.layer addAnimation:animation forKey:@"bounce"];
    view.transform = CGAffineTransformMakeScale(0.01, 0.01);
}

- (void)closeAction:(UIButton *)sender{
    
    void (^dismissComplete)(void) = ^{
        self.visible = NO;
        [self.shareView removeFromSuperview];
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backView.alpha = 0.1;
        } completion:^(BOOL finished) {
            [self.backView removeFromSuperview];
        }];
    };
    
    if (!_visible) {
        [self transitionOutCompletion:dismissComplete withBackView:self.shareView];
    }else{
        
        dismissComplete();
    }
    
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    
}

#pragma mark - animation delegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    void(^completion)(void) = [anim valueForKey:@"handler"];
    if (completion) {
        completion();
    }
    
}



#pragma mark - ShareView Delegate
- (void)shareToDestinationType:(ShareToolType)shareToolType;
{

    switch (shareToolType) {
        case 0: //通过微信好友分享
            [self shareInformationWithType:kShareTool_WeiXinFriends];
            break;
        case 1: //通过微信朋友圈分享
            [self shareInformationWithType:kShareTool_WeiXinCircleFriends];
            break;
        case 2: //通过新浪微博分享
            [self shareInformationWithType:kShareTool_SinaWeibo];
            break;
        default:
            break;
    }
}

- (void)shareInformationWithType:(ShareToolType)shareToolType {
    switch (shareToolType) {
        case kShareTool_WeiXinFriends:{
            UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.gif"]]];
            UIImage *thumbImg = [self thumbImageWithImage:desImage limitSize:CGSizeMake(150, 150)];
            
            [self sendLinkURL:@"http://www.baidu.com" TagName:nil Title:@"测试" Description:@"仅仅是一个测试" ThumbImage:thumbImg InScene:WXSceneSession];

        }
            break;
        case kShareTool_WeiXinCircleFriends:{
            [UMSocialData defaultData].title = @"分享的title";
            [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";

            UIImage *desImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.baidu.com/img/bdlogo.gif"]]];
            UIImage *thumbImg = [self thumbImageWithImage:desImage limitSize:CGSizeMake(150, 150)];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享内嵌文字" image:thumbImg location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [STAlertView alertWithTitle:@"成功" message:@"分享成功" cancelButtonTitle:@"好" otherButtonTitles:nil cancelButtonBlock:nil otherButtonBlock:nil];
                }else{
                    [STAlertView alertWithTitle:@"抱歉" message:@"分享失败" cancelButtonTitle:@"好" otherButtonTitles:nil cancelButtonBlock:nil otherButtonBlock:nil];
                    
                }
            }];
        }
            break;
        case kShareTool_SinaWeibo:{
        
            
            [UMSocialData defaultData].extConfig.title = @"分享的title";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                                @"http://www.baidu.com/img/bdlogo.gif"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    
                    [STAlertView alertWithTitle:@"成功" message:@"分享成功" cancelButtonTitle:@"好" otherButtonTitles:nil cancelButtonBlock:nil otherButtonBlock:nil];
                }else{
                    
                    [STAlertView alertWithTitle:@"失败" message:@"抱歉" cancelButtonTitle:@"分享失败" otherButtonTitles:@"好" cancelButtonBlock:nil otherButtonBlock:nil];
                }
            }];
        }
            break;

        default:
            break;
    }
}



#pragma mark - weixin method

// 发送link消息给微信
- (void)sendLinkURL:(NSString *)urlString
            TagName:(NSString *)tagName
              Title:(NSString *)title
        Description:(NSString *)description
         ThumbImage:(UIImage *)thumbImage
            InScene:(enum WXScene)scene{
    
    WXWebpageObject *webObj = [WXWebpageObject object];
    webObj.webpageUrl = urlString;
    
    WXMediaMessage *message = [WXMediaMessage messageWithTitle:title Description:description Object:webObj MessageExt:nil MessageAction:nil ThumbImage:thumbImage MediaTag:nil];
    
    SendMessageToWXReq *req = [SendMessageToWXReq requestWithText:nil OrMediaMessage:message bText:NO InScene:scene];
    
    [WXApi sendReq:req];

    
}

// 发送text消息
- (void)sendText:(NSString *)text
         InScene:(enum WXScene)scene{
    
    SendMessageToWXReq *req = [SendMessageToWXReq requestWithText:text
                                                   OrMediaMessage:nil
                                                            bText:YES
                                                          InScene:scene];
    [WXApi sendReq:req];
    
    [self shareHasDone];
    
}

- (UIImage *)thumbImageWithImage:(UIImage *)scImg limitSize:(CGSize)limitSize
{
    if (scImg.size.width <= limitSize.width && scImg.size.height <= limitSize.height) {
        return scImg;
    }
    CGSize thumbSize;
    if (scImg.size.width / scImg.size.height > limitSize.width / limitSize.height) {
        thumbSize.width = limitSize.width;
        thumbSize.height = limitSize.width / scImg.size.width * scImg.size.height;
    }
    else {
        thumbSize.height = limitSize.height;
        thumbSize.width = limitSize.height / scImg.size.height * scImg.size.width;
    }
    UIGraphicsBeginImageContext(thumbSize);
    [scImg drawInRect:(CGRect){CGPointZero,thumbSize}];
    UIImage *thumbImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbImg;
}

- (void)shareHasDone{
    self.shareImage = nil;
    self.shareTitle = nil;
    self.shareImageURL = nil;
    self.detailInfo = nil;
    [UIView animateWithDuration:dismissAnimationTime animations:^{
        _shareView.y = SCREEN_HEIGHT;
        self.backView.alpha = 0.1;
        
    } completion:^(BOOL finished) {
        [self.backView removeFromSuperview];
        [_shareView removeFromSuperview];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
