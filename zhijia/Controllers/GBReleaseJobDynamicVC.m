//
//  GBReleaseJobDynamicVC.m
//  zhijia
//
//  Created by 张浩 on 16/5/7.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#define ItemWH (([UIScreen mainScreen].bounds.size.width-20)/4)
#define PHOTO_IMAGE_CELL_IDENTIFIER @"photoCellectionCell"
#define SELECT_IMAGE_CELL_IDENTIFIER @"uploadBtnCell"

NSString *const FillJobStateCellID = @"FillJobStateCellID";
NSString *const JobCircleTagAndPictureCellID = @"JobCircleTagAndPictureCellID";
NSString *const SelectUsrNameCellID = @"SelectUsrNameCellID";
NSString *const ShareJobDynamicCellID = @"ShareJobDynamicCellID";

#import "GBReleaseJobDynamicVC.h"
#import "GBFillJobStateCell.h"
#import "JobCircleTagAndPictureCell.h"
#import "SelectUsrNameCell.h"
#import "ShareJobDynamicCell.h"
#import "TagListView.h"
#import "MJPhotoBrowser.h"
#import "MJPhoto.h"
#import "GBUploadPhotoCollectionCell.h"
#import "GBLookBigImagCollectionVC.h"
#import "GBMapViewController.h"
#import "UMSocial.h"
@interface GBReleaseJobDynamicVC ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,TagListViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,uploadPhotoDelegate,UICollectionViewDelegateFlowLayout,GBUploadPhotoDelegate,QBImagePickerControllerDelegate,UIGestureRecognizerDelegate,MJPhotoBrowserDelegate, ShareJobDynamicCellDelegate>{

    /** 记录选中的cell */
    NSInteger _index;
    BOOL _isHightImage;
}
@property (nonatomic, strong) UITableView *tableview;

// 上传图片
@property(nonatomic, strong) UICollectionView * imageCollectionView;

@property(nonatomic, strong) NSMutableArray * imageArray;

@end

@implementation GBReleaseJobDynamicVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationTitleLabel.text = @"工作圈";

    [self createNavigateBarButton];

    [self createTableView];

}

#pragma Mark -- TableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 3;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if (section == 0) {
        return 3;
    }else if (section == 1){
    
        return 2;
    }else{
    
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return section == 0? 0 : 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
                return 124;
                break;
            case 1:
                return 250;
                break;
            case 2:
            {
                CGFloat newCollectionHight;
                if (_imageArray.count < 4) {
                    newCollectionHight =((_imageArray.count) /4  + 1) * ItemWH;
                    return 150;
                }else{
                    newCollectionHight = _imageArray.count/4*ItemWH;
                    return 250;

                }
            }
                break;
            default:
                return 0;
                break;
        }
    }else if (indexPath.section == 1){
    
        return 44;
    }else{
    
        return 50;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{


    UITableViewCell *cell;
    
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
              GBFillJobStateCell *fillJobCell = [GBFillJobStateCell cellWithTableView:tableView withIndexPath:indexPath withIdentifies:FillJobStateCellID];
                [fillJobCell setContentWithTableview:tableView withIndexPath:indexPath withParentController:self];
                cell = fillJobCell;
            }
                break;
                
            default:
            {
                JobCircleTagAndPictureCell *fillJobStateCell = [JobCircleTagAndPictureCell cellWithTableView:tableView withIndexPath:indexPath withIdentifies:JobCircleTagAndPictureCellID];
                [fillJobStateCell setContentWithTableview:tableView withIndexPath:indexPath withParentController:self];
                if (indexPath.row == 2) {
                    
                    [self createUploadPhotoView:fillJobStateCell.cellContentView];

                }

                cell = fillJobStateCell;
            }
                break;
        }
    }else if (indexPath.section == 1){
    
       SelectUsrNameCell *usrNameCell = [SelectUsrNameCell cellWithTableView:tableView withIndexPath:indexPath withIdentifies:SelectUsrNameCellID];
        [usrNameCell setContentWithTableview:tableView withIndexPath:indexPath withParentController:self];

        cell = usrNameCell;

    }
    else{
    
        ShareJobDynamicCell *shareCell = [ShareJobDynamicCell cellWithTableView:tableView withIndexPath:indexPath withIdentifies:ShareJobDynamicCellID];
        shareCell.delegate = self;
        [shareCell setContentWithTableview:tableView withIndexPath:indexPath withParentController:self];
        if (indexPath.row ==  0) {
            shareCell.cellTtileLabel.text = @"五道口";
            shareCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

        cell = shareCell;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[SelectUsrNameCell class]]) {
        
        // 取消上次的选择
        NSIndexPath *lastIndex = [NSIndexPath indexPathForRow:_index inSection:indexPath.section];
        SelectUsrNameCell *lastCell = (SelectUsrNameCell *)[tableView cellForRowAtIndexPath:lastIndex];
        lastCell.markImage.hidden = YES;
        lastCell.cellTtitle.textColor = [UIColor colorWithWhite:0.710 alpha:1.000];

        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        SelectUsrNameCell *cell = (SelectUsrNameCell *)[tableView cellForRowAtIndexPath:indexPath];
        cell.markImage.hidden = NO;
        cell.cellTtitle.textColor = [UIColor blackColor];
        // 记录本次点击的cell；
        _index = indexPath.row;

    }
    if ([cell isKindOfClass:[ShareJobDynamicCell class]]) {
        ShareJobDynamicCell *shareCell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 0) {
            
            GBMapViewController *mapViewVC = [[GBMapViewController alloc] init];
            mapViewVC.locationBlock = ^(NSString *locationString){
                if (locationString) {
                    shareCell.cellTtileLabel.text = locationString;

                }
//                [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            };
            [AppNavigator pushViewController:mapViewVC withCurrentView:self.view animated:YES];
            
        }else{
            
            if (!_isHightImage) {
                _isHightImage = YES;
                [shareCell.cellImageView setHighlighted:YES];
            }else{
                [shareCell.cellImageView setHighlighted:NO];
                _isHightImage = NO;

            }
        }
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

#pragma mark -- selectUpaloadImage
- (void) selectImageList
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




#pragma mark -- TagListViewDelegate
- (void)selectTagsArray:(NSArray *)tagArray{

    DLog(@"选中的标签%@", [tagArray objectAtIndex:0]);
    
}
#pragma mark -- UITextViewDelegate

- (void)textViewDidChange:(UITextView *)textView{
    GBFillJobStateCell *cell = CELL_SUBVIEW_TABLEVIEW(textView, self.tableview);
    
    // 设置textView默认显示的文字
    if (textView.text.length == 0) {
        
        cell.placeholdText.hidden = NO;
    }else{
        
        cell.placeholdText.hidden = YES;
    }
    
    CGSize  tH     = [self textSizeWithTextView:(UITextView *)textView Font:textView.font.pointSize text:nil];
    CGFloat offset = (textView.frame.size.height - tH.height)/2.f;
    
    textView.textContainerInset = UIEdgeInsetsMake(offset, 0, offset, 0);

}

- (CGSize)textSizeWithTextView:(UITextView *)textView Font:(CGFloat)font text:(NSString *)string
{
    NSString *text = string ? string : textView.text;
    
    CGFloat tMargen = textView.textContainer.lineFragmentPadding * 2;
    CGFloat tW = textView.frame.size.width - tMargen;
    CGSize tSize = [text boundingRectWithSize:CGSizeMake(tW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    return  tSize;
}



- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length == 0) {
        return;
    }
//    _jobExp.jobContentDes = textView.text;
    
}

#pragma mark -- UIScrollerViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    [self.view endEditing:YES];
}

