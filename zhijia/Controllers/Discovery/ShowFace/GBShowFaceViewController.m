//
//  GBShowFaceVC.m
//  zhijia
//
//  Created by 张浩 on 16/5/11.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//


typedef enum : NSUInteger {
    TakePhoto,
    RecordVedio,
    TakeLivePhoto,
    SelectLocalPhoto,
} MediumType;

#import "GBShowFaceViewController.h"
#import "GBMediumViewController.h"
#import "SCCaptureCameraController.h"

#import <MobileCoreServices/MobileCoreServices.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

#import "zhijia-swift.h"

@interface GBShowFaceViewController ()<IBActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>{
    
    UIView* _navigationBarView;
    UILabel* _navBarTitleLabel;
    
}

@property (weak, nonatomic) IBOutlet PHLivePhotoView *bgLivePhotoView;

@property (weak, nonatomic) IBOutlet UIImageView *showSmallImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *locationLabel;

@property (nonatomic, strong) UIView *photoView;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, strong) UIImageView *progressImgView;

@property (nonatomic, strong) IBActionSheet *sheetAction;


@property (nonatomic, strong) UIVisualEffectView *visualEfView;
@property (nonatomic, strong) UIButton           *backLeftBtn;
@property (nonatomic, strong) UIButton           *cameraBtn;

/** MediumType */
@property (nonatomic, assign) MediumType mediumType;


/** 自定义半透明模糊导航条 */
@property (assign,nonatomic) int isVideo;
@property (strong,nonatomic)UIImagePickerController * imagePicker;
/** 播放器，用于录制完视频后播放视频 */
@property (strong ,nonatomic) AVPlayer *player;
/** LivePhoto说明 */
@property (nonatomic, strong) STAlertView *livePhotoAlert;

/** 小视频播放层 */
@property (nonatomic, strong) AVPlayerLayer *avPlayerLayer;

@end

@implementation GBShowFaceViewController

- (void)loadView{
    
    NSArray *views = [[NSBundle mainBundle] loadNibNamed:@"GBShowFaceViewController" owner:self options:nil];
    UIView *view = [views lastObject];
    self.view = view;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavbarView];
    [self setupNavbarButtons];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.960 alpha:1.000];

}



- (void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    
    self.navigationController.navigationBar.hidden = NO;
    
}

#pragma mark -- IBActionSheet/UIActionSheet Delegate Method

- (void)actionSheet:(IBActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    DLog(@"Button at index: %ld clicked\nIt's title is '%@'", (long)buttonIndex, [actionSheet buttonTitleAtIndex:buttonIndex]);
    NSString *str = [actionSheet buttonTitleAtIndex:buttonIndex];
    if ([str isEqualToString:@"拍照"])
    {
        self.mediumType = TakePhoto;
        [self takePhotoWithCamera];
    }
    else if([str isEqualToString:@"小视频"])
    {
        self.mediumType = RecordVedio;

        [self recordVedioWithCamera];
        
    }else if ([str isEqualToString:@"LivePhoto"]){
       
        self.mediumType = TakeLivePhoto;

//        if ([UIDevice isHigherIOS9]) {
            self.livePhotoAlert = [[STAlertView alloc] initWithTitle:@"提示" message:@"本功能只是将录制的视频做成LivePhoto,支持低版本手机，但是不支持分享，只有在支3DTouch功能的手机才能互相分享" cancelButtonTitle:@"使用" otherButtonTitles:@"取消" cancelButtonBlock:^{
                
                [self recordLivwePhoto];
                
            } otherButtonBlock:nil];
//        }else{
        
//            self.livePhotoAlert = [[STAlertView alloc] initWithTitle:@"提示" message:@"本功能只是将录制的视频做成LivePhoto,支持低版本手机，但是不支持分享，只有在支3DTouch功能的手机才能互相分享" cancelButtonTitle:@"使用" otherButtonTitles:@"取消" cancelButtonBlock:^{
//                
//                [self recordLivwePhoto];
//                
//            } otherButtonBlock:nil];
//        }

    }else if ([str isEqualToString:@"从手机相册选择"]){
    
        self.mediumType = SelectLocalPhoto;
        [self selectPhotoWithLocalAlblum];
    }
}

