//
//  GBStartPageNVC.m
//  zhijia
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBStartPageNVC.h"

@interface GBStartPageNVC ()

@end

@implementation GBStartPageNVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationBar setBarTintColor:GBStarNavigationColor];
    
    [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                [UIColor whiteColor],NSForegroundColorAttributeName,GBNavigationBarFont(19),NSFontAttributeName,nil]];
    
    [self.navigationBar setTranslucent:NO];
    
    self.navigationBar.tintColor=[UIColor whiteColor];
    
    if ([self.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
        [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"start_common_bg"]
                                 forBarMetrics:UIBarMetricsDefault];
    }
    
    self.navigationBar.shadowImage = [[UIImage alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
