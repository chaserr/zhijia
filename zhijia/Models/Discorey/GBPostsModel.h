//
//  GBPostsModel.h
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "Model.h"

static const CGFloat GBAvatarSpacing = 15.0f;

static const CGFloat GBAvatarImageSize = 45.0f;

static const CGFloat GBPhotoSize = 90.0f;

static const CGFloat GBPhotoInset = 5.0f;

static const CGFloat GBFontSize = 15;

static const CGFloat GBUsernameHeight = 18.0f;

static const CGFloat GBContentLineSpacing = 4.0f;

static const CGFloat GBLikeButtonSize = 30.0f;

static const CGFloat GBLikeAndCommentHeight = 15;

static const CGFloat GBCommentHeight = 15;

static const CGFloat GBContentFontSize = 16;

@protocol GBPostsModel
@end

@interface GBPostsModel : Model
@property(nonatomic,copy)NSString *post_id;
@property(nonatomic,copy)NSString *author_id;
@property(nonatomic,assign)int likes;
@property(nonatomic,copy)NSString *words;
@property(nonatomic,strong)NSMutableArray *pictures;
@property(nonatomic,copy)NSString *videos;
@property(nonatomic,assign)int liked;
@property(nonatomic,assign)int comments;
@property(nonatomic,assign)int created;
@property(nonatomic,strong)NSMutableArray *commentsDetail;
@property(nonatomic,copy)NSString *avatar;
@end
