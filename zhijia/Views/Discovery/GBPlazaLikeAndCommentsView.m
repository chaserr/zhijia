//
//  GBPlazaLikeAndCommentsView.m
//  zhijia
//
//  Created by admin on 15/7/28.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBPlazaLikeAndCommentsView.h"
#import "GBPostsModel.h"

@interface GBPlazaLikeAndCommentsView()
{
    int _likes;
    int _comments;
}

@property(nonatomic,strong)UIImageView *likeIcon;
@property(nonatomic,strong)UILabel *likeText;
@property(nonatomic,strong)UIImageView *commentsIcon;
@property(nonatomic,strong)UILabel *commentsText;

@end

@implementation GBPlazaLikeAndCommentsView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    [self addSubview:self.likeText];
    [self addSubview:self.likeIcon];
    [self addSubview:self.commentsText];
    [self addSubview:self.commentsIcon];
}

-(UIImageView *)likeIcon
{
    if (!_likeIcon) {
        _likeIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, GBLikeAndCommentHeight, GBLikeAndCommentHeight)];
        _likeIcon.image = [UIImage imageNamed:@"ic_like_outline_40px"];
        _likeIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _likeIcon;
}

-(UIImageView *)commentsIcon
{
    if (!_commentsIcon) {
        _commentsIcon = [[UIImageView alloc] initWithFrame:CGRectZero];
        _commentsIcon.image = [UIImage imageNamed:@"ic_message_outline_40px"];
        _commentsIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _commentsIcon;
}

-(UILabel *)likeText
{
    if (!_likeText) {
        _likeText = [[UILabel alloc] initWithFrame:CGRectZero];
        _likeText.textAlignment = NSTextAlignmentCenter;
        _likeText.font = [UIFont systemFontOfSize:12];
        _likeText.textColor = [UIColor lightGrayColor];
    }
    return _likeText;
}

-(UILabel *)commentsText
{
    if (!_commentsText) {
        _commentsText = [[UILabel alloc] initWithFrame:CGRectZero];
        _commentsText.textAlignment = NSTextAlignmentCenter;
        _commentsText.font = [UIFont systemFontOfSize:12];
        _commentsText.textColor = [UIColor lightGrayColor];
    }
    return _commentsText;
}

-(void)setLikeStr:(int)likes commentsStr:(int)comments
{
    _likes = likes;
    _comments = comments;
    _likeText.text = likes>99?@"赞(99+)":[NSString stringWithFormat:@"赞(%d)",likes];
    _commentsText.text = comments >99?@"评论(99+)":[NSString stringWithFormat:@"评论(%d)",comments];
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if (_likes == 0) {
        self.likeIcon.frame = CGRectZero;
        self.likeText.frame = CGRectZero;
        self.likeIcon.hidden = YES;
        self.likeText.hidden = YES;
    }else{
        self.likeIcon.hidden = NO;
        self.likeText.hidden = NO;
        self.likeIcon.frame =CGRectMake(0, 0, GBLikeAndCommentHeight, GBLikeAndCommentHeight);
        self.likeText.frame = CGRectMake(CGRectGetMaxX(self.likeIcon.frame)+GBSpacingBetweenIconAndText, 0, [self calculateLabelWith:self.likeText], GBLikeAndCommentHeight);
    }
    
    if (_comments == 0) {
        self.commentsIcon.frame = CGRectZero;
        self.commentsText.frame = CGRectZero;
        self.commentsIcon.hidden = YES;
        self.commentsText.hidden = YES;
    }else{
        self.commentsIcon.hidden = NO;
        self.commentsText.hidden = NO;
        self.commentsIcon.frame = CGRectMake(CGRectGetMaxX(self.likeText.frame)+(CGRectIsEmpty(self.likeText.frame) ? 0 : GBSpacingBetweenLikeAndCommnets), 0, GBLikeAndCommentHeight, GBLikeAndCommentHeight);
        self.commentsText.frame = CGRectMake(CGRectGetMaxX(self.commentsIcon.frame)+GBSpacingBetweenIconAndText, 0, [self calculateLabelWith:self.commentsText], GBLikeAndCommentHeight);
    }
    
    
}

-(CGFloat)calculateLabelWith:(UILabel *)label
{
    return [label.text sizeWithAttributes:@{NSFontAttributeName:label.font}].width;
}
@end
