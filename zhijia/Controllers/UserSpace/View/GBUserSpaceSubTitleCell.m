//
//  GBUserSpaceSubTitleCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBUserSpaceSubTitleCell.h"
#import "TagView.h"
#import "TagListView.h"
#import "GBUserPotrialScrollerView.h"
@interface GBUserSpaceSubTitleCell ()

@property (nonatomic, strong) GBUserPotrialScrollerView *portrialView;

@property (strong, nonatomic) TagListView *tagListView;
@property (nonatomic, strong) NSArray *photoArray;

@end

@implementation GBUserSpaceSubTitleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray*)titleArray withParentController:(id)parentController{

    if (indexPath.section == 1) {
        
        [self createDynamicPhotoWithArray:self.photoArray];
        
    }else{
    
        _cellRightArrow.hidden = YES;
        [self createMyTagsView:parentController];

    }
    
}

- (void)createDynamicPhotoWithArray:(NSArray *)photoArray{

    self.portrialView = [[GBUserPotrialScrollerView alloc] initWithFrame:CGRectMake(0, 0, self.cellContentView.width, self.cellContentView.height) withImageArray:photoArray];
    _portrialView.minimumLineSpacing = 5.0f;
    _portrialView.itemSize = CGSizeMake(self.cellContentView.height, self.cellContentView.height);
    
    [self.cellContentView addSubview:_portrialView];
}

- (void)createMyTagsView:(id)parentController{
    self.tagListView = [[TagListView alloc] initWithFrame:CGRectMake(0, 0, self.cellContentView.width, self.cellContentView.height)];
    self.tagListView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    self.tagListView.delegate = parentController;
    self.tagListView.backgroundColor = [UIColor whiteColor];
    NSArray *tagArray = @[@"产品经理", @"吉他手", @"高级工程师"];
    [self.tagListView addTagWithArray:tagArray withHasCustomTag:NO];
    _tagListView.tagBackgroundColor = [UIColor colorWithWhite:0.964 alpha:1.000];
    _tagListView.cornerRadius = 15;
    _tagListView.borderWidth = 0;
    _tagListView.paddingY = 8;
    _tagListView.paddingX = 10;
    _tagListView.marginX = 10;
    _tagListView.marginY = 10;
    _tagListView.textFont = GBSystemFont(16);
    _tagListView.textColor = [UIColor colorWithWhite:0.648 alpha:1.000];
    
    [_tagListView.subviews enumerateObjectsUsingBlock:^( TagView * tagView, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (idx == tagArray.count - 1) {
            
            [self resetTagViewFrameWithLastTag:tagView];
        }
    }];

    [self.cellContentView addSubview:_tagListView];
    
}
        
- (void)resetTagViewFrameWithLastTag:(TagView *)tagView{
    CGFloat height = tagView.y + tagView.height + 5;
    CGRect frame = CGRectMake(0, (CGRectGetHeight(_cellContentView.frame) - height) * 0.5, self.cellContentView.width, height);
    _tagListView.frame = frame;
}

// 懒加载
- (NSArray *)photoArray{
    
    if (!_photoArray) {
        _photoArray = [NSArray arrayWithObjects:@"testPhoto", @"testPhoto", @"testPhoto",@"testPhoto",@"testPhoto",@"testPhoto", nil];
    }
    return _photoArray;
}
@end