#pragma mark YYUploadPhotoCollectionCell delegate
-(void)deleteImage:(NSInteger)index
{
    [_imageArray removeObjectAtIndex:index];
    [self updateUI];
}

#pragma mark --  MJPhotoBrowserDelegate
-(void)deletedPictures:(NSSet *)set
{
    NSMutableArray *cellArray = [NSMutableArray array];
    
    for (NSString *index1 in set) {
        [cellArray addObject:index1];
    }
    
    if (cellArray.count == 0) {
        
    }else if (cellArray.count == 1 && self.imageArray.count == 1) {
        NSIndexPath *indexPathTwo = [NSIndexPath indexPathForRow:0 inSection:0];
        
        [self.imageArray removeObjectAtIndex:indexPathTwo.row];
        [self.imageCollectionView deleteItemsAtIndexPaths:@[indexPathTwo]];
    }else{
        
        for (int i = 0; i<cellArray.count-1; i++) {
            for (int j = 0; j<cellArray.count-1-i; j++) {
                if ([cellArray[j] intValue]<[cellArray[j+1] intValue]) {
                    NSString *temp = cellArray[j];
                    cellArray[j] = cellArray[j+1];
                    cellArray[j+1] = temp;
                }
            }
        }
        
        for (int b = 0; b<cellArray.count; b++) {
            int idexx = [cellArray[b] intValue]-1;
            
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idexx inSection:0];
            
            [self.imageArray removeObjectAtIndex:indexPath.row];
            [self.imageCollectionView deleteItemsAtIndexPaths:@[indexPath]];
        }
    }
    
    [self updateUI];
}

