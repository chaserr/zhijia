//
//  GBJobExp.h
//  zhijia
//
//  Created by 张浩 on 16/5/5.
//  Copyright © 2016年 Beijing Jianjian Technology Development Co., Ltd. All rights reserved.
//

#import "GBBaseObject.h"

@interface GBJobExp : GBBaseObject
/** 公司名称 */
@property (nonatomic, copy) NSString *companyName;
/** 部门名称 */
@property (nonatomic, copy) NSString *departmentName;
/** 职位名称 */
@property (nonatomic, copy) NSString *jobPosition;
/** 任职时间 */
@property (nonatomic, copy) NSString *jobTime;
/** 工作内容描述 */
@property (nonatomic, copy) NSString *jobContentDes;

@property (assign, nonatomic) CGFloat cellHeight;




@end
