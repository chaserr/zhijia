//
//  GBLookBigImagCollectionVC.h
//  zhijia
//
//  Created by 张浩 on 16/5/9.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PhotosUI/PhotosUI.h>


@protocol YYLookBigImageViewDelegate <NSObject>

- (void)sendImageWithSelectArray:(NSArray *) selectArray;

@end

@interface GBLookBigImagCollectionVC : GBViewController

@property (nonatomic,assign)id delegate;
@property (nonatomic,assign)NSInteger maxSelectCount;


- (id)initWithImageArray:(PHFetchResult *)fetchResult atIndex:(NSInteger) index withSelectedImage:(NSArray *) selectAssetsArray withType:(YYScanImageType)type;

- (id)initWithImageArray:(NSArray *)imageArray atIndex:(NSInteger) index withType:(YYScanImageType)type;

- (id)initWithAllPhotoImageArray:(NSArray *)assets atIndex:(NSInteger)index withSelectedImage:(NSArray *)selectAssetsArray withType:(YYScanImageType)type;

@end
