//
//  YYTextView.m
//  YouYuanClient
//
//  Created by 童星 on 16/1/6.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import "YYTextView.h"
#define kCursorVelocity 1.0f/8.0f
@interface YYTextView ()
@property (nonatomic, strong) UIPanGestureRecognizer *singleFingerPanRecognizer;
@property (nonatomic, strong) UIPanGestureRecognizer *doubleFingerPanRecognizer;
@property (nonatomic, assign) NSRange startRange;
@end

@implementation YYTextView

- (id)init
{
    self = [super init];
    if (self) {
        _singleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(singleFingerPanHappend:)];
        _singleFingerPanRecognizer.maximumNumberOfTouches = 1;
        [self addGestureRecognizer:_singleFingerPanRecognizer];
        
        _doubleFingerPanRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(doubleFingerPanHappend:)];
        _doubleFingerPanRecognizer.minimumNumberOfTouches = 2;
        [self addGestureRecognizer:_doubleFingerPanRecognizer];
    }
    return self;
}

- (void)requireGestureRecognizerToFail:(UIGestureRecognizer*)gestureRecognizer
{
    [self.singleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
    [self.doubleFingerPanRecognizer requireGestureRecognizerToFail:gestureRecognizer];
}

- (void)singleFingerPanHappend:(UIPanGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.startRange = self.selectedRange;
    }
    
    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)([sender translationInView:self].x*kCursorVelocity), 0);
    NSRange selectedRange = {cursorLocation, 0};
    self.selectedRange = selectedRange;
}

- (void)doubleFingerPanHappend:(UIPanGestureRecognizer*)sender
{
    if (sender.state == UIGestureRecognizerStateBegan)
    {
        self.startRange = self.selectedRange;
    }
    
    CGFloat cursorLocation = MAX(self.startRange.location+(NSInteger)([sender translationInView:self].x*kCursorVelocity), 0);
    NSRange selectedRange;
    if (cursorLocation > self.startRange.location)
    {
        selectedRange = NSMakeRange(self.startRange.location, fabs(self.startRange.location-cursorLocation));
    }
    else
    {
        selectedRange = NSMakeRange(cursorLocation, fabs(self.startRange.location-cursorLocation));
    }
    self.selectedRange = selectedRange;
}

@end
