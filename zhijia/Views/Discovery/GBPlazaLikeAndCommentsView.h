//
//  GBPlazaLikeAndCommentsView.h
//  zhijia
//
//  Created by admin on 15/7/28.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat GBSpacingBetweenIconAndText = 5;

static const CGFloat GBSpacingBetweenLikeAndCommnets = 20;

@interface GBPlazaLikeAndCommentsView : UIView

-(void)setLikeStr:(int)likes commentsStr:(int)comments;

@end
