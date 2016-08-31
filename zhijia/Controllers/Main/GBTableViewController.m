//
//  GBTableViewController.m
//  zhijia
//
//  Created by admin on 15/7/22.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBTableViewController.h"

@interface GBTableViewController ()

@end

@implementation GBTableViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        //self.edgesForExtendedLayout = UIRectEdgeAll;
        self.tableViewStyle = UITableViewStylePlain;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)loadDataSource {
    
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    if ([UIDevice isHigherIOS7])
    {
        negativeSpacer.width = -10;
    }
    else
    {
        negativeSpacer.width = 4.0;
    }
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barButtonItem, nil];
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    if ([UIDevice isHigherIOS7])
    {
        negativeSpacer.width = -10;
    }
    else
    {
        negativeSpacer.width = 4.0;
    }
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barButtonItem, nil];
}
//
//-(UITableView *)tableView
//{
//    if (!_tableView) {
//        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
//        _tableView.delegate = self;
//        _tableView.dataSource = self;
//    }
//    return _tableView;
//}

- (CGFloat)getAdapterHeight {
    CGFloat adapterHeight = 0;
    if ([[[UIDevice currentDevice] systemVersion] integerValue] < 7.0) {
        adapterHeight = 44;
    }
    return adapterHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
}

#pragma mark - delegate

-(UIScrollView *)streachScrollView
{
    return self.tableView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}


-(void)showNetworkIndicator{
    UIApplication* app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible=YES;
}

-(void)hideNetworkIndicator{
    UIApplication* app=[UIApplication sharedApplication];
    app.networkActivityIndicatorVisible=NO;
}

-(void)showProgress{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)hideProgress{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(void)showHUDText:(NSString*)text{
    MBProgressHUD* hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText=text;
    hud.margin=10.f;
    hud.removeFromSuperViewOnHide=YES;
    hud.mode=MBProgressHUDModeText;
    [hud hide:YES afterDelay:2];
}

-(void)runInMainQueue:(void (^)())queue{
    dispatch_async(dispatch_get_main_queue(), queue);
}

-(void)runInGlobalQueue:(void (^)())queue{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), queue);
}

-(void)runAfterSecs:(float)secs block:(void (^)())block{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, secs*NSEC_PER_SEC), dispatch_get_main_queue(), block);
}
-(void)alert:(NSString*)msg{
    UIAlertView *alertView=[[UIAlertView alloc]
                            initWithTitle:nil message:msg delegate:nil
                            cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alertView show];
}

@end
