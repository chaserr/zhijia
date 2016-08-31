//
//  GBMyInfoHaveDetailCell.m
//  zhijia
//
//  Created by 童星 on 16/3/29.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBMyInfoHaveDetailCell.h"
@interface GBMyInfoHaveDetailCell ()


@property (nonatomic, strong) NSMutableArray *detailMsgArr;
@end

@implementation GBMyInfoHaveDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)defaultCellWithFrame:(CGRect)frame{
    
    return [[GBMyInfoHaveDetailCell alloc]initWithFrame:frame];
}



- (void)setContentMsgWithIndexPath:(NSIndexPath *)indexPath withTitleArr:(NSArray *)titleArray withDetailString:(NSString *)detailString withParentController:(id)parentController{

    if (indexPath.section == 0) {

        switch (indexPath.row) {
            case 1:{
                _arrowImg.hidden = YES;
                
            }
                break;
            case 2:{
            
                _arrowImg.hidden = YES;

            }
                
                break;
            case 3:
            {
                _cellDetail.enabled = NO;


            }
                break;
            case 4:
            {
                _arrowImg.hidden = YES;


            }
                break;
            case 5:
            {
            
                _arrowImg.hidden = YES;

            }
                break;
            case 6:
            {
            
                _cellDetail.enabled = NO;

            }
                break;
            case 7:
            {
            
                _cellDetail.enabled = NO;

            }
                break;
            default:
                break;
        }
    }
    else{
    
        switch (indexPath.row) {
            case 0:{
            
                _arrowImg.hidden = YES;

            }
                break;
            case 1:{
                _cellDetail.enabled = NO;

            }
                break;
            case 2:{
            
                _arrowImg.hidden = NO;
                _cellDetail.enabled = NO;


            }
                break;
            case 3:{
            
                _arrowImg.hidden = YES;

            }
                break;
            default:
                break;
        }
    }
    
    if (detailString) {
        _cellDetail.text = detailString;
    }else{
        _cellDetail.clearsOnInsertion = YES;
        _cellDetail.placeholder =  [[self.detailMsgArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    }
    _cellDetail.delegate = parentController;
    _cellTitle.text =  [[titleArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    [self setNeedsUpdateConstraints];

}


- (void)updateConstraints{

    [super updateConstraints];
    if (_arrowImg.hidden) {
        self.rightMarginConsTocell.active = YES;
        _cellDetail.clearButtonMode = UITextFieldViewModeUnlessEditing;
    }else{
    
        self.rightMarginConsTocell.active = NO;

    }
}

- (NSMutableArray *)detailMsgArr{
    
    if (_detailMsgArr == nil) {
        
        NSArray *sectionOneArray = @[@"", @"填写真实姓名", @"填写生日信息", @"选择行业", @"填写公司名称", @"填写职位名称", @"至少三个标签", @"填写个人签名"];
        NSArray *sectionTwoArray = @[@"你工作过多少年", @"选择学校", @"填写你的工作经历", @"输入月收入薪资"];
        _detailMsgArr = [NSMutableArray arrayWithObjects:sectionOneArray, sectionTwoArray ,nil];
    }
    return  _detailMsgArr;
}


// 代码结合xib创建cell
- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self = (GBMyInfoHaveDetailCell *)[[[NSBundle mainBundle] loadNibNamed:[[self class] description] owner:self options:nil] lastObject];
        

    }
    return self;
}



@end
