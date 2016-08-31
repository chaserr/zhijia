//
//  GBCommontView.m
//  zhijia
//
//  Created by 童星 on 16/5/25.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBCommontView.h"
#import "UIView+SDAutoLayout.h"
#import "GBRecommendCellModel.h"
#import "MLLinkLabel.h"
#import "GBUserSpaceViewController.h"
@interface GBCommontView ()<MLLinkLabelDelegate>

@property (nonatomic, strong) NSArray *likeItemsArray;
@property (nonatomic, strong) NSArray *commentItemsArray;

@property (nonatomic, strong) UIImageView *bgImageView;

@property (nonatomic, strong) MLLinkLabel *likeLabel;
@property (nonatomic, strong) UIView *likeLableBottomLine;
@property (nonatomic, strong) UIView *moreCommonBottomLine;

@property (nonatomic, strong) UIButton *moreCommonButon;

@property (nonatomic, strong) NSMutableArray *commentLabelsArray;

@end

@implementation GBCommontView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    _bgImageView = [UIImageView new];
    UIImage *bgImage = [UIImage imageNamed:@"LikeCmtBackg"];
    CGFloat top = 30; // 顶端盖高度
    CGFloat bottom = 0 ; // 底端盖高度
    CGFloat left = 0; // 左端盖宽度
    CGFloat right = 100; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    // 伸缩后重新赋值
    bgImage = [bgImage resizableImageWithCapInsets:insets];
    _bgImageView.image = bgImage;
    [self addSubview:_bgImageView];
    
    _likeLabel = [MLLinkLabel new];
    _likeLabel.font = [UIFont systemFontOfSize:14];
    _likeLabel.linkTextAttributes = @{NSForegroundColorAttributeName : TimeLineCellHighlightedColor};
    [self addSubview:_likeLabel];
    
    _likeLableBottomLine = [UIView new];
    _likeLableBottomLine.backgroundColor = [[UIColor colorWithWhite:0.751 alpha:1.000] colorWithAlphaComponent:0.2];
    [self addSubview:_likeLableBottomLine];
    
    _moreCommonButon = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _moreCommonButon.titleLabel.font = GBSystemFont(14);
    [_moreCommonButon setTitleColor:TimeLineCellHighlightedColor forState:(UIControlStateNormal)];
    [self addSubview:_moreCommonButon];
    
    _moreCommonBottomLine = [UIView new];
    _moreCommonBottomLine.backgroundColor = [[UIColor colorWithWhite:0.751 alpha:1.000] colorWithAlphaComponent:0.2];
    [self addSubview:_moreCommonBottomLine];
    
    _bgImageView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}

- (void)setCommentItemsArray:(NSArray *)commentItemsArray
{
    _commentItemsArray = commentItemsArray;
    
    long originalLabelsCount = self.commentLabelsArray.count;
    long needsToAddCount = commentItemsArray.count > originalLabelsCount ? (commentItemsArray.count - originalLabelsCount) : 0;
    for (int i = 0; i < needsToAddCount; i++) {
        MLLinkLabel *label = [MLLinkLabel new];
        UIColor *highLightColor = TimeLineCellHighlightedColor;
        label.linkTextAttributes = @{NSForegroundColorAttributeName : highLightColor};
        label.font = [UIFont systemFontOfSize:14];
        label.delegate = self;
        [self addSubview:label];
        [self.commentLabelsArray addObject:label];
    }
    
    for (int i = 0; i < commentItemsArray.count; i++) {
        SDTimeLineCellCommentItemModel *model = commentItemsArray[i];
        MLLinkLabel *label = self.commentLabelsArray[i];
        label.attributedText = [self generateAttributedStringWithCommentItemModel:model];
    }
}

- (void)setLikeItemsArray:(NSArray *)likeItemsArray
{
    _likeItemsArray = likeItemsArray;
    
    NSTextAttachment *attach = [NSTextAttachment new];
    attach.image = [UIImage imageNamed:@"action02"];
    attach.bounds = CGRectMake(0, -3, 16, 16);
    NSAttributedString *likeIcon = [NSAttributedString attributedStringWithAttachment:attach];
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithAttributedString:likeIcon];
    [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"  "]];
    for (int i = 0; i < likeItemsArray.count; i++) {
        SDTimeLineCellLikeItemModel *model = likeItemsArray[i];
        if (i > 0) {
            [attributedText appendAttributedString:[[NSAttributedString alloc] initWithString:@"，"]];
        }
        [attributedText appendAttributedString:[self generateAttributedStringWithLikeItemModel:model]];
        ;
    }
    
    _likeLabel.attributedText = [attributedText copy];
}

- (NSMutableArray *)commentLabelsArray
{
    if (!_commentLabelsArray) {
        _commentLabelsArray = [NSMutableArray new];
    }
    return _commentLabelsArray;
}

- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray
{
    self.likeItemsArray = likeItemsArray;
    self.commentItemsArray = commentItemsArray;
    [_moreCommonButon sd_clearAutoLayoutSettings];
    _moreCommonButon.hidden = YES;
    [_moreCommonButon sd_clearViewFrameCache];
    [_moreCommonBottomLine sd_clearAutoLayoutSettings];
    
    if (self.commentLabelsArray.count) {
        [self.commentLabelsArray enumerateObjectsUsingBlock:^(UILabel *label, NSUInteger idx, BOOL *stop) {
            [label sd_clearAutoLayoutSettings];
            label.hidden = YES; //重用时先隐藏所以评论label，然后根据评论个数显示label
        }];
        

    }
    
    CGFloat margin = 5;
    
    UIView *lastTopView = nil;
    
    if (likeItemsArray.count) {
        _likeLabel.sd_resetLayout
        .leftSpaceToView(self, margin)
        .rightSpaceToView(self, margin)
        .topSpaceToView(lastTopView, 10)
        .autoHeightRatio(0);
        
        _likeLabel.isAttributedContent = YES;
        
        lastTopView = _likeLabel;
        
    }
    else {
        _likeLabel.sd_resetLayout
        .heightIs(0);
    }
    
    
    if (self.commentItemsArray.count && self.likeItemsArray.count) {
        _likeLableBottomLine.sd_resetLayout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(1)
        .topSpaceToView(lastTopView, 3);
        lastTopView = _likeLableBottomLine;
    } else {
        _likeLableBottomLine.sd_resetLayout.heightIs(0);
    }
    
    for (int i = 0; i < self.commentItemsArray.count; i++) {
        UILabel *label = (UILabel *)self.commentLabelsArray[i];
        label.hidden = NO;
        CGFloat topMargin = (i == 0 && likeItemsArray.count == 0) ? 10 : 5;
        label.sd_layout
        .leftSpaceToView(self, 8)
        .rightSpaceToView(self, 5)
        .topSpaceToView(lastTopView, topMargin)
        .autoHeightRatio(0);
        
        label.isAttributedContent = YES;
        lastTopView = label;
    }
    
    if (self.commentItemsArray.count) {
        
        _moreCommonBottomLine.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .heightIs(1)
        .topSpaceToView(lastTopView, 5);
        
        lastTopView = _moreCommonBottomLine;
        
        _moreCommonButon.hidden = NO;
        _moreCommonButon.sd_layout
        .leftSpaceToView(self, 0)
        .rightSpaceToView(self, 0)
        .topSpaceToView(lastTopView, 10)
        .centerYEqualToView(self)
        .heightIs(30);
        
        [_moreCommonButon setTitle:[NSString stringWithFormat:@"查看全部%lu条", (unsigned long)_commentItemsArray.count] forState:(UIControlStateNormal)];
        
        lastTopView = _moreCommonButon;
    }
    
    
    [self setupAutoHeightWithBottomView:lastTopView bottomMargin:5];
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

#pragma mark - private actions

- (NSMutableAttributedString *)generateAttributedStringWithCommentItemModel:(SDTimeLineCellCommentItemModel *)model
{
    NSString *text = model.firstUserName;
    if (model.secondUserName.length) {
        text = [text stringByAppendingString:[NSString stringWithFormat:@"回复%@", model.secondUserName]];
    }
    text = [text stringByAppendingString:[NSString stringWithFormat:@"：%@", model.commentString]];
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    [attString setAttributes:@{NSLinkAttributeName : model.firstUserId} range:[text rangeOfString:model.firstUserName]];
    if (model.secondUserName) {
        [attString setAttributes:@{NSLinkAttributeName : model.secondUserId} range:[text rangeOfString:model.secondUserName]];
    }
    return attString;
}

- (NSMutableAttributedString *)generateAttributedStringWithLikeItemModel:(SDTimeLineCellLikeItemModel *)model
{
    NSString *text = model.userName;
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc] initWithString:text];
    UIColor *highLightColor = [UIColor colorWithRed:0.369 green:0.573 blue:0.733 alpha:1.000];
    [attString setAttributes:@{NSForegroundColorAttributeName : highLightColor, NSLinkAttributeName : model.userId} range:[text rangeOfString:model.userName]];
    
    return attString;
}


#pragma mark - MLLinkLabelDelegate

- (void)didClickLink:(MLLink *)link linkText:(NSString *)linkText linkLabel:(MLLinkLabel *)linkLabel
{
    NSLog(@"%@", link.linkValue);
    DLog(@"跳转到对方空间");
    GBUserSpaceViewController *userSpace = [[GBUserSpaceViewController alloc] init];
    [AppNavigator pushViewController:userSpace withCurrentView:self.superview.superview animated:YES];
}
@end
