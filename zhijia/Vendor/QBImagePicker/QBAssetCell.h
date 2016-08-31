//
//  QBAssetCell.h
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QBVideoIndicatorView;


@interface QBAssetCell : UICollectionViewCell

//@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet QBVideoIndicatorView *videoIndicatorView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) BOOL showsOverlayViewWhenSelected;
@property (nonatomic, weak)id delegate;
- (void) setIsSelected:(BOOL)isSelected;

@property (nonatomic, strong) NSIndexPath * indexPath;
@end
@protocol QBAssetCellDelegate <NSObject>

- (void) imageSelectedChangeWith:(QBAssetCell *) assetCell;
- (void) imageTap:(QBAssetCell *) assetCell;
@end