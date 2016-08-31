//
//  GBAddAnswerVC.m
//  zhijia
//
//  Created by 童星 on 16/6/8.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//
#define ItemWH (([UIScreen mainScreen].bounds.size.width-20)/4)
#define PHOTO_IMAGE_CELL_IDENTIFIER @"photoCellectionCell"
#define SELECT_IMAGE_CELL_IDENTIFIER @"uploadBtnCell"

#import "GBAddAnswerVC.h"
#import "QCheckBox.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "GBUploadPhotoCollectionCell.h"

@interface GBAddAnswerVC ()<UITextViewDelegate,GBUploadPhotoDelegate,QBImagePickerControllerDelegate,GBUploadPhotoDelegate,UICollectionViewDelegate,UICollectionViewDataSource,uploadPhotoDelegate,UICollectionViewDelegateFlowLayout, MJPhotoBrowserDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *placeHolder;
@property (nonatomic, strong) QCheckBox *checkBox;

// 上传图片
@property(nonatomic, strong) UICollectionView * imageCollectionView;

@property(nonatomic, strong) NSMutableArray * imageArray;

@end

@implementation GBAddAnswerVC

//- (void)loadView{
//
//    [super loadView];
//    self.view = [[[NSBundle mainBundle] loadNibNamed:@"GBAddAnswerVC" owner:self options:nil] lastObject];
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    [self customlizeNavigationBarBackBtn];
    self.navigationTitleLabel.text = @"添加回答";
    [self createNavigateBarButton];
    self.textView.delegate = self;
    
    [self createInputAccessoryView];
    
}

#pragma mark -- life circle

#pragma mark -- UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView{

    if (textView.text.length) {
        self.placeHolder.hidden = YES;
    }else{
    
        self.placeHolder.hidden = NO;

    }
}

#pragma mark -- selectUpaloadImage
- (void)selectImageList
{
    [[GBPhotoManager getInstance] setIsSelectMutibleImage:YES];
    [[GBPhotoManager getInstance] uploadPhoto:EGBUploadPhotoType_Default];
    [[GBPhotoManager getInstance] setIsFromDynamic:YES];
    [[GBPhotoManager getInstance] setDelegate:self];
}


#pragma mark -- YYPhotoManager delegate

- (void)intoSelectView
{
    if ([UIDevice isHigherIOS8]) {
        QBImagePickerController *imagePickerController = [QBImagePickerController new];
        imagePickerController.delegate = self;
        imagePickerController.mediaType = QBImagePickerMediaTypeAny;
        imagePickerController.allowsMultipleSelection = YES;
        imagePickerController.showsNumberOfSelectedAssets = YES;
        imagePickerController.maximumNumberOfSelection = 6 - _imageArray.count;
        imagePickerController.minimumNumberOfSelection = 1;
        [self presentViewController:imagePickerController animated:YES completion:^{
            
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
        }];
        
    }
    //    else {
    //        YYQBImagePickerController *imagePickerController = [YYQBImagePickerController new];
    //        imagePickerController.delegate = self;
    //        imagePickerController.allowsMultipleSelection = YES;
    //        imagePickerController.maximumNumberOfSelection = 6 - _imageArray.count;
    //        imagePickerController.minimumNumberOfSelection = 1;
    //        imagePickerController.filterType = QBImagePickerControllerFilterTypePhotos;
    //        imagePickerController.allowsMultipleSelection = YES;
    //        YYNavViewController * navieControrller = [[YYNavViewController alloc] initWithRootViewController:imagePickerController];
    //        [self presentViewController:navieControrller animated:YES completion:^{
    //
    //            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
    //        }];
    //    }
}

