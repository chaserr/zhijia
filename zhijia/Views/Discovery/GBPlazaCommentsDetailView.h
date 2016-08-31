//
//  GBPlazaCommentsView.h
//  zhijia
//
//  Created by admin on 15/7/28.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GBPlazaCommentSingle : UIButton

@end

@interface GBPlazaCommentsDetailView : UIView

+(CGFloat)calculateCommentsHeight:(NSInteger )count;

-(void)setComments:(NSArray *)array;

@end
