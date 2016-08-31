//
//  GBUserSpaceViewController.m
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

static NSString * UserSpaceBaseCellID = @"UserSpaceBaseCell";
static NSString * UserSpaceDynamicAndTagCellID = @"UserSpaceDynamicAndTagCell";
static NSString * UserSpaceDetailContentID = @"UserSpaceDetailContent";

#import "GBUserSpaceViewController.h"
#import "GBTableViewBaseCell.h"
#import "GBUserSpaceSubTitleCell.h"
#import "GBUserSpaceDetailCell.h"
#import "GBUserSpaceHeadView.h"
#import "GBUserSpaceFooterView.h"
@interface GBUserSpaceViewController (){
    
    UIView* _navigationBarView;
    UILabel* _navBarTitleLabel;
    
}

@property (nonatomic, strong) NSMutableDictionary *cellTitleDict;

@property (nonatomic, strong) GBUserSpaceHeadView *tableviewHeaderView;
@property (nonatomic, strong) IBOutlet UIView *userspaceFooterView;
@property (weak, nonatomic) IBOutlet GBImageView *footerUserPortrial;
@property (weak, nonatomic) IBOutlet UILabel *footerUserName;
@property (weak, nonatomic) IBOutlet UILabel *footerUserJobDesc;


// 自定义半透明模糊导航条
@property (nonatomic, strong) UIVisualEffectView *visualEfView;
@property (nonatomic, strong) UIButton           *backLeftBtn;
@property (nonatomic, strong) UIButton           *cameraBtn;

@end

@implementation GBUserSpaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupNavbarView];
    [self setupNavbarButtons];
    self.navigationTitleLabel.text = @"陈程";
    self.view.backgroundColor = [UIColor colorWithWhite:0.960 alpha:1.000];
    [self createTableview];
    [self createTableHeaderView];
    [self createTableFooterView];
    
}

#pragma mark -- UITableviewDelegate/dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [self.cellTitleDict allKeys].count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return ((NSArray *)[self.cellTitleDict objectForKey:[NSString stringWithFormat:@"%ld", (long)section]]).count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    if (section == 0) {
        return 0;
    }else{
    
        return 15;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        return 50;
    }
    else if (indexPath.section == 1){
    
        return 90;
    }
    else if (indexPath.section == 2){
    
        return 70;
    }
    else{
    
        return 200;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell;
    NSArray *cellTitle = [self.cellTitleDict objectForKey:[NSString stringWithFormat:@"%ld", (long)indexPath.section]];

    if (indexPath.section == 0) {
        
        GBTableViewBaseCell *baseCell = [tableView dequeueReusableCellWithIdentifier:UserSpaceBaseCellID];
        if (!baseCell) {
            baseCell = [[[NSBundle mainBundle] loadNibNamed:@"GBTableViewBaseCell" owner:self options:nil] lastObject];
        }
        switch (indexPath.row) {
            case 0:
                baseCell.cellLeftDetail.text = @"13800198000";
                break;
            case 1:
                baseCell.cellLeftDetail.text = @"lovaxiang@126.com";
                break;
            case 2:
                baseCell.cellLeftDetail.text = @"互联网圈子的人";
                break;
            case 3:
                baseCell.cellLeftDetail.text = @"希望认识更多的技术朋友";
                break;
                
            default:
                break;
        }
        baseCell.cellTitle.textColor = [UIColor colorWithWhite:0.738 alpha:1.000];
        baseCell.cellTitle.text = [cellTitle objectAtIndex:indexPath.row];
        cell = baseCell;
        
    }
    else if (indexPath.section == 1 || indexPath.section == 2){
    
        GBUserSpaceSubTitleCell *dynamicAndTagCell = [tableView dequeueReusableCellWithIdentifier:UserSpaceDynamicAndTagCellID forIndexPath:indexPath];
        dynamicAndTagCell.cellTitle.text = [cellTitle objectAtIndex:indexPath.row];
        dynamicAndTagCell.cellTitle.textColor = [UIColor colorWithWhite:0.738 alpha:1.000];
        [dynamicAndTagCell setContentMsgWithIndexPath:indexPath withTitleArr:nil withParentController:self];
        cell = dynamicAndTagCell;
    
    }else {
    
        GBUserSpaceDetailCell *detailContentCell = [tableView dequeueReusableCellWithIdentifier:UserSpaceDetailContentID forIndexPath:indexPath];
        
        detailContentCell.cellTitle.text = [cellTitle objectAtIndex:indexPath.row];
        detailContentCell.cellTitle.textColor = [UIColor colorWithWhite:0.738 alpha:1.000];


        cell = detailContentCell;
    }
    
    
    
    return cell;
}


#pragma mark -- UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    UIColor *color = [UIColor blackColor];
    CGFloat offset=scrollView.contentOffset.y;

        CGFloat alpha= 1 -((_tableviewHeaderView.height - 64 -offset)/ (_tableviewHeaderView.height - 64));
    if (alpha > 1) {
        alpha = 1;
    }
    _navBarTitleLabel.text = @"陈程";
    _navBarTitleLabel.alpha = alpha;
    _visualEfView.alpha = alpha;

//    _navigationBarView.backgroundColor = [color colorWithAlphaComponent:alpha];

}

#pragma mark -- Action

