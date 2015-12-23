//
//  NSString+YIAttributed.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/16.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YIAttributed)


// 创建富文本并配置富文本(NSArray中的数据必须是ConfigAttributedString对象合集)
- (NSMutableAttributedString *)createAttributedStringAndConfig:(NSArray *)configs;

// 用于搜寻一段字符串在另外一段字符串中的NSRange值
- (NSRange)rangeFrom:(NSString *)string;

// 本字符串的range
- (NSRange)range;



@end
