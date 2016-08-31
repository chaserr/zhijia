//
//  GBOperationMenu.m
//  zhijia
//
//  Created by 童星 on 16/5/25.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBOperationMenu.h"

@interface GBOperationMenu ()
{
    UIButton *_likeButton;
    UIButton *_commentButton;
    UIButton *_flowerButton;
    UIButton *_shareButton;

}

@end
@implementation GBOperationMenu

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 5;
    self.backgroundColor = [UIColor whiteColor];
    _flowerButton = [UIButton new];
    [_flowerButton setTitleColor:[UIColor colorWithWhite:0.182 alpha:1.000] forState:(UIControlStateNormal)];
    [_flowerButton setTitle:@"67" forState:UIControlStateNormal];
    [_flowerButton setImage:[UIImage imageNamed:@"action01_s"] forState:UIControlStateNormal];
    [_flowerButton addTarget:self action:@selector(flowerButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _flowerButton.titleLabel.font = [UIFont systemFontOfSize:14];
    _flowerButton.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    
    _likeButton = [self creatButtonWithTitle:@"43" image:[UIImage imageNamed:@"action02"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(likeButtonClicked)];
    _commentButton = [self creatButtonWithTitle:@"65" image:[UIImage imageNamed:@"action03"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(commentButtonClicked)];
    _shareButton = [self creatButtonWithTitle:@"45" image:[UIImage imageNamed:@"action04"] selImage:[UIImage imageNamed:@""] target:self selector:@selector(shareButtonClicked)];

    
    [self sd_addSubviews:@[_flowerButton, _likeButton, _commentButton, _shareButton]];
    
    CGFloat margin = 0;
    
    _flowerButton.sd_layout
    .leftSpaceToView(self, margin)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthIs(50);
    
    _likeButton.sd_layout
    .leftSpaceToView(_flowerButton, margin)
    .topEqualToView(self)
    .bottomEqualToView(self)
    .widthRatioToView(_flowerButton, 1);
    
    
    _commentButton.sd_layout
    .leftSpaceToView(_likeButton, margin)
    .topEqualToView(self)
    .bottomEqualToView(_likeButton)
    .widthRatioToView(_likeButton, 1);

    
    _shareButton.sd_layout
    .leftSpaceToView(_commentButton, margin)
    .topEqualToView(self)
    .bottomEqualToView(_likeButton)
    .widthRatioToView(_likeButton, 1);
    
    [self setupAutoWidthWithRightView:_shareButton rightMargin:5];

}

- (UIButton *)creatButtonWithTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage target:(id)target selector:(SEL)sel
{
    UIButton *btn = [UIButton new];
    [btn setTitleColor:[UIColor colorWithWhite:0.811 alpha:1.000] forState:(UIControlStateNormal)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    [btn setImage:selImage forState:UIControlStateSelected];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    return btn;
}

- (void)likeButtonClicked
{
    if (self.likeButtonClickedOperation) {
        self.likeButtonClickedOperation();
    }
}

- (void)commentButtonClicked
{
    if (self.commentButtonClickedOperation) {
        self.commentButtonClickedOperation();
    }

}

- (void)shareButtonClicked
{
    if (self.shareButtonClickedOperation) {
        self.shareButtonClickedOperation();
    }
}

- (void)flowerButtonClicked
{
    if (self.flowerButtonClickedOperation) {
        self.flowerButtonClickedOperation();
    }
}


@end
