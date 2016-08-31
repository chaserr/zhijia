//
//  GBImageView.m
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBImageView.h"
#import "GBUserSpaceViewController.h"
@interface GBImageView (){

    UIButton*                   _actionBtn;

}

@end

@implementation GBImageView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _isCornerRadius = YES;
    // Initialization code
    [self setup];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _isCornerRadius = YES;
        [self setup];
    }
    return self;
}

- (void)setup
{
    CGRect rect = self.bounds;
    if (_isCornerRadius) {
        [self operationCornerRadius];
    }
    
//    _placeholder = [UIImage imageNamed:@"avatar_default_small"];
    // 图片
    _imageView = [[UIImageView alloc] initWithFrame:rect];
    _imageView.userInteractionEnabled = YES;
    _imageView.backgroundColor = [UIColor clearColor];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageView setClipsToBounds:YES];
    _imageView.image = _placeholder;
    [self addSubview:_imageView];
    
    // 图片遮罩
    _maskImageView = [[UIImageView alloc] initWithFrame:rect];
    _maskImageView.backgroundColor = [UIColor clearColor];
    _maskImageView.image = [UIImage imageNamed:@"mask_circle"];
    _maskImageView.userInteractionEnabled = YES;
    _maskImageView.hidden = YES;
    [self addSubview:_maskImageView];
    
    
    // 接收点击事件
    _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _actionBtn.frame = rect;
    _maskImageView.backgroundColor = [UIColor clearColor];
    [_actionBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    _actionBtn.hidden = YES;
    [self addSubview:_actionBtn];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    CGRect rect = self.bounds;
    
    // 图片
    _imageView.frame = rect;
    
    // 图片遮罩
    _maskImageView.frame = rect;
    
    // 接收点击事件
    _actionBtn.frame = rect;
}

- (void)setActionEnable:(BOOL)isEnable
{
    _actionBtn.hidden = !isEnable;
}

- (void) isclipImage:(BOOL) isCip
{
    if(isCip){
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }else {
        _imageView.contentMode = UIViewContentModeScaleToFill;
    }
    
}

-(void)setImage:(UIImage*)image
{
    if(nil == image)
        return;
    
    _imageView.image = image;
    [_imageView setNeedsDisplay];
}

-(void)setPlaceholder:(UIImage*)image
{
    if(nil == image)
        return;
    
    _placeholder = image;
    
    _imageView.image = _placeholder;
}

- (void)setImageUrl:(NSString *)url
{
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:_placeholder options:SDWebImageDelayPlaceholder];
//    BOOL result = NO;
//    UIImage* image = nil;
//
////    image = [[YYHttpTransferService getInstance] imageAtUrl:url];
//    
//    if(image == nil)
//    {
//        result = YES;
//        
//    }
    
//    if(result)
//    {
//        [self setImage:self.placeholder];
//        // 需要重新下载头像
//        if (_isLoadNotice == YES) {
//            [_activity startAnimating];
//            self.lockImageView.hidden = YES;
//        }
//        __weak __typeof(self)weakSelf = self;
//        [YY_CORE.contactsService getPortrait:url response:^(NSInteger result, NSDictionary *dict, YYError *error) {
//            
//            __strong __typeof(weakSelf)strongSelf =weakSelf;
//            if(result == EYYResponseResultSucceed)
//            {
//                if (_isLoadNotice == YES) {
//                    [_activity stopAnimating];
//                    self.lockImageView.hidden = NO;
//                }
//                UIImage* image = [dict objectForKey:YY_ATTR_R_PORTRAIT_IMAGE];
//                
//                if(nil == image)
//                    return;
//                
//                if (_isNeedBlur) {
//                    strongSelf.imageView.image = [UtilFunc blurImage:image];
//                }else{
//                    // 滚动停止，才去设置图片，防止卡顿
//                    [strongSelf.imageView performSelector:@selector(setImage:) withObject:image afterDelay:0 inModes:@[NSDefaultRunLoopMode]];
//                }
//                
//                strongSelf.imageView.alpha=0.2;
//                [UIView beginAnimations:nil context:NULL];
//                [UIView setAnimationDuration:0.5];
//                [strongSelf.imageView setNeedsDisplay];
//                strongSelf.imageView.alpha = 1;
//                [UIView commitAnimations];
//                
//                [strongSelf.imageView setNeedsDisplay];
//                
//                
//            }
//            else if (result == EYYResponseResultFailed)
//            {
//                UI_LOG(@"getPortrait failed");
//                if (_isLoadNotice == YES) {
//                    [_activity stopAnimating];
//                    self.lockImageView.hidden = NO;
//                }
//            }
//        }];
//    }
//    else
//    {
//        [self setImage:image];
//    }
    
}

- (void)btnClicked:(id)sender
{
    
    
    //    if (_isSetBorderAndColor) {
    //
    //        [self setBorderWidth:1.0f AndColor:[UIColor colorWithRed:0.9866 green:0.1678 blue:0.5052 alpha:0.7546875]];
    //    }
    
    // 管理员信:uid == 1
//    if (YYImageViewClickInterUserSpace == _clickType ) {
//        if(_uid && [_uid isEqualToString:APP_USER.userID] == NO && ![_uid isEqualToString:@"1"] && _gender != APP_USER.gender )
//        {
            GBUserSpaceViewController* controller = [[GBUserSpaceViewController alloc] init];
    controller.navigationController.navigationBarHidden = YES;
    
    [[self getCurrentViewController].navigationController pushViewController:controller animated:YES];
//            controller.uid = _uid;
//            controller.isSimple = _isSimple;
//            controller.userInfoBtnType = _userInfoBtnType;
//            [AppNavigator pushViewController:controller animated:YES];
//            //缘分页、官方话题、搜索、匹配问答、我参与的、聊天页
//            [self umengClick];
//            
//        }else if ([_uid isEqualToString:APP_USER.userID]){
//            
//        }else if (_gender == APP_USER.gender) {
//            YY_LOG(@"%d", APP_USER.gender);
//            [YYHUDVIEW showTips:@"同性之间不可以查看对方空间！"];
//        }
//    }
//    else  {
//        if ([self.delegate respondsToSelector:@selector(imageClick:)]){
//            [self.delegate imageClick:_index];
//        }
//    }
    
    
    
}

- (void)operationCornerRadius
{
    self.layer.cornerRadius = 4;
    self.clipsToBounds = YES;
}
@end
