//
//  YYShareView.m
//  YouYuanClient
//
//  Created by 童星 on 16/2/22.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import "YYShareView.h"
//#import "UIView+TYAlertView.h"

@interface YYShareView ()
@property (weak, nonatomic) IBOutlet UIButton *weixinFriends;
@property (weak, nonatomic) IBOutlet UIButton *weixinCircleFriends;

@end
@implementation YYShareView

+ (instancetype)createViewFromNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nib objectAtIndex:1];
}

+ (instancetype)createViewFromNib
{
    return [self createViewFromNibName:NSStringFromClass(self.class)];
}

- (IBAction)shareToWinXinFriends:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(shareToDestinationType:)]) {
        [_delegate shareToDestinationType:kShareTool_WeiXinFriends];
    }
}

- (IBAction)shareToWinXinCircleFriends:(id)sender {
    
    if ([_delegate respondsToSelector:@selector(shareToDestinationType:)]) {
        [_delegate shareToDestinationType:kShareTool_WeiXinCircleFriends];
    }
}


- (IBAction)shareToSinaWeibo:(UIButton *)sender {
    if ([_delegate respondsToSelector:@selector(shareToDestinationType:)]) {
        [_delegate shareToDestinationType:kShareTool_SinaWeibo];
    }
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
