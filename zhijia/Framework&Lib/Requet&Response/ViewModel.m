//
//  ViewModel.m
//  zhijia
//
//  Created by TANHUAZHE on 7/18/15.
//  Copyright (c) 2015 Hahu. All rights reserved.
//
#import "ViewModel.h"

@implementation ViewModel

+(id)ViewModel{
    return [[self alloc]initModel];
}

- (id)initModel{
    self = [super init];
    if(self){
        [self loadSceneModel];
    }
    return self;
}

- (void)loadSceneModel{
    self.action = [Action Action];
}


- (void)handleActionMsg:(Request *)msg{
    if(msg.sending){
        NSLog(@"sending:%@",msg.url);
    }else if(msg.succeed){
        NSLog(@"success:%@",msg.output);
    }else if(msg.failed){
        NSLog(@"failed:%@",msg.error);
    }
}

- (void)handleProgressMsg:(Request *)msg{
    
}

-(void)DO_DOWNLOAD:(Request *)req{
    if(req !=nil){
//        [self.action Download:req];
    }
}

- (void)SEND_ACTION:(Request *)req{
    if(req !=nil){
//        [self.action Send:req];
    }
}

- (void)SEND_CACHE_ACTION:(Request *)req{
    [self.action readFromCache];
    [self SEND_ACTION:req];
}

- (void)SEND_NO_CACHE_ACTION:(Request *)req{
    [self.action notReadFromCache];
    [self SEND_ACTION:req];
}

- (void)SEND_IQ_ACTION:(Request *)req{
    if (req.isFirstRequest) {
        req.isFirstRequest = NO;
        [self.action readFromCache];
    }else{
        [self.action notReadFromCache];
    }
    [self SEND_ACTION:req];
}

@end