#pragma mark - UIImagePickerController代理方法
//完成
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    NSString *mediaType=[info objectForKey:UIImagePickerControllerMediaType];
    if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){//如果是录制视频
        NSURL *url=[info objectForKey:UIImagePickerControllerMediaURL];//视频路径
        NSString *urlStr=[url path];
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(urlStr)) {
            //保存视频到相簿，注意也可以使用ALAssetsLibrary来保存
            UISaveVideoAtPathToSavedPhotosAlbum(urlStr, self, @selector(video:didFinishSavingWithError:contextInfo:), nil);//保存视频到相簿
        }
    }else {
        
        UIImage * image = [info objectForKey:UIImagePickerControllerEditedImage];
        
        if (image == nil)
        {
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        self.bgLivePhotoView.livePhoto = nil;
        [self.avPlayerLayer removeFromSuperlayer];
        self.bgImageView.image = nil;
        self.bgImageView.hidden = NO;
        self.bgImageView.image = image;
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)showAlertWithMessage:(NSString *)message{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

//视频保存后的回调
- (void)video:(NSString *)videoPath didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        NSLog(@"保存视频过程中发生错误，错误信息:%@",error.localizedDescription);
    }else{
        
        switch (self.mediumType) {
            case RecordVedio:
            {
                self.bgImageView.image = nil;
                self.bgImageView.hidden = NO;
                self.bgLivePhotoView.livePhoto = nil;
                NSURL *url=[NSURL fileURLWithPath:videoPath];
                _player=[AVPlayer playerWithURL:url];
                self.avPlayerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
                _avPlayerLayer.frame=self.bgImageView.frame;
                [self.bgImageView.layer addSublayer:_avPlayerLayer];
                if (videoPath) {
                    [_player play];
                }
            }
                break;
            case TakeLivePhoto:
            {
                self.bgImageView.image = nil;
                self.bgImageView.hidden = YES;
                [self.avPlayerLayer removeFromSuperlayer];
                [self loadVideoWithVideoURL:[NSURL fileURLWithPath:videoPath]];
            }
                break;
                
            default:
                break;
        }

    }
}


#pragma mark -- Action



- (void)selectPhotoWithLocalAlblum
{
    UIImagePickerController * imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    //    imagePickerController.allowsEditing = YES;
    
    [self presentViewController:imagePickerController animated:YES completion:^{
        
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    }];
}

