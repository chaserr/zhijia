//
//  SelectIndustryVC.m
//  zhijia
//
//  Created by 童星 on 16/3/28.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBSelectIndustryVC.h"
#import "GBAssociationMenuView.h"
@interface GBSelectIndustryVC ()<GBAssociationMenuViewDelegate>

@property (nonatomic, strong) GBAssociationMenuView *industryDetailVC;
@property (nonatomic, strong) NSArray *arr;

@end

@implementation GBSelectIndustryVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"选择行业";
    [self customlizeNavigationBarBackBtn];
    self.navigationItem.rightBarButtonItem =({
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveMySelectIndustry)];
        rightItem;
    });
    self.industryDetailVC = [GBAssociationMenuView new];
    _industryDetailVC.delegate = self;
    
//    UIButton *buto = [UIButton buttonWithType:(UIButtonTypeSystem)];
//    buto.frame = CGRectMake(100, 100, 200, 200);
//    buto.backgroundColor = [UIColor redColor];
//    [buto addTarget:self action:@selector(click:) forControlEvents:(UIControlEventTouchUpInside)];
//    [self.view addSubview:buto];
  

    
    self.arr = @[
                 @{@"信息技术":@[@"hahah",@"hahah2",@"hahah1",@"hahah",@"hahah"]},
                 @{@"广告媒体":@[@"电视媒体",@"报纸媒体",@"广播媒体",@"杂志媒体",@"户外媒体",@"其他媒体",@"广告新媒体"]},
                 @{@"网络游戏":@[@"说说",@"hahah2",@"什么",@"hahah",@"hahah"]},
                 @{@"金融理财":@[@"来看看离开了",@"hahah2",@"看见就看见快乐",@"离开就离开离开",@"但撒的"]}
                 ];
    
    [_industryDetailVC showAsDrawDownView:self];

    
}



- (NSInteger)assciationMenuView:(GBAssociationMenuView*)asView countForClass:(NSInteger)idx withUpCell:(NSInteger)cellPosition{
    if (idx == 0) {
        return _arr.count;
    }else{
        NSDictionary *dict = [_arr objectAtIndex:cellPosition];
        NSArray *arr = [dict objectForKey:[[dict allKeys] firstObject]];
        return arr.count;
    }
}

- (NSString*)assciationMenuView:(GBAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 {
    NSDictionary *dict = [_arr objectAtIndex:idx_1];
    NSString *title = [[dict allKeys] firstObject];
    return title;
}

- (NSString*)assciationMenuView:(GBAssociationMenuView*)asView titleForClass_1:(NSInteger)idx_1 class_2:(NSInteger)idx_2 {
    NSDictionary *dict = [_arr objectAtIndex:idx_1];
    NSArray *titlearr = [dict objectForKey: [[dict allKeys] firstObject]];
    NSString *str = [titlearr objectAtIndex:idx_2];
    return str;
}



- (BOOL)assciationMenuView:(GBAssociationMenuView*)asView idxChooseInClass1:(NSInteger)idx_1 class2:(NSInteger)idx_2{
    DLog(@"indexpath %ld, %ld", idx_1, idx_2);

    return NO;
}

- (BOOL)idx_2ChooseInClassShouldDismiss{

    return NO;
}



#pragma mark - save data
- (void)saveMySelectIndustry{

    DLog(@"save data");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
