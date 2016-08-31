//
//  NSString+Extension.h
//  新浪微博
//
//  Created by xc on 15/3/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize;

+ (BOOL)isBlankString:(NSString *)string;
// 普通字符串转换为十六进制
+ (NSString *)hexStringFromString:(NSString *)string;
// 出现类似这样格式的字段"\\U6df1\\U5733\\U56fd\\U5f00\\U884c01\\U673a\\U623",通常为Unicode码,转换函数为
+ (NSString *)replaceUnicode:(NSString *)unicodeStr;
//判断字符传中是否含标签字符
+ (BOOL)stringContainsEmoji:(NSString *)string;

// CFUUID(唯一标识符)
+ (NSString *)uniqueString;
@end
