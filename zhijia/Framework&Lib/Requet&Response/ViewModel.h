//
//  ViewModel.h
//  zhijia
//
//  Created by TANHUAZHE on 7/18/15.
//  Copyright (c) 2015 Hahu. All rights reserved.
//

#import "Action.h"
#import "RACEXTScope.h"
#import "ReactiveCocoa.h"
#import "Request.h"
@interface ViewModel : NSObject
@property(nonatomic,strong)Action *action;
+ (id)ViewModel;
- (void)handleActionMsg:(Request *)msg;
- (void)DO_DOWNLOAD:(Request *)req;
- (void)SEND_ACTION:(Request *)req;
- (void)SEND_CACHE_ACTION:(Request *)req;
- (void)SEND_NO_CACHE_ACTION:(Request *)req;
- (void)SEND_IQ_ACTION:(Request *)req;
- (void)loadSceneModel;
@end