- (void)createTableview {
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    
    self.tableView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.tableView setSeparatorStyle:(UITableViewCellSeparatorStyleNone)];
    [self.tableView registerNib:[UINib nibWithNibName:@"GBTableViewBaseCell" bundle:nil] forCellReuseIdentifier:UserSpaceBaseCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GBUserSpaceSubTitleCell" bundle:nil] forCellReuseIdentifier:UserSpaceDynamicAndTagCellID];
    [self.tableView registerNib:[UINib nibWithNibName:@"GBUserSpaceDetailCell" bundle:nil] forCellReuseIdentifier:UserSpaceDetailContentID];
}

- (void)createTableHeaderView{

    self.tableviewHeaderView = [GBUserSpaceHeadView defaultUserSpaceHeaderView:CGRectMake(0, 0, SCREEN_WIDTH, 240)];
    [_tableviewHeaderView.userProtrial setImage:[UIImage imageNamed:@"testPhoto"]];
    UIImage *image = [UIImage imageNamed:@"testPhoto"];
    image = [UIImage blurImage:image withBlurLevel:1];
    
    _tableviewHeaderView.bgImageView.image = image;
    self.tableView.tableHeaderView = _tableviewHeaderView;
}

- (void)createTableFooterView{

   self.userspaceFooterView = [[[NSBundle mainBundle] loadNibNamed:@"GBUserSpaceFooterView" owner:self options:nil] lastObject];
    _userspaceFooterView.frame = CGRectMake(0, SCREEN_HEIGHT - 64 ,SCREEN_WIDTH, 64);

    [_footerUserPortrial setImage:[UIImage imageNamed:@"testPhoto"]];
    [self.view addSubview:_userspaceFooterView];

}

- (void)setupNavbarView
{
    CGRect naviBarRect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    
    _navigationBarView= [[UIView alloc] initWithFrame:naviBarRect];
    _navigationBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navigationBarView];
    
    self.visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    _visualEfView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _navigationBarView.height);
//    _visualEfView.backgroundColor = [UIColor clearColor];
    _visualEfView.alpha = 0;
    [_navigationBarView addSubview:_visualEfView];
    
    CGRect navBarTitleRect = [UtilFunc bottomCenterRect:naviBarRect width:250 height:44 offset:0];
    navBarTitleRect = CGRectInset(navBarTitleRect, 0, 8);
    _navBarTitleLabel = [[UILabel alloc] initWithFrame:navBarTitleRect];
    _navBarTitleLabel.textColor = [UIColor whiteColor];
//    _navBarTitleLabel.text = @"露脸"; 
    _navBarTitleLabel.textAlignment = NSTextAlignmentCenter;
    [_navBarTitleLabel setFont:GBBoldFont(18)];
    [_navigationBarView addSubview:_navBarTitleLabel];
    
}

// 导航
- (void)setupNavbarButtons
{
    
    UIButton *buttonBack = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *backImage = [UIImage imageNamed:@"userinfo_navigationbar_back_withtext"];
    //    UIImage* image = [UIImage imageNamed:@"common_navbar_back"];
    
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    rect = [UtilFunc bottomRect:rect height:44 offset:0];
    rect = CGRectInset(rect, 12, 4);
    
    buttonBack.frame = CGRectMake(10, 20, 50,44);
    buttonBack.imageEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 10);
    [buttonBack setImage:backImage forState:UIControlStateNormal];
    [buttonBack addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.backLeftBtn = buttonBack;
    [self.view addSubview:buttonBack];
    
    // 更多按钮()
    _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    rect = [UtilFunc bottomRect:rect height:44 offset:0];
    rect = CGRectInset(rect, 12, 4);
    
    CGRect moreBtnRects = CGRectMake( (SCREEN_WIDTH - 38) - 10, 20 , 38, 44);
    _cameraBtn.frame = moreBtnRects;
    [_cameraBtn setImage:[UIImage imageNamed:@"userspace_share"] forState:UIControlStateNormal];
    [_cameraBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_cameraBtn];
    
}

- (void)moreBtnClicked:(id)sender{
    
    DLog(@"调用相机");
    
}

- (IBAction)footerHiBtnAction:(id)sender {
    DLog(@"发消息");
    [GBHUDVIEW showTips:@"申请成功，请等待对方通过" autoHideTime:2];
}

- (IBAction)footerAddFriendAction:(id)sender {

    DLog(@"成为好友");
}


- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:YES animated:YES];

}

- (void)viewWillDisappear:(BOOL)animated{

    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

// 懒加载
- (NSMutableDictionary *)cellTitleDict{
    
    if (!_cellTitleDict) {
        NSArray *sectionOne = [NSArray arrayWithObjects:@"电话",@"邮箱", @"圈子", @"签名", nil];
        NSArray *sectionTwo = [NSArray arrayWithObjects:@"她的动态", nil];
        NSArray *sectionThree = [NSArray arrayWithObjects:@"工作标签", nil];
        NSArray *sectionFour = [NSArray arrayWithObjects:@"自我评价", nil];
        NSArray *sectionFive = [NSArray arrayWithObjects:@"工作经历", nil];

        NSArray *titleArray = [NSArray arrayWithObjects:sectionOne, sectionTwo, sectionThree, sectionFour, sectionFive, nil];
        NSArray *sectionArray = [NSArray arrayWithObjects:@"0", @"1", @"2", @"3", @"4", nil];
        _cellTitleDict = [NSMutableDictionary dictionaryWithObjects:titleArray forKeys:sectionArray];
    }
    return _cellTitleDict;
    
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
