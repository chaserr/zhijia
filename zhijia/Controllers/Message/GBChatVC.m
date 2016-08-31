//
//  GBChatVC.m
//  zhijia
//
//  Created by admin on 15/7/31.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBChatVC.h"
//#import "AVIMUserInfoMessage.h"

@interface GBChatVC ()

@end

@implementation GBChatVC

//- (instancetype)initWithConv:(AVIMConversation *)conv {
//    self = [super initWithConv:conv];
//    //[[CDCacheManager manager] setCurConv:conv];
//    return self;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"个人" style:UIBarButtonItemStylePlain target:self action:@selector(goChatGroupDetail:)];
    self.navigationItem.rightBarButtonItem = item;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testSendCustomeMessage {
//    AVIMUserInfoMessage *userInfoMessage = [AVIMUserInfoMessage messageWithAttributes:@{ @"nickname":@"lzw" }];
//    [self.conv sendMessage:userInfoMessage callback: ^(BOOL succeeded, NSError *error) {
//        DLog(@"%@", error);
//    }];
}
- (void)goChatGroupDetail:(id)sender {
    //[self.navigationController pushViewController:[[CDConvDetailVC alloc] init] animated:YES];
}

- (void)didSelectedAvatorOnMessage:(id<XHMessageModel>)message atIndexPath:(NSIndexPath *)indexPath {
//    AVIMTypedMessage *msg = self.msgs[indexPath.row];
//    if ([msg.clientId isEqualToString:[CDChatManager manager].selfId] == NO) {
////        CDUserInfoVC *userInfoVC = [[CDUserInfoVC alloc] initWithUser:[[CDCacheManager manager] lookupUser:msg.clientId]];
////        [self.navigationController pushViewController:userInfoVC animated:YES];
//    }
}

- (void)didInputAtSignOnMessageTextView:(XHMessageTextView *)messageInputTextView {
//    if (self.conv.type == CDConvTypeGroup) {
//        [self performSelector:@selector(goSelectMemberVC) withObject:nil afterDelay:0];
//        // weird , call below function not input @
//        //        [self goSelectMemberVC];
//    }
}

- (void)goSelectMemberVC {
//    CDSelectMemberVC *selectMemberVC = [[CDSelectMemberVC alloc] init];
//    selectMemberVC.selectMemberVCDelegate = self;
//    selectMemberVC.conversation = self.conv;
//    CDBaseNavC *nav = [[CDBaseNavC alloc] initWithRootViewController:selectMemberVC];
//    [self presentViewController:nav animated:YES completion:nil];
}

//- (void)didSelectMember:(AVUser *)member {
////    self.messageInputView.inputTextView.text = [NSString stringWithFormat:@"%@%@ ", self.messageInputView.inputTextView.text, member.username];
//    [self performSelector:@selector(messageInputViewBecomeFristResponder) withObject:nil afterDelay:0];
//}

- (void)messageInputViewBecomeFristResponder {
    [self.messageInputView.inputTextView becomeFirstResponder];
}
@end
