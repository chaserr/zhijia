//
//  GBLookBigImagCollectionVC.m
//  zhijia
//
//  Created by 张浩 on 16/5/9.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBLookBigImagCollectionVC.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "GBLookBigImageCell.h"

static CGSize CGSizeScale(CGSize size, CGFloat scale) {
    return CGSizeMake(size.width * scale, size.height * scale);
}

@interface GBLookBigImagCollectionVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{

    BOOL isChromeHidden_;
    NSTimer *chromeHideTimer_;
    BOOL _bUserSpace;//判断是否为用户空间，还是我的空间
}

@property (nonatomic, strong) UICollectionView *collectionView;


@property(nonatomic,assign)YYScanImageType scanImageType;

@property(nonatomic,strong)UIView * footerView;

@property(nonatomic,assign)BOOL ishiden;
@property(nonatomic,assign)NSInteger pageNumber;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)NSMutableArray * imageViewArray;
@property(nonatomic,assign)BOOL isLayout;
@property(nonatomic,assign)CGSize imageSize;
@property(nonatomic,strong)NSMutableArray * donwImageArray;

@property(nonatomic,strong)NSMutableArray * imageArray;
@property(nonatomic,strong)UIButton * sureBtn;
@property(nonatomic,strong)UIButton * selectBtn;
@property(nonatomic,strong)UIImage * selectedImage;
@property(nonatomic,strong)UIImage * unselectedImage;
@property(nonatomic,strong)NSMutableArray * selectedArray;
@property(nonatomic,strong)PHFetchResult * fetchResult;
@property(nonatomic,strong)PHCachingImageManager * imageManager;
@property(nonatomic,strong)PHImageRequestOptions *requestOptions;
@property (nonatomic, strong) UIPageControl *pageControl;


@property (nonatomic, strong) NSMutableArray *photosArray;

@end

@implementation GBLookBigImagCollectionVC

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"GBLookBigImageCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    if (self.fetchResult.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:(_currentPage) inSection:0];
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:NO];
        
    }
    
    
    _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50)];
    [self.view addSubview:_footerView];

    
    _pageControl = [[UIPageControl alloc] init];
    _pageControl.currentPage = _currentPage;
    if (_imageArray.count != 1) {
        _pageControl.numberOfPages = _imageArray.count;
    }
    _pageControl.frame = CGRectMake((SCREEN_WIDTH - 40)/2, SCREEN_HEIGHT - 69, 40, 20);
    [self.view addSubview:_pageControl];
    
    [self showButtons];
    _isLayout = YES;
    [self upateCurrentImageState];
    [self setSendBtnState];
    [self customlizeNavigationBarBackBtn];
    // Do any additional setup after loading the view.
    
}



- (void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setToolbarHidden:YES];
    

}


- (id)initWithImageArray:(NSArray *)imageArray atIndex:(NSInteger) index
{
    self = [super init];
    if (self) {
        _imageArray = [NSMutableArray arrayWithArray:imageArray];
        //        _imageViewArray = [NSMutableArray arrayWithCapacity:0];
        _pageNumber = _imageArray.count;
        _currentPage = index;
        _donwImageArray = [NSMutableArray array];
    }
    return self;
}

- (id)initWithImageArray:(NSArray *)imageArray atIndex:(NSInteger) index withType:(YYScanImageType)type
{
    self = [super init];
    if (self) {
        _imageArray = [NSMutableArray arrayWithArray:imageArray];
        //        _imageViewArray = [NSMutableArray arrayWithCapacity:0];
        _pageNumber = _imageArray.count;
        _currentPage = index;
        _donwImageArray = [NSMutableArray array];
        _scanImageType = type;
    }
    return self;
    
}

- (id)initWithImageArray:(PHFetchResult *)fetchResult atIndex:(NSInteger) index withSelectedImage:(NSArray *) selectAssetsArray withType:(YYScanImageType)type
{
    self = [super init];
    if (self) {
        
        //        _cellLoadCount = 0;
        _fetchResult = fetchResult;
        _selectedArray = [NSMutableArray arrayWithArray:selectAssetsArray];
        _pageNumber = _fetchResult.count;
        _currentPage = index;
        _scanImageType = type;
        _imageManager = [PHCachingImageManager new];
        if (!_requestOptions) {
            _requestOptions = [[PHImageRequestOptions alloc] init];
            _requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeOpportunistic;
            _requestOptions.version = PHImageRequestOptionsVersionCurrent;
            //            _requestOptions.synchronous = YES;
            _requestOptions.networkAccessAllowed =false;
        }
    }
    return self;
}

