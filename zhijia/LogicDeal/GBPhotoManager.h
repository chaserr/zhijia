//
//  GBPhotoManager.h
//  zhijia
//
//  Created by 张浩 on 16/5/9.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

typedef void (^YYUploadResponse)(NSInteger result);
@protocol GBUploadPhotoDelegate <NSObject>

@optional
//- (void)uploadPhoto:(YYImage*)image resultDic:(NSDictionary *)dic;
-(void)selectedImage:(NSDictionary*)image;
- (void) intoSelectView;

@end

#import <Foundation/Foundation.h>
#import "QBImagePickerController.h"

@interface GBPhotoManager : NSObject<UIAlertViewDelegate,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,QBImagePickerControllerDelegate>
{
    UIViewController * _parentViewController;
    
}

@property (nonatomic,assign)id<GBUploadPhotoDelegate> delegate;
@property (nonatomic,assign)BOOL isSelectMutibleImage;
@property (nonatomic,assign)EGBUploadPhotoType uploadPhotoType;
@property (nonatomic,assign)BOOL isFromDynamic;

+ (GBPhotoManager*)getInstance;

- (void)uploadPhoto:(EGBUploadPhotoType)type;
- (void)takePhotoWithCamera;
-(void)uploadImgToServer:(UIImage*)image;
- (void)selectPhotoWithLocalAlblum;
-(void) setParentViewController;
- (void) uploadImgsToServer:(NSArray *)imageArray;


@end