#pragma mark -- PrickController  delegate
- (void)qb_imagePickerControllerDidCancel:(GBViewController *)imagePickerController
{
    
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
    
}
-(void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets
{
    [imagePickerController dismissViewControllerAnimated:YES completion:^{
        
    }];
    NSMutableArray * imageArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    PHCachingImageManager * imageManager = [PHCachingImageManager new];
    PHImageRequestOptions * requestOptions;
    if (!requestOptions) {
        requestOptions = [[PHImageRequestOptions alloc] init];
        requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        requestOptions.version = PHImageRequestOptionsVersionCurrent;
        requestOptions.synchronous = YES;
    }
    
    for (PHAsset * asset in assets) {
        CGSize itemSize = CGSizeMake([UIDevice screenWidth] *[UIScreen mainScreen].scale, [UIDevice screenHeight]*[UIScreen mainScreen].scale)  ;
        
        [imageManager requestImageForAsset:asset
                                targetSize:itemSize
                               contentMode:PHImageContentModeAspectFill
                                   options:requestOptions
                             resultHandler:^(UIImage *result, NSDictionary *info) {
                                 [imageArray addObject:result];
                             }];
        
    }
    [self.imageArray addObjectsFromArray:imageArray];
    [self updateUI];
    
}

#pragma mark YYUploadPhotoCollectionCell delegate
-(void)deleteImage:(NSInteger)index
{
    [_imageArray removeObjectAtIndex:index];
    if (_imageArray.count == 0) {
        [_imageCollectionView removeFromSuperview];
    }else{
    
        [self updateUI];

    }
}

#pragma mark -- UICollectionViewDelegate/DataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_imageArray.count < 6) {
        return _imageArray.count + 1;
    }else{
        return _imageArray.count;
    }
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (UICollectionViewCell *) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < _imageArray.count) {
        GBUploadPhotoCollectionCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:PHOTO_IMAGE_CELL_IDENTIFIER forIndexPath:indexPath] ;
        
        [collectionCell sizeToFit];
        [collectionCell setUploadImage:[_imageArray objectAtIndex:indexPath.row] withIndex:indexPath.row];
        collectionCell.delegate = self;
        return collectionCell;
    }
    else{
        UICollectionViewCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:SELECT_IMAGE_CELL_IDENTIFIER forIndexPath:indexPath] ;
        [collectionCell.contentView addSubview:[self creatSelectImageView]];
        return collectionCell;
    }
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(ItemWH, ItemWH);
}

- (CGFloat) collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
    
}

- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    if(indexPath.row == _imageArray.count){
        [self selectImageList];
    }else{
        
        NSMutableArray *photoArray = [[NSMutableArray alloc] init];
        for (int i = 0;i< self.imageArray.count; i ++) {
            UIImage *image = self.imageArray[i];
            
            MJPhoto *photo = [MJPhoto new];
            photo.image = image;
            GBUploadPhotoCollectionCell *cell = (GBUploadPhotoCollectionCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            photo.srcImageView = cell.uploadImageView;
            [photoArray addObject:photo];
        }
        
        MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
        browser.photoBrowserdelegate = self;
        browser.currentPhotoIndex = indexPath.row;
        browser.photos = photoArray;
        [browser show];
        
    }
    
}

#pragma mark -- Action

