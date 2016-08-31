//
//  GBPlazaTableViewCell.m
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBPlazaTableViewCell.h"
#import "GBPlazaRichTextView.h"

@interface GBPlazaTableViewCell()

@property(nonatomic,strong)GBPlazaRichTextView *plazaRichTextView;

@end

@implementation GBPlazaTableViewCell

+(CGFloat)calculateCellHeightWithPostsModel:(GBPostsModel *)model
{
    return [GBPlazaRichTextView calculateRichTextHeightWithModel:model];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.contentView addSubview:self.plazaRichTextView];
}

-(GBPlazaRichTextView *)plazaRichTextView
{
    if (!_plazaRichTextView) {
        _plazaRichTextView = [[GBPlazaRichTextView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,CGFLOAT_MIN)];
        
    }
    return _plazaRichTextView;
}

-(void)setCurrentPostModel:(GBPostsModel *)model
{
    self.plazaRichTextView.postsModel = model;
}

@end
