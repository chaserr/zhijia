//
//  GBUploadPhotoCollectionCell.m
//  zhijia
//
//  Created by 张浩 on 16/5/8.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBUploadPhotoCollectionCell.h"

@interface GBUploadPhotoCollectionCell ()
@property (nonatomic, strong) UIImageView * deleteBtn;
@property (nonatomic, assign) NSInteger imageIndex;
@end

@implementation GBUploadPhotoCollectionCell

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = self.bounds;
        _uploadImageView = [[UIImageView alloc] initWithFrame:rect];
        _uploadImageView.contentMode = UIViewContentModeScaleAspectFill;
        _uploadImageView.layer.masksToBounds = YES;
        [self addSubview:_uploadImageView];
        CGRect deleteBtnLineRect = TopCenterRect(rect, CGRectGetWidth(rect), 23, 0);
        _deleteBtn = [[UIImageView alloc] initWithFrame:RightRect(deleteBtnLineRect, 23, 0)];
        _deleteBtn.image = [UIImage imageNamed:@"delete_icon"];
        _deleteBtn.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
        [_deleteBtn addGestureRecognizer:tapGesture];
        [self addSubview:_deleteBtn];
        
    }
    return self;
    
}

- (void) setUploadImage:(UIImage *) image withIndex:(NSInteger) index
{
    _uploadImageView.image = image;
    _imageIndex = index ;
}
- (void)tapRecognizer:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(deleteImage:)]) {
        [self.delegate deleteImage:_imageIndex ];
    }
}
@end
