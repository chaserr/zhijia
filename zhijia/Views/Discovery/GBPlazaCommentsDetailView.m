//
//  GBPlazaCommentsView.m
//  zhijia
//
//  Created by admin on 15/7/28.
//  Copyright (c) 2015年 Beijing Hahu Technology Development Co., Ltd. All rights reserved.
//

#import "GBPlazaCommentsDetailView.h"
#import "GBPostsModel.h"

@interface GBPlazaCommentSingle()

@end

@implementation GBPlazaCommentSingle

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
    [self setBackgroundImage:[UIImage alloc] forState:UIControlStateNormal];
    //self.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
}

@end

@interface GBPlazaCommentsDetailView()

@end

@implementation GBPlazaCommentsDetailView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

+(CGFloat)calculateCommentsHeight:(NSInteger)count
{
    return count*GBCommentHeight;
}

-(void)setComments:(NSArray *)array
{
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    CGFloat totalHeight=0;
    
    for (NSString *commentStr in array) {
        GBPlazaCommentSingle *commentSingle = [[GBPlazaCommentSingle alloc] initWithFrame:CGRectMake(0, totalHeight, SCREEN_WIDTH - 2*GBAvatarSpacing, GBCommentHeight)];
        [commentSingle setTitle:commentStr forState:UIControlStateNormal];
        [self addSubview:commentSingle];
        totalHeight += GBCommentHeight;
    }
}
@end
