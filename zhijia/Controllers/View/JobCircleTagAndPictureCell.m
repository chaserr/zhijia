//
//  JobCircleTagAndPictureCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/8.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "JobCircleTagAndPictureCell.h"
#import "TagView.h"
#import "TagListView.h"
#import "STAlertView.h"

@interface JobCircleTagAndPictureCell ()
@property (strong, nonatomic) TagListView *tagListView;
@property (nonatomic, strong) STAlertView *stAlertView;
@property (nonatomic, strong) NSMutableArray *selectArray;

@end
@implementation JobCircleTagAndPictureCell

+ (instancetype)cellWithTableView:(UITableView *)tableView withIndexPath:(NSIndexPath *)indexPath withIdentifies:(NSString *)identify
{
    JobCircleTagAndPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell == nil) {
        
        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)setContentWithTableview:(UITableView *)tableview withIndexPath:(NSIndexPath *)indexPath withParentController:(id)parentController{
    if (indexPath.row == 1) {
        
        _smallSectionPicture.image = [UIImage imageNamed:@"addStateTag"];
        _sectionTitle.text = @"状态标签";
        [self createMyTagsView:parentController];

        
    }else{
    
        _sectionTitle.text = @"添加图片（最多6张）";
        

    }
    
}

//- (void)createUploadPhoto:(id)parentController{
//
//    
//}

- (void)createMyTagsView:(id)parentController{
    self.tagListView = [[TagListView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 250)];
    self.tagListView.delegate = parentController;
    self.tagListView.backgroundColor = [UIColor whiteColor];
    [self.tagListView addTagWithArray:@[@"下班了", @"找工作", @"辞职了", @"招聘", @"求助", @"吐槽",@"找合伙人",@"找实习",@"睡不着", @"出大事了", @"未婚",@"创意", @"+ 自定义"] withHasCustomTag:YES];
    _tagListView.tagBackgroundColor = [UIColor colorWithWhite:0.964 alpha:1.000];
    _tagListView.cornerRadius = 15;
    _tagListView.borderWidth = 0;
    _tagListView.paddingY = 8;
    _tagListView.paddingX = 15;
    _tagListView.marginX = 15;
    _tagListView.marginY = 15;
    _tagListView.textColor = [UIColor colorWithWhite:0.648 alpha:1.000];
    
    [self.cellContentView addSubview:_tagListView];
    
    [_tagListView.subviews enumerateObjectsUsingBlock:^( TagView * tagView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([[tagView currentTitle] isEqualToString:@"+ 自定义"]) {
            
            [tagView setOnTap:^(TagView *tagView) {
                
                self.stAlertView = [[STAlertView alloc] initWithTitle:@"自定义标签"
                                                              message:nil
                                                        textFieldHint:@"自定义标签"
                                                       textFieldValue:nil
                                                    cancelButtonTitle:@"取消"
                                                    otherButtonTitles:@"确定"
                                                    cancelButtonBlock:^{
                                                        NSLog(@"Please, give me some feedback!");
                                                    } otherButtonBlock:^(NSString * result){
                                                        [_tagListView addTag:result];
                                                        
                                                        [self resetTagViewFrameWithLastTag:tagView];
                                                        
                                                    }];
                
            }];
        }
        else{
            [tagView setOnTap:^(TagView *tagView) {
                [self changeSelectTagViewState:tagView];
                
            }];
            
        }
        
        if (idx == _tagListView.subviews.count - 1) {
            
            
            [self resetTagViewFrameWithLastTag:tagView];
        }
        
        
    }];
    
}

- (void)resetTagViewFrameWithLastTag:(TagView *)tagView{
    
    CGRect frame = CGRectMake(0, 0, SCREEN_WIDTH, tagView.y + tagView.height + 20);
    _tagListView.frame = frame;
}

- (void)changeSelectTagViewState:(TagView *)tagView{
    

    if (!tagView.selected) {

            TagView *preTag = [_selectArray firstObject];
            preTag.backgroundColor = _tagListView.tagBackgroundColor;
            preTag.textColor = _tagListView.textColor;
            preTag.selected = !preTag.selected;
            [self.selectArray removeObject:preTag];
        
//        if ([_selectArray indexOfObject:tagView] == NSNotFound) {
                tagView.backgroundColor = [UIColor colorWithRed:0.326 green:0.658 blue:1.000 alpha:1.000];
                tagView.textColor = [UIColor whiteColor];
                tagView.selected = !tagView.selected;

                [self.selectArray addObject:tagView];
//        }
        
    }
//     再次点击取消状态
    else{
        
        TagView *preTag = [_selectArray firstObject];
        preTag.backgroundColor = _tagListView.tagBackgroundColor;
        preTag.textColor = _tagListView.textColor;
        [self.selectArray removeObject:preTag];
        tagView.selected = !tagView.selected;

        
    }
}

- (NSMutableArray *)selectArray{
    
    if (_selectArray == nil) {
        _selectArray = [NSMutableArray array];
    }
    return  _selectArray;
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
