//
//  GBRecommendCell.m
//  zhijia
//
//  Created by 童星 on 16/5/25.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import "GBRecommendCell.h"
#import "UIView+SDAutoLayout.h"
#import "GBCommontView.h"
#import "GBPhotoContainer.h"
#import "GBOperationMenu.h"
#import "GBRecommendCellModel.h"

const CGFloat contentLabelFontSize = 16;
CGFloat maxContentLabelHeight = 0; // 根据具体font而定


@interface GBRecommendCell ()
/** 用户图像 */
@property (nonatomic, strong) UIImageView      *iconView;
/** 昵称 */
@property (nonatomic, strong) UILabel          *nameLabel;
/** 文字详情 */
@property (nonatomic, strong) UILabel          *contentLabel;
/** 发布时间 */
@property (nonatomic, strong) UILabel          *timeLabel;
/** 全文按钮 */
@property (nonatomic, strong) UIButton         *moreButton;
/** 是否打开全文详情 */
@property (nonatomic, assign) BOOL             shouldOpenContentLabel;
/** 图片浏览View */
@property (nonatomic, strong) GBPhotoContainer *picContainerView;
/** 评论区 */
@property (nonatomic, strong) GBCommontView    *commentView;
/** 评论菜单 */
@property (nonatomic, strong) GBOperationMenu  *operationMenu;
/** 赞❀数 */
@property (nonatomic, strong) UILabel          *flowerCountLabel;
/** 发布状态的标签 */
@property (nonatomic, strong) UILabel          *releaseTagLabel;
/** 职位名称 */
@property (nonatomic, strong) UIButton         *jobPositionButton;
/** 所在圈子 */
@property (nonatomic, strong) UILabel          *jobCircleLabel;
/** age/gender */
@property (nonatomic, strong) UIButton         *ageGenderButton;
/** 地理位置 */
@property (nonatomic, strong) UIButton         *locationButton;
/** 距离 */
@property (nonatomic, strong) UILabel          *distanceLabel;
@end
@implementation GBRecommendCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UIButton *)creatButtonWithImage:(UIImage *)image
{
    UIButton *btn = [UIButton new];
    [btn setTitleColor:[UIColor colorWithWhite:0.811 alpha:1.000] forState:(UIControlStateNormal)];
    [btn setImage:image forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    return btn;
}

- (void)setup
{
    {
    _shouldOpenContentLabel = NO;
    
    _iconView = [UIImageView new];
    _iconView.layer.cornerRadius = 5;
    _iconView.layer.masksToBounds = YES;
    _nameLabel = [UILabel new];
    _nameLabel.font = [UIFont systemFontOfSize:16];
    _nameLabel.textColor = [UIColor colorWithRed:(54 / 255.0) green:(71 / 255.0) blue:(121 / 255.0) alpha:0.9];
    
    _jobPositionButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _jobPositionButton.layer.cornerRadius = 7;
    [_jobPositionButton.titleLabel setFont:GBSystemFont(13)];
    _jobPositionButton.backgroundColor = [UIColor colorWithWhite:0.937 alpha:1.000];
    [_jobPositionButton setTitleColor:[UIColor colorWithWhite:0.697 alpha:1.000] forState:(UIControlStateNormal)];
        _ageGenderButton = [self creatButtonWithImage:[UIImage imageNamed:@"icon_woman"]];
        _locationButton = [self creatButtonWithImage:[UIImage imageNamed:@"discover_shoot_location-Pin"]];
    _jobCircleLabel = [UILabel new];
    _jobCircleLabel.font = GBSystemFont(13);
    _jobCircleLabel.textAlignment = NSTextAlignmentRight;
    _distanceLabel = [UILabel new];
    _distanceLabel.textColor = [UIColor colorWithWhite:0.591 alpha:1.000];
    _distanceLabel.font = GBSystemFont(13);
    
    
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:contentLabelFontSize];
    _contentLabel.textColor = [UIColor colorWithWhite:0.306 alpha:1.000];
        
    _contentLabel.numberOfLines = 0;
    if (maxContentLabelHeight == 0) {
        maxContentLabelHeight = _contentLabel.font.lineHeight * 3;
    }
    
    _moreButton = [UIButton new];
    [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
    [_moreButton setTitleColor:TimeLineCellHighlightedColor forState:UIControlStateNormal];
    [_moreButton addTarget:self action:@selector(moreButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    _moreButton.titleLabel.font = [UIFont systemFontOfSize:14];
    
    
    _picContainerView = [GBPhotoContainer new];
    
    _commentView = [GBCommontView new];
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:13];
    _timeLabel.textColor = [UIColor lightGrayColor];
    
    {
    _operationMenu = [GBOperationMenu new];
    __weak typeof(self) weakSelf = self;
    [_operationMenu setLikeButtonClickedOperation:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickLikeButtonInCell:)]) {
            [weakSelf.delegate didClickLikeButtonInCell:weakSelf];
        }
    }];
    [_operationMenu setCommentButtonClickedOperation:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickcCommentButtonInCell:)]) {
            [weakSelf.delegate didClickcCommentButtonInCell:weakSelf];
        }
    }];
    [_operationMenu setFlowerButtonClickedOperation:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickFlowerButtonInCell:)]) {
            [weakSelf.delegate didClickFlowerButtonInCell:weakSelf];
        }
    }];
    [_operationMenu setShareButtonClickedOperation:^{
        if ([weakSelf.delegate respondsToSelector:@selector(didClickShareButtonInCell:)]) {
            [weakSelf.delegate didClickShareButtonInCell:weakSelf];
        }
    }];
    
    }
    
    _flowerCountView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"flowersy"]];
    _flowerCountView.contentMode = UIViewContentModeCenter;
    
    _flowerCountLabel = [UILabel new];
    _flowerCountLabel.textAlignment = NSTextAlignmentCenter;
    _flowerCountLabel.textColor = [UIColor colorWithWhite:0.799 alpha:1.000];
    [_flowerCountLabel setFont:GBSystemFont(13)];
    
    
    _releaseTagLabel = [UILabel new];
    _releaseTagLabel.textColor = [UIColor colorWithWhite:0.799 alpha:1.000];
    _releaseTagLabel.textAlignment = NSTextAlignmentCenter;
    _releaseTagLabel.font = GBSystemFont(13);

    
    
    NSArray *views = @[_iconView, _nameLabel, _jobPositionButton, _jobCircleLabel, _ageGenderButton, _locationButton, _distanceLabel, _contentLabel, _moreButton, _picContainerView, _timeLabel, _releaseTagLabel, _flowerCountLabel, _flowerCountView,_operationMenu, _commentView];
    
    [self.contentView sd_addSubviews:views];
    
    }
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    _iconView.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .widthIs(40)
    .heightIs(40);
    
    _nameLabel.sd_layout
    .leftSpaceToView(_iconView, margin)
    .topEqualToView(_iconView)
    .heightIs(18);
    [_nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    _jobPositionButton.sd_layout
    .leftSpaceToView(_nameLabel, 10)
    .centerYEqualToView(_nameLabel);
    [_jobPositionButton setupAutoSizeWithHorizontalPadding:8 buttonHeight:18];//_jobPositionButton.titleLabel.font.lineHeight

    _ageGenderButton.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_nameLabel, 5)
    .widthIs(40)
    .heightIs(20);
    
    _locationButton.sd_layout
    .leftSpaceToView(_ageGenderButton, 5)
    .centerYEqualToView(_ageGenderButton)
    .widthIs(60)
    .heightIs(20);
    
    _distanceLabel.sd_layout
    .leftSpaceToView(_locationButton, 8)
    .centerYEqualToView(_locationButton)
    .heightIs(20);
    [_distanceLabel setSingleLineAutoResizeWithMaxWidth:100];
    
    _jobCircleLabel.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .centerYEqualToView(_ageGenderButton)
    .heightIs(20);
    [_jobCircleLabel setSingleLineAutoResizeWithMaxWidth:200];

    
    _contentLabel.sd_layout
    .leftEqualToView(_nameLabel)
    .topSpaceToView(_iconView, 10)
    .rightSpaceToView(contentView, margin)
    .autoHeightRatio(0);
    
    _flowerCountView.sd_layout
    .centerXEqualToView(_iconView)
    .topEqualToView(_contentLabel).offset(5)
    .heightIs(_flowerCountView.height);

    
    _flowerCountLabel.sd_layout
    .centerXEqualToView(_iconView)
    .topSpaceToView(_flowerCountView, 5)
    .widthRatioToView(_iconView, 1)
    .autoHeightRatio(0);
    
 
    // morebutton的高度在setmodel里面设置
    _moreButton.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_contentLabel, 0)
    .widthIs(30);
    
    
    _picContainerView.sd_layout
    .leftEqualToView(_contentLabel); // 已经在内部实现宽度和高度自适应所以不需要再设置宽度高度，top值是具体有无图片在setModel方法中设置
    
    _releaseTagLabel.sd_layout
    .centerYEqualToView(_picContainerView)
    .centerXEqualToView(_iconView)
    .heightIs(30)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(_picContainerView, 0);
    
    _timeLabel.sd_layout
    .leftEqualToView(_contentLabel)
    .topSpaceToView(_picContainerView, margin)
    .heightIs(15);
    [_timeLabel setSingleLineAutoResizeWithMaxWidth:180];

    
    _operationMenu.sd_layout
    .rightSpaceToView(self.contentView, 10)
    .heightIs(30)
    .topSpaceToView(_picContainerView, 20);
    
    _commentView.sd_layout
    .leftSpaceToView(self.contentView, margin)
    .rightSpaceToView(self.contentView, margin)
    .topSpaceToView(_operationMenu, 1); // 已经在内部实现高度自适应所以不需要再设置高度
    
    

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setModel:(GBRecommendCellModel *)model
{
    _model = model;
    
    _commentView.frame = CGRectZero;
    [_commentView setupWithLikeItemsArray:model.likeItemsArray commentItemsArray:model.commentItemsArray];
    
    _shouldOpenContentLabel = NO;
    
    _iconView.image = [UIImage imageNamed:model.iconName];
    _nameLabel.text = model.name;
    // 防止单行文本label在重用时宽度计算不准的问题
    [_nameLabel sizeToFit];
    
    [_jobPositionButton setTitle:@"百度/设计师" forState:UIControlStateNormal];
//    _jobCircleLabel.text = @"互联网圈子的人";
    [_ageGenderButton setTitle:@"22" forState:(UIControlStateNormal)];
    [_locationButton setTitle:@"五道口" forState:(UIControlStateNormal)];
    _distanceLabel.text = @"0.1km";
    
    
    _flowerCountLabel.text = @"1998";


    _releaseTagLabel.text = @"上班啦";
    NSAttributedString *attrContentStr = [[NSAttributedString alloc] initWithString:model.msgContent attributes:@{NSKernAttributeName:@(1.0f)}];
    [_contentLabel setAttributedText:attrContentStr];
    _picContainerView.picPathStringsArray = model.picNamesArray;
    
    
    
    if (model.shouldShowMoreButton) { // 如果文字高度超过60
        _moreButton.sd_layout.heightIs(20);
        _moreButton.hidden = NO;
        if (model.isOpening) { // 如果需要展开
            _contentLabel.sd_layout.maxHeightIs(MAXFLOAT);
            [_moreButton setTitle:@"收起" forState:UIControlStateNormal];
        } else {
            _contentLabel.sd_layout.maxHeightIs(maxContentLabelHeight);
            [_moreButton setTitle:@"全文" forState:UIControlStateNormal];
        }
    } else {
        _moreButton.sd_layout.heightIs(0);
        _moreButton.hidden = YES;
    }
    
    CGFloat picContainerTopMargin = 0;
    if (model.picNamesArray.count) {
        picContainerTopMargin = 10;
    }
    _picContainerView.sd_layout.topSpaceToView(_moreButton, picContainerTopMargin);
    
    UIView *bottomView;
    
    if (!model.commentItemsArray.count && !model.likeItemsArray.count) {
        _commentView.fixedWidth = @0; // 如果没有评论或者点赞，设置commentview的固定宽度为0（设置了fixedWith的控件将不再在自动布局过程中调整宽度）
        _commentView.fixedHeight = @0; // 如果没有评论或者点赞，设置commentview的固定高度为0（设置了fixedHeight的控件将不再在自动布局过程中调整高度）
        _commentView.sd_layout.topSpaceToView(_operationMenu, 0);
        bottomView = _operationMenu;
    } else {
        _commentView.fixedHeight = nil; // 取消固定宽度约束
        _commentView.fixedWidth = nil; // 取消固定高度约束
        _commentView.sd_layout.topSpaceToView(_operationMenu, 10);
        bottomView = _commentView;
    }
    
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:15];
    
    _timeLabel.text = @"1分钟前";
}


#pragma mark - private actions

- (void)moreButtonClicked
{
    if (self.moreButtonClickedBlock) {
        self.moreButtonClickedBlock(self.indexPath);
    }
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