- (void)loadVideoWithVideoURL:(NSURL *)vedioUrl{

    _bgLivePhotoView.livePhoto = nil;
    AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:vedioUrl options:nil];
    AVAssetImageGenerator *generator = [[AVAssetImageGenerator alloc] initWithAsset:asset];
    generator.appliesPreferredTrackTransform = YES;
    NSValue *time = [NSValue valueWithCMTime:(CMTimeMakeWithSeconds(CMTimeGetSeconds(asset.duration)/2, asset.duration.timescale))];
    [generator generateCGImagesAsynchronouslyForTimes:@[time] completionHandler:^(CMTime requestedTime, CGImageRef  _Nullable image, CMTime actualTime, AVAssetImageGeneratorResult result, NSError * _Nullable error) {
        UIImage *images = [UIImage imageWithCGImage:image];
        NSData *imageData = UIImagePNGRepresentation(images);
        if (images && imageData) {
           
            NSFileManager *fileManage = [NSFileManager defaultManager];
            NSArray *urlArray = [fileManage URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask];
            NSURL *imageUrl = [[urlArray firstObject] URLByAppendingPathComponent:@"image.jpg"];
            [imageData writeToURL:imageUrl atomically:YES];
            NSString *imageUrlPath = imageUrl.path;
            NSString *movUrlPath = vedioUrl.path;
            NSString *outPath = [self vedioFilePath];
            NSError *error;
            NSString *assetIdentifer = [[NSUUID alloc] init].UUIDString;
            BOOL createSuccess = [[NSFileManager defaultManager] createDirectoryAtPath:outPath withIntermediateDirectories:YES attributes:nil error:&error];
            if (createSuccess) {
                [[NSFileManager defaultManager] removeItemAtPath:[outPath stringByAppendingString:@"/IMG.JPG"]  error:&error];
                [[NSFileManager defaultManager] removeItemAtPath:[outPath stringByAppendingString:@"/IMG.MOV"] error:&error];
            }
            
            GBJPEG *jpegOb = [[GBJPEG alloc] initWithPath:imageUrlPath];
            GBQuickTimeMov *quickTimeMovOb = [[GBQuickTimeMov alloc] initWithPath:movUrlPath];
            [jpegOb write:[outPath stringByAppendingString:@"/IMG.JPG"] assetIdentifier:assetIdentifer];
            [quickTimeMovOb write:[outPath stringByAppendingString:@"/IMG.MOV"] assetIdentifier:assetIdentifer];
            [PHLivePhoto requestLivePhotoWithResourceFileURLs:@[[NSURL fileURLWithPath:[[self vedioFilePath] stringByAppendingString:@"/IMG.MOV"]], [NSURL fileURLWithPath:[[self vedioFilePath] stringByAppendingString:@"/IMG.JPG"]]] placeholderImage:nil targetSize:self.bgLivePhotoView.size contentMode:(PHImageContentModeDefault) resultHandler:^(PHLivePhoto * _Nullable livePhoto, NSDictionary * _Nonnull info) {
                self.bgLivePhotoView.livePhoto = livePhoto;
                [self expertLivePhoto];
                
            }];
            
            
        }
    }];
    
}

// 制作livePhoto
- (void)recordLivwePhoto{

    [self recordVedioWithCamera];

}

// 拍照
- (void)takePhotoWithCamera{

    SCCaptureCameraController *con = [[SCCaptureCameraController alloc] init];
    @WeakObj(self);
    con.dismissBlock = ^(UIImage *takePhotoImage){
        
        @StrongObj(self);
        if (takePhotoImage) {
            self.bgLivePhotoView.livePhoto = nil;
            [self.avPlayerLayer removeFromSuperlayer];
            self.bgImageView.image = nil;
            self.bgImageView.hidden = NO;
            self.bgImageView.image = takePhotoImage;
        }
    };
    
    [self presentViewController:con animated:YES completion:nil];

}

// 小视频
- (void)recordVedioWithCamera{

    [self presentViewController:self.imagePicker animated:YES completion:nil];

}

- (void)backBtnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
    
}
                                                             
// 文件路径
- (NSString *)vedioFilePath
{
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    return [cachesPath stringByAppendingString:@"/"];
}

// 导出livePhoto
- (void)expertLivePhoto{

    PHPhotoLibrary *library = [PHPhotoLibrary sharedPhotoLibrary];
    [library performChanges:^{
        PHAssetCreationRequest *request = [PHAssetCreationRequest creationRequestForAsset];
        [request addResourceWithType:PHAssetResourceTypePairedVideo fileURL:[NSURL fileURLWithPath:[[self vedioFilePath] stringByAppendingString:@"/IMG.MOV"]] options:nil];
        [request addResourceWithType:PHAssetResourceTypePhoto fileURL:[NSURL fileURLWithPath:[[self vedioFilePath] stringByAppendingString:@"/IMG.JPG"]] options:nil];
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        // did this work?
        if (!success) {
            [self alert:[NSString stringWithFormat:@"Error was %@, %@", error.localizedFailureReason, error.localizedDescription]];
            NSLog(@"That didn't work...");
            return;
        }
        
        NSLog(@"The asset was apparently saved without problems. Check your Photo Library!");
    }];
    
}

