//
//  GBTitleOnBottomButton.m
//  zhijia
//
//  Created by 张浩 on 16/5/19.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//
// 图标的比例


#import "GBTitleOnBottomButton.h"

@implementation GBTitleOnBottomButton

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
  
    }
    return self;
}

// 重写去掉高亮状态
- (void)setHighlighted:(BOOL)highlighted{}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = contentRect.size.width;
    CGFloat imageH = contentRect.size.height *_buttonImageRatio;
    return CGRectMake(0, 0, imageW, imageH);
    
}

// 内部文字的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = contentRect.size.height * _buttonImageRatio;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(0, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title image:(UIImage *)image selectImage:(UIImage *)selectImage{
    
    // 设置文字
    [self setTitle:title forState:UIControlStateSelected];
    [self setTitle:title forState:UIControlStateNormal];
    
    // 设置图片
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:selectImage forState:UIControlStateSelected];
}

@end
