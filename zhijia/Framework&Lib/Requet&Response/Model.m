//
//  Model.m
//  zhijia
//
//  Created by TANHUAZHE on 7/18/15.
//  Copyright (c) 2015 Hahu. All rights reserved.
//

#import "Model.h"

@implementation Model

-(instancetype)init{
    self = [super init];
    if(self){
        [self loadModel];
    }
    return self;
}

+(id)Model{
    return [[self alloc]init];
}

-(void)loadModel{
    
}

@end
