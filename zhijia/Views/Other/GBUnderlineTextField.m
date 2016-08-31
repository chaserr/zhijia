//
//  GBUnderlineTextField.m
//  zhijia
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBUnderlineTextField.h"

@implementation GBUnderlineTextField


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    //Get the current drawing context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //Set the line color and width
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:161 green:163 blue:168 alpha:0.2f].CGColor);
    CGContextSetLineWidth(context, 1.0f);
    
    
    //Start a new Path
    CGContextBeginPath(context);
    
    //Find the number of lines in our textView + add a bit more height to draw lines in the empty part of the view
    //NSUInteger numberOfLines = (self.contentSize.height + self.bounds.size.height) / self.font.leading;
    
    //Set the line offset from the baseline. (I'm sure there's a concrete way to calculate this.)
    CGFloat baselineOffset = 40.0f;
    
    //iterate over numberOfLines and draw each line
    //for (int x = 1; x < numberOfLines; x++) {
    
    //0.5f offset lines up line with pixel boundary
    CGContextMoveToPoint(context, self.bounds.origin.x, self.font.leading + 1.5f + baselineOffset);
    CGContextAddLineToPoint(context, self.bounds.size.width-10, self.font.leading + 0.5f + baselineOffset);
    //}
    
    //Close our Path and Stroke (draw) it
    CGContextClosePath(context);
    CGContextStrokePath(context);
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, _horizontalPadding, _verticalPadding);
}

// text position
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds, _horizontalPadding, _verticalPadding);
}


@end