- (id)initWithAllPhotoImageArray:(NSArray *)assets atIndex:(NSInteger)index withSelectedImage:(NSArray *)selectAssetsArray withType:(YYScanImageType)type
{
    self = [super init];
    if (self) {
        _imageArray = [NSMutableArray arrayWithArray:assets];
        _selectedArray = [[NSMutableArray alloc] initWithArray:selectAssetsArray];
        _pageNumber = assets.count;
        _currentPage = index;
        _scanImageType = type;
        
    }
    return self;
    
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (YYScanImageComeReleaseDynimic == _scanImageType) {
        if (_fetchResult != nil) {
            return _fetchResult.count;
            
        }else {
            return  _pageNumber;
        }
    }else{
        return _pageNumber;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
     GBLookBigImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if(self.fetchResult != nil){

        PHAsset *asset = self.fetchResult[indexPath.item];
        CGSize itemSize = [(UICollectionViewFlowLayout *)collectionView.collectionViewLayout itemSize];
        CGSize targetSize = CGSizeScale(itemSize, self.traitCollection.displayScale);
//        CGSize itemSize = CGSizeMake(SCREEN_WIDTH *[UIScreen mainScreen].scale, SCREEN_HEIGHT*[UIScreen mainScreen].scale)  ;
        
        [self.imageManager requestImageForAsset:asset
                                     targetSize:targetSize
                                    contentMode:PHImageContentModeAspectFit
                                        options:_requestOptions
                                  resultHandler:^(UIImage *result, NSDictionary *info) {
                                      cell.imageCell.image = result;
                                      
                                  }];

    }else{
    
        ALAsset *asset = self.imageArray[indexPath.row];
        ALAssetRepresentation *assetRep = [asset defaultRepresentation];
        CGImageRef imgRef = [assetRep fullResolutionImage];
        UIImage *image = [UIImage imageWithCGImage:imgRef
                                             scale:assetRep.scale
                                       orientation:(UIImageOrientation)assetRep.orientation];
        cell.imageCell.image = [self imageWithImage:image];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    DLog(@"点击了第%ld个", (long)indexPath.item);
}

#pragma mark <UICollectionViewDelegate>

#pragma mark -- UIScrollerViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    if (_currentPage == scrollView.contentOffset.x / SCREEN_WIDTH) {
        
        return;
    }
    else{
        _currentPage = scrollView.contentOffset.x / SCREEN_WIDTH;
        
    }
    //    if (_currentPage > _pageNumber || _imageArray.count == 0) {
    //        return;
    //    }
    _pageControl.currentPage = _currentPage;
    
    //    self.navigationTitleLabel.text = [NSString stringWithFormat:@"%lu/%ld",(_currentPage + 1), (long)_pageNumber];
    [self upateCurrentImageState];
    
}

#pragma mamrk -- Action

- (UICollectionView *)collectionView{
    
    CGRect rect = self.view.bounds;
    if (nil == _collectionView) {
        UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT)];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64) collectionViewLayout:flowLayout];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentOffset = CGPointMake(SCREEN_WIDTH * _currentPage, 0);
        _collectionView.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_collectionView];
        
    }
    return _collectionView;
}