- (void)createInputAccessoryView{

    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(-1, 0, SCREEN_WIDTH + 2, 50)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.borderWidth = 0.5;
    view.layer.borderColor = [UIColor colorWithWhite:0.722 alpha:1.000].CGColor;
    self.checkBox = [[QCheckBox alloc] initWithDelegate:self];;
    _checkBox.frame = CGRectMake(15, 0, 120, 50);
    [_checkBox setTitle:@"匿名回答" forState:(UIControlStateNormal)];
    [_checkBox setImage:[UIImage imageNamed:@"compose_choose_check_default"] forState:(UIControlStateNormal)];
    [_checkBox setImage:[UIImage imageNamed:@"compose_choose_check"] forState:(UIControlStateSelected)];
    [_checkBox setTitleColor:[UIColor colorWithWhite:0.329 alpha:1.000] forState:(UIControlStateNormal)];
    [_checkBox setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
    [_checkBox.titleLabel setFont:GBFont(17)];
    _checkBox.adjustsImageWhenHighlighted = NO;
    [view addSubview:_checkBox];
    
    [_checkBox bk_addEventHandler:^(QCheckBox *sender) {
        
        sender.selected = !sender.selected;
        
    } forControlEvents:(UIControlEventTouchUpInside)];
    
    
    UIButton *shrinkKeyBoardBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shrinkKeyBoardBtn.frame = CGRectMake(CGRectGetWidth(view.frame) - 30 - 10, 0, 30, CGRectGetHeight(view.frame));
    [shrinkKeyBoardBtn setImage:[UIImage imageNamed:@"shrink_keyBoard"] forState:(UIControlStateNormal)];
    [view addSubview:shrinkKeyBoardBtn];
    [shrinkKeyBoardBtn bk_addEventHandler:^(id sender) {
        [self.textView resignFirstResponder];
    } forControlEvents:(UIControlEventTouchUpInside)];
    
    UIButton *addPictureBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    addPictureBtn.frame = CGRectMake(CGRectGetMinX(shrinkKeyBoardBtn.frame) - 30 - 10, 0, 30, CGRectGetHeight(view.frame));
    [addPictureBtn setImage:[UIImage imageNamed:@"selectPicture"] forState:(UIControlStateNormal)];
    [view addSubview:addPictureBtn];
    [addPictureBtn bk_addEventHandler:^(id sender) {
        [self.textView resignFirstResponder];
        [self selectImageList];
    } forControlEvents:(UIControlEventTouchUpInside)];
    
    self.textView.inputAccessoryView = view;

    
}

- (void)createUploadPhotoView:(id)parentView{
    
    //发布动态图片
    [parentView addSubview:self.imageCollectionView];

}

- (UICollectionView *)imageCollectionView{

    if (!_imageCollectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(ItemWH, ItemWH)];
        CGFloat hight = (_imageArray.count/4 +1) *ItemWH;
        _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_textView.frame) + 10, SCREEN_WIDTH-20, hight) collectionViewLayout:flowLayout];
        _imageCollectionView.delegate = self;
        _imageCollectionView.dataSource = self;
        _imageCollectionView.backgroundColor = [UIColor clearColor];
        [_imageCollectionView registerClass:[GBUploadPhotoCollectionCell class] forCellWithReuseIdentifier:PHOTO_IMAGE_CELL_IDENTIFIER];
        [_imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SELECT_IMAGE_CELL_IDENTIFIER];
    }
    return _imageCollectionView;
}

- (UIView *) creatSelectImageView
{
    UIImage * image = [UIImage imageNamed:@"Ellipse-5-copy"];
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0 ,ItemWH, ItemWH)];
    imageView.contentMode = UIViewContentModeCenter;
    imageView.backgroundColor = [UIColor colorWithWhite:0.951 alpha:0.650];
    imageView.image = image;
    return imageView;
}
- (void)createNavigateBarButton{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发布" forState:(UIControlStateNormal)];
    [button.titleLabel setFont:GBSystemFont(15)];
    [button setTitleColor:[UIColor colorWithRed:0.171 green:0.741 blue:1.000 alpha:1.000] forState:(UIControlStateNormal)];
    //    button.adjustsImageWhenDisabled = NO;
    button.frame = CGRectMake(0, 0, 50, 30);
    [button addTarget:self action:@selector(releaseAnswer:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self setRightBarButtonItem:rightItem];
}

- (void)releaseAnswer:(id)sender{

    DLog(@"发布回答");
    
}

- (void) updateUI
{
    [self layoutSubview];
    
    [_imageCollectionView reloadData];
    
}

- (void) layoutSubview
{
    if (_imageCollectionView == nil && _imageArray.count != 0) {
        [self createUploadPhotoView:self.view];

    }

    CGRect collectionRect = _imageCollectionView.frame;
    CGFloat newCollectionHight;
    if (_imageArray.count < 6) {
        newCollectionHight =((_imageArray.count) / 4  + 1) * ItemWH;
    }else{
        newCollectionHight = _imageArray.count/4*ItemWH;
        
    }
    collectionRect.size.height = newCollectionHight;
    
    _imageCollectionView.frame = collectionRect;
}
// 懒加载
- (NSMutableArray *)imageArray{
    
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
}

- (void)backAction{

    [self.navigationController popViewControllerAnimated:YES];
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
