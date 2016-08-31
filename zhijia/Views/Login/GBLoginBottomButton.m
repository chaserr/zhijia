//
//  GBLoginBottomButton.m
//  zhijia
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBLoginBottomButton.h"
#import "GBDefines.h"

@implementation GBLoginBottomButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup {
    [self setBackgroundImage:[UIImage imageNamed:@"blue_expand_normal"] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageNamed:@"blue_expand_highlight"] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageNamed:@"blue_expand_disable"] forState:UIControlStateDisabled];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
@end