#pragma mark -- ShareJobDynamicCellDelegate
- (void)didClickShareButton:(QCheckBox *)sender withType:(GBShareBtnWithType)shareBtnWithType{

    switch (shareBtnWithType) {
        case GBShareBtnWithSina:
        {
            [UMSocialData defaultData].extConfig.title = @"分享的title";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                                @"http://www.baidu.com/img/bdlogo.gif"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"分享内嵌文字" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {

                    [STAlertView alertWithTitle:@"成功" message:@"分享成功" cancelButtonTitle:@"好" otherButtonTitles:nil cancelButtonBlock:^{
                        
                    } otherButtonBlock:^{
                        
                    }];
                }else{
                
                    [STAlertView alertWithTitle:@"失败" message:@"抱歉" cancelButtonTitle:@"分享失败" otherButtonTitles:@"好" cancelButtonBlock:nil otherButtonBlock:nil];
                    [sender setChecked:NO];
                }
            }];
        }
            break;
        case GBShareBtnWithQzone:
        {
            [UMSocialData defaultData].extConfig.title = @"分享的title";
            [UMSocialData defaultData].extConfig.qzoneData.url = @"http://baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                                @"http://www.baidu.com/img/bdlogo.gif"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:@"分享内嵌文字" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [STAlertView alertWithTitle:@"成功" message:@"分享成功" cancelButtonTitle:@"好" otherButtonTitles:nil cancelButtonBlock:nil otherButtonBlock:nil];
                }else{
                [STAlertView alertWithTitle:@"抱歉" message:@"分享失败" cancelButtonTitle:@"好" otherButtonTitles:nil cancelButtonBlock:nil otherButtonBlock:nil];
                    [sender setChecked:NO];

                }
            }];
        }
            break;
        case GBShareBtnWithWechat:
        {
            [UMSocialData defaultData].extConfig.title = @"分享的title";
            [UMSocialData defaultData].extConfig.qqData.url = @"http://baidu.com";
            UMSocialUrlResource *urlResource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeImage url:
                                                @"http://www.baidu.com/img/bdlogo.gif"];
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:@"分享内嵌文字" image:nil location:nil urlResource:urlResource presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
                if (shareResponse.responseCode == UMSResponseCodeSuccess) {
                    [STAlertView alertWithTitle:@"成功" message:@"分享成功" cancelButtonTitle:@"好" otherButtonTitles:nil cancelButtonBlock:nil otherButtonBlock:nil];
                }else{
                    [STAlertView alertWithTitle:@"抱歉" message:@"分享失败" cancelButtonTitle:@"好" otherButtonTitles:nil cancelButtonBlock:nil otherButtonBlock:nil];
                    [sender setChecked:NO];

                }
            }];
        }
            break;
            
        default:
            break;
    }
}

#pragma mark -- Action

- (void) layoutSubview
{
    CGRect collectionRect = _imageCollectionView.frame;
    CGFloat newCollectionHight;
    if (_imageArray.count < 6) {
        newCollectionHight =((_imageArray.count) / 4  + 1) * ItemWH;
    }else{
        newCollectionHight = _imageArray.count/4*ItemWH;
        
    }
    collectionRect.size.height = newCollectionHight;
    
    [self.tableview reloadData];
    
    _imageCollectionView.frame = collectionRect;
}

- (void)createUploadPhotoView:(id)parentView{

    //发布动态图片
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(ItemWH, ItemWH)];
    CGFloat hight = (_imageArray.count/4 +1) *ItemWH;
    _imageCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, hight) collectionViewLayout:flowLayout];
    _imageCollectionView.delegate = self;
    _imageCollectionView.dataSource = self;
    _imageCollectionView.backgroundColor = [UIColor clearColor];
    [parentView addSubview:_imageCollectionView];
    [_imageCollectionView registerClass:[GBUploadPhotoCollectionCell class] forCellWithReuseIdentifier:PHOTO_IMAGE_CELL_IDENTIFIER];
    [_imageCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:SELECT_IMAGE_CELL_IDENTIFIER];
    
}

- (void)createTableView{
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
    _tableview.delegate = self;
    _tableview.dataSource = self;
    _tableview.backgroundColor = [UIColor whiteColor];
    _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableview];
    
    _tableview.tableFooterView = [UIView new];
    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (void)createNavigateBarButton{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"发布" forState:(UIControlStateNormal)];
    [button.titleLabel setFont:GBSystemFont(15)];
    [button setTitleColor:[UIColor colorWithRed:0.171 green:0.741 blue:1.000 alpha:1.000] forState:(UIControlStateNormal)];
//    button.adjustsImageWhenDisabled = NO;
    button.frame = CGRectMake(0, 0, 50, 30);
    [button addTarget:self action:@selector(releaseJobDynamic:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self setRightBarButtonItem:rightItem];
    
    UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancleButton setTitle:@"取消" forState:(UIControlStateNormal)];
    [cancleButton.titleLabel setFont:GBSystemFont(15)];
    [cancleButton setTitleColor:[UIColor colorWithWhite:0.681 alpha:1.000] forState:(UIControlStateNormal)];
    cancleButton.frame = CGRectMake(0, 0, 50, 30);
    [cancleButton addTarget:self action:@selector(cancleReleaseJobDynamic:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:cancleButton];
    [self setLeftBarButtonItem:leftItem];
}

- (void)releaseJobDynamic:(id)sender{

    DLog(@"发布");
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)cancleReleaseJobDynamic:(id)sender{
    
    DLog(@"取消发布");
    [self.navigationController popViewControllerAnimated:YES];

}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) updateUI
{
    [self layoutSubview];
    
    [_imageCollectionView reloadData];
    
}


// 懒加载
- (NSMutableArray *)imageArray{
    
    if (!_imageArray) {
        _imageArray = [[NSMutableArray alloc] init];
    }
    return _imageArray;
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