- (void)setupNavbarView
{
    CGRect naviBarRect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    
    _navigationBarView= [[UIView alloc] initWithFrame:naviBarRect];
    _navigationBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_navigationBarView];
    
    self.visualEfView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight]];
    _visualEfView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _navigationBarView.height);
    _visualEfView.alpha = 0.6;
    [_navigationBarView addSubview:_visualEfView];
    //    _visualEfView.hidden = YES;
    
    CGRect navBarTitleRect = [UtilFunc bottomCenterRect:naviBarRect width:250 height:44 offset:0];
    navBarTitleRect = CGRectInset(navBarTitleRect, 0, 8);
    _navBarTitleLabel = [[UILabel alloc] initWithFrame:navBarTitleRect];
    _navBarTitleLabel.textColor = [UIColor whiteColor];
    _navBarTitleLabel.text = @"露脸";
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
    
    // 更多按钮(举报、拉黑)
    _cameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    rect = [UtilFunc bottomRect:rect height:44 offset:0];
    rect = CGRectInset(rect, 12, 4);

//    CGRect moreBtnRects = CGRectMake( (SCREEN_WIDTH - 38) - 10, 20 , 38, 44);
//    _cameraBtn.frame = moreBtnRects;
//    [_cameraBtn setImage:[UIImage imageNamed:@"discover_shoot_camera"] forState:UIControlStateNormal];
//    [_cameraBtn addTarget:self action:@selector(moreBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:_cameraBtn];
    
}

- (void)moreBtnClicked:(id)sender{
    
    DLog(@"调用相机");
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        self.sheetAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@[@"小视频", @"LivePhoto", @"从手机相册选择"]];
        
    }
    else
    {
        self.sheetAction = [[IBActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"从手机相册选择" otherButtonTitles:nil];
        
    }
    
    [self.sheetAction setFont:GBSystemFont(15)];
    [self.sheetAction setTitleTextColor:[UIColor colorWithWhite:0.574 alpha:1.000]];
    [self.sheetAction setButtonTextColor:[UIColor colorWithWhite:0.574 alpha:1.000]];
    [self.sheetAction showInView:APP_DELEGATE.window];
    
    // 仿系统相机界面
    //    GBMediumViewController *mediumVC = [[GBMediumViewController alloc] init];
    //    @WeakObj(self);
    //    mediumVC.mediumDataBlock = ^(NSData *data, NSURL *vedioUrl){
    //        @StrongObj(self);
    //        if (data) {
    //            self.bgImageView.hidden = NO;
    //            self.bgImageView.image = [UIImage imageWithData:data];
    //        }
    //        if (vedioUrl) {
    //
    //            _player=[AVPlayer playerWithURL:vedioUrl];
    //            AVPlayerLayer *playerLayer=[AVPlayerLayer playerLayerWithPlayer:_player];
    //            playerLayer.frame=self.bgImageView.frame;
    //            self.bgImageView.hidden = NO;
    //            [self.bgImageView.layer addSublayer:playerLayer];
    //            [_player play];
    //        }
    //    };
    //    [self presentViewController:mediumVC animated:YES completion:nil];
    
    
}

#pragma mark - 私有方法
-(UIImagePickerController *)imagePicker{
    _isVideo= YES;
    
    if (!_imagePicker) {
        _imagePicker=[[UIImagePickerController alloc]init];
        _imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;//设置image picker的来源，这里设置为摄像头
        _imagePicker.cameraDevice=UIImagePickerControllerCameraDeviceRear;//设置使用哪个摄像头，这里设置为后置摄像头
        
        if (_isVideo) {
            _imagePicker.mediaTypes=@[(NSString *)kUTTypeMovie];
            _imagePicker.videoQuality=UIImagePickerControllerQualityTypeIFrame1280x720;
            _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModeVideo;//设置摄像头模式（拍照，录制视频）
            
        }else{
            _imagePicker.cameraCaptureMode=UIImagePickerControllerCameraCaptureModePhoto;
        }
        _imagePicker.allowsEditing=YES;//允许编辑
        _imagePicker.delegate=self;//设置代理，检测操作
    }
    return _imagePicker;
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
