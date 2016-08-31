//
//  UIImage+Ext.h
//  YouYuan
//
//  Created by phoenix on 14-10-10.
//  Copyright (c) 2014年 SEU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (IdentifierAddition)

// 截取部分图像
- (UIImage*)getSubImage:(CGRect)rect;

// 等比例缩放
- (UIImage*)scaleToSize:(CGSize)size;

/**
 *  @brief  Create a partially displayed image
 *
 *  @param  percentage  This defines the part to be displayed as original
 *  @param  vertical    If YES, the image is displayed bottom to top; otherwise left to right
 *  @param  grayscaleRest   If YES, the non-displaye part are in grayscale; otherwise in transparent
 *
 *  @return A generated UIImage instance
 */
- (UIImage*)partialImageWithPercentage:(float)percentage
                              vertical:(BOOL)vertical
                         grayscaleRest:(BOOL)grayscaleRest;


/**
 *  返回一张自由拉伸的图片
 */
+ (UIImage *)resizedImageWithName:(NSString *)name;

/** 颜色转换为背景色 */
+ (UIImage *)imageWithColor:(UIColor *)color;

// 添加毛玻璃效果

- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

/**
 *  模糊图片
 *
 *  @param image 源图片
 *  @param blur  模糊值 0~1
 *
 *  @return 模糊以后的图片
 */
+ (UIImage*)blurImage:(UIImage *)inputImage withBlurLevel:(CGFloat)blurLevel;

@end
