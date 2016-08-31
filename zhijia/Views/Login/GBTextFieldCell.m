//
//  GBTextFieldCell.m
//  zhijia
//
//  Created by nana on 16/3/20.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBTextFieldCell.h"
@interface GBTextFieldCell()
@property (nonatomic, strong) UIImageView * icon;
@property (nonatomic, strong) UITextField * inputTextField;
@property (nonatomic, strong) NSString * placeHolder;
@property (nonatomic, strong) UIButton * operateBtn;

@end

@implementation GBTextFieldCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _icon =[[UIImageView alloc] init];
        [self.contentView addSubview:_icon];
        
        _inputTextField = [[UITextField alloc] init];
        _inputTextField.placeholder = _placeHolder;
        _inputTextField.borderStyle = UITextBorderStyleNone;
        [self.contentView addSubview:_inputTextField];
        
//        _operateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _operateBtn addTarget:self action:@selector(<#selector#>) forControlEvents:<#(UIControlEvents)#>
    
    }
    return self;
}

- (void) setIconImage:(UIImage *)image
{
    _icon.image = image;
}


-(void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    
    CGSize imageSize = _icon.image.size;
    _icon.frame = LeftCenterRect(rect, imageSize.width, imageSize.height, 10);
    
    DeflateRect(&rect, CGRectGetWidth(_icon.bounds) + 10, 0, 0, 0);
    _inputTextField.frame = LeftCenterRect(rect, CGRectGetWidth(rect) - 40, 30, 10);

}
- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
