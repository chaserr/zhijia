//
//  GBDiscoveryVC.m
//  zhijia
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBDiscoveryVC.h"
#import "GBPlazaTC.h"
#import "GBBesideJobPeopleCell.h"
#import "GBLeftImg_Title_DetailTitle_Cell.h"
#import "GBShowFaceViewController.h"
#import "GBDiscoverBesidePeopleVC.h"
static NSString *DiscoverBesideCellID = @"discoverBesideCellID";
static NSString *LeftImg_Title_DetailTitile_Cell
 = @"LeftImg_Title_DetailTitile_Cell";

@interface GBDiscoveryVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, strong) NSMutableArray *cellImageArray;
@property (nonatomic, strong) UITableView *tableview;


@end

@implementation GBDiscoveryVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.translucent = NO; // 透明设置为YES
    self.navigationTitleLabel.text = @"发现";

    
    [self createTableView];
    

}


- (void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];

}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
}

- (void)viewWillDisappear:(BOOL)animated{

    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.translucent = YES; // 透明设置为YES

}

- (void)createTableView{
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT -64 -49) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor groupTableViewBackgroundColor];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    _tableview.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;

    _tableview.autoresizesSubviews = YES;
    [[_tableview subviews] firstObject].autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _tableview.tableHeaderView = [UIView new];
    _tableview.tableFooterView = [UIView new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"GBBesideJobPeopleCell" bundle:nil] forCellReuseIdentifier:DiscoverBesideCellID];
    [self.tableview registerNib:[UINib nibWithNibName:@"GBLeftImg_Title_DetailTitle_Cell" bundle:nil] forCellReuseIdentifier:LeftImg_Title_DetailTitile_Cell];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.sectionArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 140;
    }else{
    
        return 60;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    if (indexPath.section == 0) {
        GBBesideJobPeopleCell *beaideCell = [tableView dequeueReusableCellWithIdentifier:DiscoverBesideCellID forIndexPath:indexPath];
        [beaideCell setContentWithTableview:tableView withIndexPath:indexPath withParentController:self];

        beaideCell.cellTitle = self.sectionArray[indexPath.section];
        beaideCell.cellImage.image = [UIImage imageNamed:self.cellImageArray[indexPath.section]];
        cell = beaideCell;

    }else{
    
        GBLeftImg_Title_DetailTitle_Cell *commonCell = [tableView dequeueReusableCellWithIdentifier:LeftImg_Title_DetailTitile_Cell forIndexPath:indexPath];
        commonCell.cellTitleLabel.text = self.sectionArray[indexPath.section];
        commonCell.cellLeftImg.image = [UIImage imageNamed:self.cellImageArray[indexPath.section]];
        if (indexPath.section == 1) {
            commonCell.cellDetailLabel.text = @"这一刻，他们正在露脸";
        }else{
        
            commonCell.cellDetailLabel.text = @"加入你身边的工作圈子";
        }
        cell = commonCell;
    }
    

    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.section) {
        case 0:
        {
            GBDiscoverBesidePeopleVC *besideVC = [[GBDiscoverBesidePeopleVC alloc] init];
            [AppNavigator pushViewController:besideVC animated:YES];
        }
            break;
        case 1:
        {
        
            GBShowFaceViewController *showFaceVC = [[GBShowFaceViewController alloc] init];
            [self.navigationController pushViewController:showFaceVC animated:YES];
        }
            break;
        case 2:
        {}
            break;
            
        default:
            break;
    }
    
}
// 懒加载
- (NSMutableArray *)sectionArray{
    
    if (!_sectionArray) {
        _sectionArray = [NSMutableArray arrayWithObjects:@"身边工作的人",@"露脸",@"工作圈子",nil];
    }
    return _sectionArray;
}

- (NSMutableArray *)cellImageArray{
    
    if (!_cellImageArray) {
        _cellImageArray = [NSMutableArray arrayWithObjects:@"discover_icon_beside", @"discover_icon_jobcircle", @"discover_icon_showface", nil];
    }
    return _cellImageArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
