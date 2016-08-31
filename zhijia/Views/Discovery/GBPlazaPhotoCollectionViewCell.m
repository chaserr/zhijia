//
//  GBPlazaPhotoCollectionViewCell.m
//  zhijia
//
//  Created by admin on 15/7/28.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBPlazaPhotoCollectionViewCell.h"

@implementation GBPlazaPhotoCollectionViewCell

-(UIImageView*)photoImageView{
    if(_photoImageView==nil){
        _photoImageView=[[UIImageView alloc] initWithFrame:self.bounds];
        _photoImageView.contentMode=UIViewContentModeScaleAspectFill;
        _photoImageView.layer.masksToBounds=YES;
        _photoImageView.backgroundColor = [UIColor whiteColor];
    }
    return _photoImageView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.photoImageView];
    }
    return self;
}

@end
