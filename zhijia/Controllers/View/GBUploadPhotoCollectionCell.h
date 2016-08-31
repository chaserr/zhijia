//
//  GBUploadPhotoCollectionCell.h
//  zhijia
//
//  Created by 张浩 on 16/5/8.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol uploadPhotoDelegate <NSObject>

-(void)deleteImage:(NSInteger)index;

@end

@interface GBUploadPhotoCollectionCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView * uploadImageView;

@property (nonatomic,assign) id <uploadPhotoDelegate> delegate;
- (void) setUploadImage:(UIImage *) image withIndex:(NSInteger) index;
@end
