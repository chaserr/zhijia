//
//  GBPlazaRichTextView.m
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBPlazaRichTextView.h"
#import "GBPlazaPhotoCollectionViewCell.h"
#import "GBPlazaLikeAndCommentsView.h"
#import "GBPlazaCommentsDetailView.h"

static NSString* photoCollectionViewIdentifier=@"photoCell";

@implementation GBPlazaCollectionViewFlowLayout

-(instancetype)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(GBPhotoSize, GBPhotoSize);
        [self setScrollDirection:UICollectionViewScrollDirectionVertical];
        self.minimumInteritemSpacing = GBPhotoInset;
        self.minimumLineSpacing = GBPhotoInset;
    }
    return self;
}

@end

@interface GBPlazaRichTextView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timestampLabel;
@property(nonatomic,strong)UIImageView *avatarImageView;
@property(nonatomic,strong)UILabel *contentLabel;
@property(nonatomic,strong)UICollectionView *albumCollectionView;
@property(nonatomic,strong)UIButton *likeButton;
@property(nonatomic,strong)UIButton *commentButton;
@property(nonatomic,strong)GBPlazaLikeAndCommentsView *likeAndCommentsView;
@property(nonatomic,strong)GBPlazaCommentsDetailView *commentsDetailView;

@end

@implementation GBPlazaRichTextView


+(CGFloat)calculateRichTextHeightWithModel:(GBPostsModel *)mode
{
    CGFloat totalHeight = GBAvatarSpacing;
    totalHeight += GBAvatarImageSize;
    totalHeight += GBAvatarSpacing;
    
    if (mode.words.length > 0) {
        totalHeight += [self getContentLabelHeight:mode.words];
        totalHeight += GBAvatarSpacing;
    }
    
    if(mode.pictures.count > 0)
    {
        totalHeight += [[self class] getCollectionViewHeightWithPhotoCount:mode.pictures.count];
        totalHeight += GBAvatarSpacing;
    }
    
    if (mode.likes > 0 || mode.comments > 0) {
        totalHeight += GBLikeAndCommentHeight;
        totalHeight += GBAvatarSpacing;
    }
    
    if (mode.commentsDetail.count > 0) {
        totalHeight += [[self class] getCommentsDetailHeight:mode.commentsDetail.count];
        totalHeight += GBAvatarSpacing;
    }
    
    totalHeight += GBLikeButtonSize;
    
    totalHeight += GBAvatarSpacing;
    
    return totalHeight;
}

+(CGFloat)getCommentsDetailHeight:(NSInteger)count
{
    if (count==0) {
        return 0;
    }
    return [GBPlazaCommentsDetailView calculateCommentsHeight:count];
}
+(CGFloat)getContentLabelHeight:(NSString *)text
{
    return [[self class] getLabelHeightWithText:text maxWidth:[[self class] contentWidth] font:[UIFont systemFontOfSize:GBContentFontSize]];
}
+(CGFloat)getLabelHeightWithText:(NSString*)text maxWidth:(CGFloat)maxWidth font:(UIFont*)font
{
    return [text boundingRectWithSize:CGSizeMake(maxWidth,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size.height;
}
+(CGFloat)getCollectionViewHeightWithPhotoCount:(NSInteger)photoCount{
    if(photoCount==0){
        return 0;
    }
    int row=(int)photoCount/3+(photoCount%3 ? 1:0);
    return row*GBPhotoSize+(row-1)*GBPhotoInset;
}
+(CGFloat)nameWidth
{
    return SCREEN_WIDTH - 3*GBAvatarSpacing-GBAvatarImageSize;
}

+(CGFloat)contentWidth
{
    return SCREEN_WIDTH - 2*GBAvatarSpacing;
}
+(CGFloat)getCommentButtonWidth
{
    return SCREEN_WIDTH - 3*GBAvatarSpacing - GBLikeButtonSize;
}

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
    [self setBackgroundColor:GBCommonColor];
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.timestampLabel];
    [self addSubview:self.contentLabel];
    [self addSubview:self.albumCollectionView];
    [self addSubview:self.likeButton];
    [self addSubview:self.commentButton];
    [self addSubview:self.likeAndCommentsView];
    [self addSubview:self.commentsDetailView];
}

#pragma mark - property

