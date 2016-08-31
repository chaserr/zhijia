//
//  GBTabBar.m
//  zhijia
//
//  Created by admin on 15/7/17.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBTabBar.h"
@interface GBTabBar()
@property (nonatomic ,weak) UIButton *issueButton;
@end
@implementation GBTabBar

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
//        if (!IOS_7_OR_LATER) {
//            self.backgroundImage = [UIImage imageNamed:@"tabbar_backgroud"];
//        }
//        self.backgroundColor = [UIColor whiteColor];
        //self.backgroundColor=GBTabbarColor;
        //self.selectionIndicatorImage = [UIImage imageNamed:@"navigationbar_button_background"];
        
        [self setupIssueButton];
    }
    
    return  self;
}
- (void)setupIssueButton {
    
    UIButton *issueButton = [[UIButton alloc] init];

    [issueButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
    [issueButton setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];

    [issueButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
    [issueButton setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    [issueButton addTarget:self action:@selector(issueClick) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:issueButton];
    self.issueButton = issueButton;
}
- (void)issueClick {

    
}


- (void)layoutSubviews {
    [super layoutSubviews];

    [self setupIssueButtonFrame];

    [self setupAllTabBarButtonsFrame];
}

- (void)setupIssueButtonFrame {
    self.issueButton.size = self.issueButton.currentBackgroundImage.size;
    self.issueButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
}

- (void)setupAllTabBarButtonsFrame {
    int index = 0;
    for (UIView *tabBarButton in self.subviews){
        if (![tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) continue;
        [self setupTabBarButtonFrame:tabBarButton atIndex:index];
        
        index++;
    }
}
- (void)setupTabBarButtonFrame:(UIView *)tabBarButton atIndex:(int)index
{
    CGFloat buttonW = self.width / (self.items.count + 1);
    CGFloat buttonH = self.height;
    
    tabBarButton.width = buttonW;
    tabBarButton.height = buttonH;
    if (index >= 2) {
        tabBarButton.x = buttonW * (index + 1);
    } else {
        tabBarButton.x = buttonW * index;
    }
    tabBarButton.y = 0;
}

@end
