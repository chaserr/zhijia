//
//  GBUserPotrialScrollerView.h
//  zhijia
//
//  Created by 张浩 on 16/5/12.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>


IB_DESIGNABLE
@interface GBUserPotrialScrollerView : UIView<UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate>

- (instancetype)initWithFrame:(CGRect)frame withImageArray:(NSArray *)imageArray;

@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@property (nonatomic, strong) UICollectionView *collectionView;
/** itemSize */
@property (nonatomic, assign) IBInspectable CGSize itemSize;
/** 水平方向滑动的时候代表最小列间距 */
@property (nonatomic, assign) IBInspectable CGFloat minimumLineSpacing;
/** 是否进入对方空间 */
@property (nonatomic, assign) BOOL isOpenUserSpace;

@property (nonatomic, strong) NSArray *portrialArray;


@end
