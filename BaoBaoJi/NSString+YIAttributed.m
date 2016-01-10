//
//  NSString+YIAttributed.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/16.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "NSString+YIAttributed.h"
#import "YIConfigAttributedString.h"

@implementation NSString (YIAttributed)


- (NSMutableAttributedString *)createAttributedStringAndConfig:(NSArray *)configs
{
	NSMutableAttributedString *attributedString = \
	[[NSMutableAttributedString alloc] initWithString:self];
	
	[configs enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
		YIConfigAttributedString *oneConfig = obj;
		[attributedString addAttribute:oneConfig.attribute
								 value:oneConfig.value
								 range:oneConfig.range];
	}];
	
	return attributedString;
}

- (NSRange)rangeFrom:(NSString *)string
{
	return [string rangeOfString:self];
}

- (NSRange)range
{
	return NSMakeRange(0, self.length);
}


@end
