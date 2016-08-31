//
//  EICheckBox.m
//  EInsure
//
//  Created by ivan on 13-7-9.
//  Copyright (c) 2013年 ivan. All rights reserved.
//

#import "QCheckBox.h"

#define Q_CHECK_ICON_WH                    (15.0)
#define Q_ICON_TITLE_MARGIN                (5.0)

@interface QCheckBox ()

@property (nonatomic, assign) BOOL shouldSelect;
@end

@implementation QCheckBox

@synthesize delegate = _delegate;
@synthesize checked = _checked;
@synthesize userInfo = _userInfo;

- (void)awakeFromNib{
   
    self.exclusiveTouch = YES;

    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.exclusiveTouch = YES;
        [self setImage:[UIImage imageNamed:@"register_unagreedelegate_icon"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"register_agreedelegate_icon"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (id)initWithDelegate:(id)delegate {
    self = [super init];
    if (self) {
        _delegate = delegate;
        
        self.exclusiveTouch = YES;
        [self setImage:[UIImage imageNamed:@"register_unagreedelegate_icon"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"register_agreedelegate_icon"] forState:UIControlStateSelected];
        [self addTarget:self action:@selector(checkboxBtnChecked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setChecked:(BOOL)checked {
    if (_checked == checked) {
        return;
    }
    
    _checked = checked;
    self.selected = checked;
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
}

- (void)checkboxBtnChecked {
    
    if (_delegate && [_delegate respondsToSelector:@selector(shouldSelectedCheckBox:checked:)]) {
       self.shouldSelect = [_delegate shouldSelectedCheckBox:self checked:self.selected];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedCheckBox:checked:)]) {
        [_delegate didSelectedCheckBox:self checked:self.selected];
    }
    
    if (_shouldSelect) {
        self.selected = !self.selected;
        _checked = self.selected;
    }
}

//- (CGRect)imageRectForContentRect:(CGRect)contentRect {
//    return CGRectMake(0, (CGRectGetHeight(contentRect) - Q_CHECK_ICON_WH)/2.0, Q_CHECK_ICON_WH, Q_CHECK_ICON_WH);
//}
//
//- (CGRect)titleRectForContentRect:(CGRect)contentRect {
//    return CGRectMake(Q_CHECK_ICON_WH + Q_ICON_TITLE_MARGIN, 0,
//                      CGRectGetWidth(contentRect) - Q_CHECK_ICON_WH - Q_ICON_TITLE_MARGIN,
//                      CGRectGetHeight(contentRect));
//}



@end
