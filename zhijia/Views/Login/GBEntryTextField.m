//
//  GBEntryTextField.m
//  zhijia
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBEntryTextField.h"

@implementation GBEntryTextField
// placeholder position
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, _horizontalPadding, _verticalPadding);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, _horizontalPadding, _verticalPadding);
}

@end
