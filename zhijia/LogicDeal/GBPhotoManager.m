//
//  GBPhotoManager.m
//  zhijia
//
//  Created by 张浩 on 16/5/9.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBPhotoManager.h"
#import "IBActionSheet.h"

static GBPhotoManager *_sharedPhotoManager = nil;

@interface GBPhotoManager ()<IBActionSheetDelegate>
@property IBActionSheet *sheetAction;

@end
@implementation GBPhotoManager

+ (GBPhotoManager*)getInstance
{
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        
        _sharedPhotoManager = [[GBPhotoManager alloc] init];
    });
    return _sharedPhotoManager;
}

// 上传头像按钮
- (void)uploadPhoto:(EGBUploadPhotoType)type
{
    _uploadPhotoType = type;
    UIViewController *parentVC = [self getCurrentRootViewController];
    _parentViewController = parentVC;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        self.sheetAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@[@"从手机相册选择"]];

    }
    else
    {
        self.sheetAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从手机相册选择" otherButtonTitles:@[@"从手机相册选择", @"heh "]];

    }
    
    [self.sheetAction setFont:GBSystemFont(15)];
    [self.sheetAction setTitleTextColor:[UIColor colorWithWhite:0.574 alpha:1.000]];
    [self.sheetAction setButtonTextColor:[UIColor colorWithWhite:0.574 alpha:1.000]];
    [self.sheetAction showInView:APP_DELEGATE.window];
}

-(void) setParentViewController
{
    UIViewController *parentVC = [[self class] getCurrentRootViewController];
    _parentViewController = parentVC;
    
}

- (void)selectPhotoWithLocalAlblum
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    //    imagePickerController.allowsEditing = YES;
    
    [_parentViewController presentViewController:imagePickerController animated:YES completion:^{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }];
    
}

- (void)selectMutiblePhotoLocalAlblum
{
    if ([self.delegate respondsToSelector:@selector(intoSelectView)]) {
        [self.delegate intoSelectView];
    }
}

- (void)setIsSelectMutibleImage:(BOOL)isSelectMutibleImage
{
    _isSelectMutibleImage = isSelectMutibleImage;
}
- (void)setIsFromDynamic:(BOOL)isFromDynamic
{
    _isFromDynamic = isFromDynamic;
}

- (void)takePhotoWithCamera
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePickerController.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        
        NSArray* mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        imagePickerController.mediaTypes = @[[mediaTypes objectAtIndex:0]];
        
        imagePickerController.delegate = self;
        //    imagePickerController.allowsEditing = YES;
        
        [_parentViewController presentViewController:imagePickerController animated:YES completion:^{
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        }];
    }else{
        [GBHUDVIEW showTips:@"您的设备不支持照相"];
    }
}

- (void)imagePickerController:(id)picker didFinishPickingMediaWithInfo:(id)info
{
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    if (image == nil)
    {
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    //    if (!_isSelectMutibleImage) {
//    [self uploadImgToServer:image];
    //    }
    
    if([self.delegate respondsToSelector:@selector(selectedImage:)])
    {
        [self.delegate performSelector:@selector(selectedImage:) withObject:@{@"image":image}];
    }
    
}

//-(void)uploadImgToServer:(UIImage*)image
//{
//    // isMain 上传类型:1->头像, 2->普通图片
//    [YYHUDVIEW startAnimatingWithTitle:@"正在上传"];
//    [YY_CORE.contactsService uploadImg:_uploadPhotoType image:image isDynamicImage:_isFromDynamic response:^(NSInteger result, NSDictionary *dict, YYError *error) {
//        [YYHUDVIEW stopAnimating];
//        if(result == EYYResponseResultSucceed)
//        {
//            [YYHUDVIEW showTips:@"上传成功！" autoHideTime:2.0];
//            NSDictionary* imageDict = [dict objectForKey:@"image"];
//            YYImage* imageData = [[YYContactManager getInstance] parseImageObject:imageDict];
//            if (!_isFromDynamic) {
//                if(imageData)
//                {
//                    //上传头像
//                    YYContactData *me = [YYContactData contactByUid:APP_USER.userID];
//                    if (_uploadPhotoType == 1) {
//                        //                        me.portraitImage = imageData;
//                        APP_USER.photoPath = imageData.imageUrl;
//                        [APP_USER save];
//                        [APP_USER saveProtraitImage:image withPath:APP_USER.photoPath];
//                    }
//                    [me saveContact];
//                }
//                
//            }
//            //上传完成调用回调方法
//            if ([self.delegate respondsToSelector:@selector(uploadPhoto:resultDic:)]) {
//                [self.delegate performSelector:@selector(uploadPhoto:resultDic:) withObject:imageData withObject:imageDict];
//            }
//            
//        }
//        else if (result == EYYResponseResultFailed)
//        {
//            if (error.errorMsg != nil){
//                [YYHUDVIEW showTips:[NSString stringWithFormat:@"%@", error.errorMsg] autoHideTime:1];
//            }else{
//                [YYHUDVIEW showTips:@"上传失败"];
//            }
//        }
//    }];
//}

//- (void) uploadImgsToServer:(NSArray *)imageArray
//{
//    [GBHUDVIEW startAnimating];
//    [YY_CORE.contactsService uploadImgArray:imageArray response:^(NSInteger result, NSDictionary *dict, YYError *error) {
//        
//        
//    }];
//
//}

- (void)imagePickerControllerDidCancel:(UIViewController *)picker
{
    //    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - IBActionSheet/UIActionSheet Delegate Method

- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    DLog(@"Button at index: %ld clicked\nIt's title is '%@'", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    NSString *str = [actionSheet buttonTitleAtIndex:buttonIndex];
        if ([str isEqualToString:@"拍照"])
        {
            [self takePhotoWithCamera];
        }
        else if([str isEqualToString:@"从手机相册选择"])
        {
            if (_isSelectMutibleImage) {
                [self selectMutiblePhotoLocalAlblum];
            }else{
                [self selectPhotoWithLocalAlblum];
                
            }
        }
}

-(UIViewController *)getCurrentRootViewController {
    
    UIViewController *result;
    // Try to find the root view controller programmically
    // Find the top window (that is not an alert view or other window)
    
    UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
    if (topWindow.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(topWindow in windows)
        {
            if (topWindow.windowLevel == UIWindowLevelNormal)
            {
                break;
            }
        }
    }
    
    UIView *rootView = [[topWindow subviews] objectAtIndex:0];
    id nextResponder = [rootView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
    {
        result = nextResponder;
    }
    else if ([topWindow respondsToSelector:@selector(rootViewController)] && topWindow.rootViewController != nil)
    {
        result = topWindow.rootViewController;
    }
    else
        NSAssert(NO, @"ShareKit: Could not find a root view controller.  You can assign one manually by calling [[SHK currentHelper] setRootViewController:YOURROOTVIEWCONTROLLER].");
    return result;
}


@end
