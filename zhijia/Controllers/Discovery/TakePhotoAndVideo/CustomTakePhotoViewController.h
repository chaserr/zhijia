//
//  CustomTakePhotoViewController.h
//  PhotoDemo
//
//  Created by huangwenchen on 15/3/31.
//  Copyright (c) 2015年 huangwenchen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^RecordVedioPathBlock)(NSURL *vedioPath);

@interface CustomTakePhotoViewController : UIViewController

@property (nonatomic, copy) RecordVedioPathBlock recordVedioBlock;

@end
