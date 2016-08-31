//
//  GBPlazaRichTextView.h
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GBPostsModel.h"


@interface GBPlazaCollectionViewFlowLayout : UICollectionViewFlowLayout

@end

@interface GBPlazaRichTextView : UIView

@property(nonatomic,strong)GBPostsModel *postsModel;

+(CGFloat)calculateRichTextHeightWithModel:(GBPostsModel *)mode;

@end
