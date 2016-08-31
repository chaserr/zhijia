//
//  YYShareToolViewConroller.h
//  YouYuanClient
//
//  Created by 童星 on 16/2/22.
//  Copyright © 2016年 SEU. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface YYShareToolViewConroller : UIViewController<UIActionSheetDelegate>


@property (nonatomic, retain)NSString *shareTitle;
@property (nonatomic, retain)NSString *detailInfo;
@property (nonatomic, retain)UIImage *shareImage;
@property (nonatomic, retain)NSString *shareImageURL;


- (void)initWhithTitle:(NSString *)title detailInfo:(NSString*)detailInfo
                 image:(UIImage *)image imageUrl:(NSString *)imageUrl;


@end
