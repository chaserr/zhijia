//
//  QBAssetCell.m
//  QBImagePicker
//
//  Created by Katsuma Tanaka on 2015/04/03.
//  Copyright (c) 2015 Katsuma Tanaka. All rights reserved.
//

#import "QBAssetCell.h"

@interface QBAssetCell ()

//@property (weak, nonatomic) IBOutlet UIView *overlayView;
@property (nonatomic, strong) UIView * overlayView;
@property (nonatomic, strong) UIImageView * selecteImageView;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, strong) UIImage * selectedImage;
@property (nonatomic, strong) UIImage * unSelectedImage;
@end

@implementation QBAssetCell

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect rect = self.contentView.bounds;
        
        UITapGestureRecognizer * imageTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        _imageView = [[UIImageView alloc] initWithFrame:rect];
        [self.contentView addSubview:_imageView];
        
        _overlayView = [[UIView alloc] initWithFrame:rect];
        _overlayView.backgroundColor = RGBCOLORVA(0x000000, 0.6);
        _overlayView.hidden = YES;
        _overlayView.userInteractionEnabled = YES;
        [_overlayView addGestureRecognizer:imageTapGesture];
        [self.contentView addSubview:_overlayView];
        
        _selectedImage = [UIImage imageNamed:@"common_icon_checked"];
        _unSelectedImage = [UIImage imageNamed:@"common_icon_unchecked"];
        CGFloat imageWidth = _selectedImage.size.width;
        CGRect selectImageRect = TopCenterRect(rect, CGRectGetWidth(rect), imageWidth + 10 , 0);
        _selecteImageView = [[UIImageView alloc] initWithFrame:RightCenterRect(selectImageRect, imageWidth+10, imageWidth +10, 0)];
        _selecteImageView.image = _unSelectedImage;
        _selecteImageView.userInteractionEnabled = YES;
        _selecteImageView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer * tapGestureRecognizer= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRecognizer:)];
        [_selecteImageView addGestureRecognizer:tapGestureRecognizer];
        [self.contentView addSubview:_selecteImageView];
        _isSelected = NO;
        
    }
    return self;

}
-(void)imageTap:(id) sender
{
    if([self.delegate respondsToSelector:@selector(imageTap:)]){
        [self.delegate  imageTap:self];
    }
}

- (void)tapRecognizer:(UITapGestureRecognizer *) sender
{
    UIImageView *imageview = (UIImageView *)sender.view;
    if([self.delegate respondsToSelector:@selector(imageSelectedChangeWith:)])
    {
        imageview.transform = CGAffineTransformIdentity;
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations: ^{
            [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 3.0 animations: ^{
                
                imageview.transform = CGAffineTransformMakeScale(1.5, 1.5);
            }];
            [UIView addKeyframeWithRelativeStartTime:1/3.0 relativeDuration:1/3.0 animations: ^{
                
                imageview.transform = CGAffineTransformMakeScale(0.8, 0.8);
            }];
            [UIView addKeyframeWithRelativeStartTime:2/3.0 relativeDuration:1/3.0 animations: ^{
                
                imageview.transform = CGAffineTransformMakeScale(1.0, 1.0);
            }];
        } completion:nil];
        [self.delegate imageSelectedChangeWith:self];
    }
  
}

- (void) setIsSelected:(BOOL)isSelected
{
    if (_isSelected != isSelected) {
        _isSelected = isSelected;
        [self selectChange];
    }
    
}
- (void) selectChange
{
    if (_isSelected) {
        _selecteImageView.image = _selectedImage;
        _overlayView.hidden = NO;
        
    }else{
        _selecteImageView.image = _unSelectedImage;
        _overlayView.hidden = YES;
    }


}

//- (void)setSelected:(BOOL)selected
//{
//    [super setSelected:selected];
//    
//    // Show/hide overlay view
//    self.overlayView.hidden = !(selected && self.showsOverlayViewWhenSelected);
//}

@end
