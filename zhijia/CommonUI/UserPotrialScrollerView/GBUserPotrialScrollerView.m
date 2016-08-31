//
//  GBUserPotrialScrollerView.m
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBUserPotrialScrollerView.h"
#import "GBUsersPortrialCell.h"
#import "GBUserSpaceViewController.h"
@implementation GBUserPotrialScrollerView

- (instancetype)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray
{
    self = [super initWithFrame:frame];
    if (self) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:_flowLayout];
        _collectionView.backgroundColor = self.backgroundColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"GBUsersPortrialCell" bundle:nil] forCellWithReuseIdentifier:@"PotrialCollectionCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;

        _portrialArray = imageArray;

        [self addSubview:_collectionView];
        
        _isOpenUserSpace = NO;
        
    }
    return self;
}

- (void)setIsOpenUserSpace:(BOOL)isOpenUserSpace{

    _isOpenUserSpace = isOpenUserSpace;
//    [self.collectionView reloadData];
    
}

#pragma mark -- UICollectionViewDelegate/dataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.portrialArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GBUsersPortrialCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PotrialCollectionCell" forIndexPath:indexPath];
    cell.cellImage.contentMode = UIViewContentModeScaleAspectFit;
    [cell.cellImage setImage:[UIImage imageNamed:[self.portrialArray objectAtIndex:indexPath.item]]];
    
    return cell;
    

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if (_isOpenUserSpace) {
        
        GBUserSpaceViewController* controller = [[GBUserSpaceViewController alloc] init];
        controller.navigationController.navigationBarHidden = YES;
        [[self getCurrentViewController].navigationController pushViewController:controller animated:YES];

    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    return self.itemSize;
}



- (void)setItemSize:(CGSize)itemSize{

    _itemSize = itemSize;
    _flowLayout.itemSize = itemSize;
    [self.collectionView reloadData];
    
}

- (void)setMinimumLineSpacing:(CGFloat)minimumLineSpacing{

    _minimumLineSpacing = minimumLineSpacing;
    _flowLayout.minimumLineSpacing = minimumLineSpacing;
}

- (void)setPortrialArray:(NSArray *)portrialArray{

    _portrialArray = portrialArray;
    
}

// 懒加载
- (NSArray *)imageArray{
    
    if (!_portrialArray) {
        _portrialArray = [[NSArray alloc] init];
    }
    return _portrialArray;
}
@end