-(void)showButtons
{
    _selectedImage = [UIImage imageNamed:@"common_icon_checked"];
    _unselectedImage = [UIImage imageNamed:@"common_icon_unchecked"];
    _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _selectBtn.frame = CGRectMake(0, 0, _selectedImage.size.width + 10, _selectedImage.size.height + 10);
    [_selectBtn.imageView setContentMode:UIViewContentModeScaleToFill];
    [_selectBtn addTarget:self action:@selector(selectBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_selectBtn setImage:_unselectedImage forState:UIControlStateNormal ];
    UIBarButtonItem * selectBarBtn = [[UIBarButtonItem alloc] initWithCustomView:_selectBtn];
    self.rightBarButtonItem = selectBarBtn;
    
    _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sureBtn setTitle:@"完成" forState:UIControlStateNormal];
    [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sureBtn setTitleColor:RGBCOLORVA(0xffffff, 0.6) forState:UIControlStateDisabled];
    [_sureBtn addTarget:self action:@selector(sureBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    _sureBtn.enabled = NO;
    _sureBtn.frame = CenterRect(_footerView.bounds, 60, 40);
    [_footerView addSubview:_sureBtn];
    
}

- (void)setSendBtnState
{
    if (_selectedArray.count > 0) {
        _sureBtn.enabled = YES;
    }else {
        _sureBtn.enabled = NO;
    }
}

- (void) upateCurrentImageState
{
    if(self.fetchResult != nil){
        PHAsset *asset = self.fetchResult[_currentPage];
        
        if ([_selectedArray containsObject: asset]) {
            [_selectBtn setImage:_selectedImage forState:UIControlStateNormal];
            
        }else{
            [_selectBtn setImage:_unselectedImage forState:UIControlStateNormal];
            
        }
    }else{
        ALAsset *asset = self.imageArray[_currentPage];
        if ([_selectedArray containsObject: asset]) {
            [_selectBtn setImage:_selectedImage forState:UIControlStateNormal];
            
        }else{
            [_selectBtn setImage:_unselectedImage forState:UIControlStateNormal];
            
        }
    }
    
}

- (void) sureBtnClick:(id) sender
{
    if ([self.delegate respondsToSelector:@selector(sendImageWithSelectArray:)]) {
        [self.delegate sendImageWithSelectArray:_selectedArray];
    }
    
}

- (void)selectBtnClick:(UIButton *)sender
{
    if (self.fetchResult != nil) {
        PHAsset *asset = self.fetchResult[_currentPage];
        if ([_selectedArray containsObject:asset]) {
            [_selectedArray removeObject:asset];
            [_selectBtn setImage:_unselectedImage forState:UIControlStateNormal];
        }else{
            if (_selectedArray.count == self.maxSelectCount) {
                [GBHUDVIEW showTips:[NSString stringWithFormat:@"最多可选择图片%ld张",self.maxSelectCount]];
                return;
            }
            
            sender.transform = CGAffineTransformIdentity;
            [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
                [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
                    
                    sender.transform = CGAffineTransformMakeScale(1.5, 1.5);
                }];
                [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
                    
                    sender.transform = CGAffineTransformMakeScale(0.8, 0.8);
                }];
                [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
                    
                    sender.transform = CGAffineTransformMakeScale(1.0, 1.0);
                }];
            } completion:nil];

            
            [_selectedArray addObject:asset];
            [_selectBtn setImage:_selectedImage forState:UIControlStateNormal];
            
        }
        
    }else{
        ALAsset *asset = self.imageArray[_currentPage];
        if ([_selectedArray containsObject:asset]) {
            [_selectedArray removeObject:asset];
            [_selectBtn setImage:_unselectedImage forState:UIControlStateNormal];
        }else{
            if (_selectedArray.count == self.maxSelectCount) {
                [GBHUDVIEW showTips:[NSString stringWithFormat:@"最多可选择图片%ld张",self.maxSelectCount]];
                return;
            }
            
            sender.transform = CGAffineTransformIdentity;
            [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
                [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
                    
                    sender.transform = CGAffineTransformMakeScale(1.5, 1.5);
                }];
                [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
                    
                    sender.transform = CGAffineTransformMakeScale(0.8, 0.8);
                }];
                [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
                    
                    sender.transform = CGAffineTransformMakeScale(1.0, 1.0);
                }];
            } completion:nil];
            [_selectedArray addObject:asset];
            [_selectBtn setImage:_selectedImage forState:UIControlStateNormal];
        }
        
    }
    [self setSendBtnState];
    
}

-(UIImage*)imageWithImage:(UIImage*)image
{
    // Create a graphics image context
    
    if (image.size.width  <= [UIDevice screenWidth] || image.size.height <= [UIDevice mainScreenHeight]) {
        return image;
    }
    CGSize newSize;
    if (image.size.height / 2 > image.size.width) {
        newSize.height = [UIDevice mainScreenHeight];
        newSize.width = [UIDevice mainScreenHeight] /image.size.height * image.size.width;
    }
    else {
        newSize.width = [UIDevice screenWidth];
        newSize.height = [UIDevice screenWidth]/image.size.width * image.size.height;
    }
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationBackSmallIcon object:_selectedArray];
    
}

// 懒加载
- (NSMutableArray *)photosArray{
    
    if (!_photosArray) {
        _photosArray = [[NSMutableArray alloc] init];
    }
    return _photosArray;
}





@end
