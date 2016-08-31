//
//  ActionDelegate.h
//  zhijia
//
//  Created by TANHUAZHE on 7/18/15.
//  Copyright (c) 2015 Hahu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ActionDelegate <NSObject>
-(void)handleActionMsg:(Request *)msg;
@optional
-(void)handleProgressMsg:(Request *)msg;
@end