-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+GBAvatarSpacing, CGRectGetMidX(self.avatarImageView.frame)-GBUsernameHeight, [[self class] nameWidth], GBUsernameHeight)];
        _nameLabel.font = [UIFont boldSystemFontOfSize:16];
        _nameLabel.textColor = [UIColor whiteColor];
    }
    return _nameLabel;
}
-(UILabel *)timestampLabel
{
    if (!_timestampLabel) {
        _timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.avatarImageView.frame)+GBAvatarSpacing, CGRectGetMidX(self.avatarImageView.frame), [[self class] nameWidth], GBUsernameHeight)];
        _timestampLabel.font = [UIFont systemFontOfSize:14];
        _timestampLabel.textColor = [UIColor grayColor];
    }
    return _timestampLabel;
}
-(UIImageView *)avatarImageView
{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(GBAvatarSpacing, GBAvatarSpacing, GBAvatarImageSize, GBAvatarImageSize)];
        [_avatarImageView.layer setCornerRadius:GBAvatarImageSize/2];
        [_avatarImageView setClipsToBounds:YES];
        _avatarImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _avatarImageView;
}
-(UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _contentLabel.font = [UIFont systemFontOfSize:GBContentFontSize];
        _contentLabel.textColor = [UIColor whiteColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}
-(UICollectionView *)albumCollectionView
{
    if (!_albumCollectionView) {
        _albumCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[GBPlazaCollectionViewFlowLayout alloc] init]];
        _albumCollectionView.backgroundColor = [UIColor clearColor];
        [_albumCollectionView registerClass:[GBPlazaPhotoCollectionViewCell class] forCellWithReuseIdentifier:photoCollectionViewIdentifier];
        _albumCollectionView.delegate = self;
        _albumCollectionView.dataSource = self;
    }
    return _albumCollectionView;
}
-(UIButton *)likeButton
{
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setImage :[UIImage imageNamed:@"ic_like_40px@2x"] forState:UIControlStateNormal];
        [_likeButton addTarget:self action:@selector(likeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likeButton;
}
-(UIButton *)commentButton
{
    if (!_commentButton) {
        _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentButton.layer setCornerRadius:GBLikeButtonSize/2];
        [_commentButton setBackgroundColor:[UIColor grayColor]] ;
        [_commentButton setTitle:@":说点什么吧" forState:UIControlStateNormal];
        [_commentButton setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [_commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_commentButton setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
        _commentButton.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return _commentButton;
}
-(GBPlazaLikeAndCommentsView *)likeAndCommentsView
{
    if (!_likeAndCommentsView) {
        _likeAndCommentsView = [[GBPlazaLikeAndCommentsView alloc] initWithFrame:CGRectZero];
    }
    return _likeAndCommentsView;
}
-(GBPlazaCommentsDetailView *)commentsDetailView
{
    if (!_commentsDetailView) {
        _commentsDetailView = [[GBPlazaCommentsDetailView alloc] initWithFrame:CGRectZero];
    }
    return _commentsDetailView;
}
#pragma mark - function

-(void)setPostsModel:(GBPostsModel *)postsModel
{
    _postsModel = postsModel;
    self.nameLabel.text = postsModel.post_id;
    
    self.timestampLabel.text = [GBUtils createdDateFormat:postsModel.created];
    
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:postsModel.avatar] placeholderImage:[UIImage imageNamed:@"find_people"]];
    
    self.contentLabel.text = postsModel.words;
    
    [self.albumCollectionView reloadData];
    
    [self.likeAndCommentsView setLikeStr:postsModel.likes commentsStr:postsModel.comments];
    
    [self.commentsDetailView setComments:postsModel.commentsDetail];
    
    
    [self setNeedsLayout];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat originY=CGRectGetMaxY(self.avatarImageView.frame)+GBAvatarSpacing;
    
    if (self.postsModel.words.length>0) {
        self.contentLabel.frame = CGRectMake(GBAvatarSpacing, originY, [[self class] contentWidth], [[self class] getContentLabelHeight:self.postsModel.words]);
        
        originY += CGRectGetHeight(self.contentLabel.frame);
        originY += GBAvatarSpacing;
    }else{
        self.contentLabel.frame = CGRectZero;
    }
    
    if (self.postsModel.pictures.count > 0) {
        self.albumCollectionView.frame = CGRectMake(GBAvatarSpacing, originY, GBPhotoSize*3+2*GBPhotoInset, [[self class] getCollectionViewHeightWithPhotoCount:self.postsModel.pictures.count]);
        
        originY += CGRectGetHeight(self.albumCollectionView.frame);
        originY += GBAvatarSpacing;
    }else{
        self.albumCollectionView.frame = CGRectZero;
    }
    
    if (self.postsModel.likes >0 || self.postsModel.comments >0) {
        self.likeAndCommentsView.frame = CGRectMake(GBAvatarSpacing, originY, [[self class] contentWidth], GBLikeAndCommentHeight);
        
        originY +=CGRectGetHeight(self.likeAndCommentsView.frame);
        originY +=GBAvatarSpacing;
    }else{
        self.likeAndCommentsView.frame = CGRectZero;
    }
    
    if (self.postsModel.commentsDetail.count >0) {
        self.commentsDetailView.frame = CGRectMake(GBAvatarSpacing, originY, [[self class] contentWidth], [[self class] getCommentsDetailHeight:self.postsModel.commentsDetail.count]);
        
        originY += CGRectGetHeight(self.commentsDetailView.frame);
        originY += GBAvatarSpacing;
    }else{
        self.commentsDetailView.frame = CGRectZero;
    }
    
    self.likeButton.frame = CGRectMake(GBAvatarSpacing, originY, GBLikeButtonSize, GBLikeButtonSize);
    
    self.commentButton.frame = CGRectMake(CGRectGetMaxX(self.likeButton.frame)+GBAvatarSpacing, originY, [[self class] getCommentButtonWidth], GBLikeButtonSize);
    
    CGRect frame = self.frame;
    frame.size.height = originY + GBLikeButtonSize + GBAvatarSpacing;
    self.frame = frame;
}

#pragma  mark - delegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.postsModel.pictures.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GBPlazaPhotoCollectionViewCell *photoCell = [collectionView dequeueReusableCellWithReuseIdentifier:photoCollectionViewIdentifier forIndexPath:indexPath];
    if (!photoCell) {
        photoCell = [[GBPlazaPhotoCollectionViewCell alloc] initWithFrame:CGRectMake(0, 0, GBPhotoSize, GBPhotoSize)];
    }
    [photoCell.photoImageView sd_setImageWithURL:[NSURL URLWithString:[self.postsModel.pictures objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"find_people"]];
    return photoCell;
}

#pragma  mark - action

-(void)likeAction
{
    self.postsModel.likes++;
}
@end
