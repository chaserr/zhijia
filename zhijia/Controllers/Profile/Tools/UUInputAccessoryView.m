//
//  inputAccessoryView.m
//  InputAccessoryView-WindowLayer
//
//  Created by shake on 14/11/14.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUInputAccessoryView.h"
#define UUIAV_MAIN_W    CGRectGetWidth([UIScreen mainScreen].bounds)
#define UUIAV_MAIN_H    CGRectGetHeight([UIScreen mainScreen].bounds)
#define UUIAV_Edge_Hori 5
#define UUIAV_Edge_Vert 7
#define UUIAV_Btn_W    40
#define UUIAV_Btn_H    35


@interface UUInputAccessoryView ()<UITextViewDelegate>
{
    UUInputAccessoryBlock inputBlock;

    UIButton *btnBack;
    UITextView *inputView;
    UITextField *assistView;
    UIButton *BtnSave;
    // dirty code for iOS9
    BOOL shouldDismiss;
}

@property (nonatomic, strong) UIViewController *viewcontroller;
@end

@implementation UUInputAccessoryView

DEF_SINGLETON(UUInputAccessoryView)

- (void)sharedViewWithController:(UIViewController *)viewController {
    static dispatch_once_t once;
    static UUInputAccessoryView *sharedView;
    dispatch_once(&once, ^ {
        sharedView = [[UUInputAccessoryView alloc] init];
        
        btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
        btnBack.frame = CGRectMake(0, 0, UUIAV_MAIN_W, UUIAV_MAIN_H);
        [btnBack addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        btnBack.backgroundColor=[UIColor clearColor];
        
        UIToolbar *toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, UUIAV_MAIN_W, UUIAV_Btn_H+2*UUIAV_Edge_Vert)];
        inputView = [[UITextView alloc] initWithFrame:CGRectMake(UUIAV_Edge_Hori, UUIAV_Edge_Vert, UUIAV_MAIN_W-UUIAV_Btn_W-4*UUIAV_Edge_Hori, UUIAV_Btn_H)];
        inputView.returnKeyType = UIReturnKeyDone;
        inputView.enablesReturnKeyAutomatically = YES;
        inputView.delegate = self;
        inputView.font = [UIFont systemFontOfSize:14];
        inputView.layer.cornerRadius = 5;
        inputView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        inputView.layer.borderWidth = 0.5;
        [toolbar addSubview:inputView];
        
        assistView = [UITextField new];
        assistView.returnKeyType = UIReturnKeyDone;
        assistView.enablesReturnKeyAutomatically = YES;
        [btnBack addSubview:assistView];
        assistView.inputAccessoryView = toolbar;
        
        BtnSave = [UIButton buttonWithType:UIButtonTypeCustom];
        BtnSave.frame = CGRectMake(UUIAV_MAIN_W-UUIAV_Btn_W-2*UUIAV_Edge_Hori, UUIAV_Edge_Vert, UUIAV_Btn_W, UUIAV_Btn_H);
        BtnSave.backgroundColor = [UIColor clearColor];
        [BtnSave setTitle:@"确定" forState:UIControlStateNormal];
        [BtnSave setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [BtnSave setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
        [BtnSave addTarget:self action:@selector(saveContent) forControlEvents:UIControlEventTouchUpInside];
        [toolbar addSubview:BtnSave];
    
        [viewController.view addSubview:sharedView];
        
        
    });
}

- (void)showBlock:(UUInputAccessoryBlock)block WithController:(UIViewController *)viewController
{
    [self sharedViewWithController:viewController];
    [self show:block keyboardType:UIKeyboardTypeDefault content:@"" withController:viewController];
    
//     show:block
//                               keyboardType:UIKeyboardTypeDefault
//                                    content:@"" withController:viewController];
}

//+ (void)showKeyboardType:(UIKeyboardType)type Block:(UUInputAccessoryBlock)block
//{
//    [[UUInputAccessoryView sharedView] show:block
//                               keyboardType:type
//                                    content:@""];
//}
//
//+ (void)showKeyboardType:(UIKeyboardType)type content:(NSString *)content Block:(UUInputAccessoryBlock)block
//{
//    [[UUInputAccessoryView sharedView] show:block
//                               keyboardType:type
//                                    content:content];
//}

- (void)show:(UUInputAccessoryBlock)block keyboardType:(UIKeyboardType)type content:(NSString *)content withController:(UIViewController*)viewController
{
//    UIWindow *window=[UIApplication sharedApplication].keyWindow;
//    [window addSubview:btnBack];
    [viewController.view addSubview:btnBack];

    inputBlock = block;
    inputView.text = content;
    assistView.text = content;
    inputView.keyboardType = type;
    assistView.keyboardType = type;
    [assistView becomeFirstResponder];
    [inputView becomeFirstResponder];
    shouldDismiss = NO;
    BtnSave.enabled = content.length>0;
    
//    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardDidShowNotification
//                                                      object:nil
//                                                       queue:nil
//                                                  usingBlock:^(NSNotification * _Nonnull note) {
//                                                      if (!shouldDismiss) {
//                                                          [inputView becomeFirstResponder];
//                                                      }
//                                                  }];
}

- (void)saveContent
{
    [inputView resignFirstResponder];
    !inputBlock ?: inputBlock(inputView.text);
    [self dismiss];
}

- (void)dismiss
{
    shouldDismiss = YES;
    [inputView resignFirstResponder];
    [btnBack removeFromSuperview];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// textView's delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [self saveContent];
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    BtnSave.enabled = textView.text.length>0;
}


@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com