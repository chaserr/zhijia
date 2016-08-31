//
//  GBSegumentController.h
//  zhijia
//
//  Created by 童星 on 16/6/7.
//  Copyright © 2016年 Beijing tongxing Technology Development Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class GBSegumentController;

NS_ASSUME_NONNULL_BEGIN

@protocol GBSegmentViewDelegate <NSObject>
- (void)segmentView:(GBSegumentController * __nullable)segmentView didSelectedIndex:(NSUInteger)selectedIndex;
@end

typedef void(^selectionBlock)(NSUInteger segmentIndex);

@interface GBSegumentController : UIView

typedef void (^selectedHandler)(GBSegumentController * __nullable view, NSInteger selectedIndex);

#pragma mark - Accessing the Delegate
///=============================================================================
/// @name Accessing the Delegate
///=============================================================================

@property (nullable, nonatomic, weak) id<GBSegmentViewDelegate> delegate;

#pragma mark - Accessing the BlockHandler
///=============================================================================
/// @name Accessing the BlockHandler
///=============================================================================

@property (nullable, nonatomic, copy) selectedHandler handlder;

#pragma mark - Configuring the Text Attributes
///=============================================================================
/// @name Configuring the Text Attributes
///=============================================================================

@property (nonatomic, strong) UIColor *tintColor; ///< set style color, default blue color.
@property (nonatomic, assign) CGFloat leftRightMargin; ///< set RFSegmentView left and right margin, default 15.f.
@property (nonatomic, assign) CGFloat itemHeight; ///< set RFSegmentView item height, default 30.f.
@property (nonatomic, assign) CGFloat cornerRadius; ///< set RFSegmentView's cornerRadius, default 3.f.
@property (nonatomic, assign, getter=currentSelectedIndex) NSUInteger selectedIndex; ///< set which item is seltected, default 0.
@property (nonatomic, strong) NSArray        *titles;

#pragma mark - Initializer

- (instancetype)initWithFrame:(CGRect)frame
                        items:(NSArray<NSString *> * _Nonnull)items;

- (instancetype)init UNAVAILABLE_ATTRIBUTE;
- (instancetype)initWithFrame:(CGRect)frame UNAVAILABLE_ATTRIBUTE;

+ (instancetype)new UNAVAILABLE_ATTRIBUTE;

@end

NS_ASSUME_NONNULL_END
