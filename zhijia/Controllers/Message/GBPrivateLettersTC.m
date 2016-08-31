//
//  GBPrivateLettersTC.m
//  zhijia
//
//  Created by admin on 15/7/30.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBPrivateLettersTC.h"

@interface GBPrivateLettersTC ()<CDChatListVCDelegate>

@end

@implementation GBPrivateLettersTC

- (instancetype)init {
    self = [super init];
    if (self) {
        self.chatListDelegate = self;
        //self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark    -delegate

//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return 10;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 110;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableviewcell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"tableviewcell"];
//    }
//    
//    cell.textLabel.text = @"这是一个测试";
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%lu",indexPath.row];
//    cell.backgroundColor = [UIColor redColor];
//    return cell;
//}

//- (void)viewController:(UIViewController *)viewController didSelectConv:(AVIMConversation *)conv {
//    [[CDIMService service] goWithConv:conv fromNav:viewController.navigationController];
//}

- (void)setBadgeWithTotalUnreadCount:(NSInteger)totalUnreadCount {
    if (totalUnreadCount > 0) {
        self.tabBarItem.badgeValue = [NSString stringWithFormat:@"%ld", (long)totalUnreadCount];
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:totalUnreadCount];
    }
    else {
        self.tabBarItem.badgeValue = nil;
        [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    }
}
@end
