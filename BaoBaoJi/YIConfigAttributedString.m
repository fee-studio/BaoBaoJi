//
//  YIConfigAttributedString.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/16.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIConfigAttributedString.h"

@interface YIConfigAttributedString()

@property (nonatomic, strong) NSString *attribute;
@property (nonatomic, strong) id        value;
@property (nonatomic, assign) NSRange   range;

@end

@implementation YIConfigAttributedString

+ (instancetype)attribute:(NSString *)attribute value:(id)value range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	
	config.attribute = attribute;
	config.value     = value;
	config.range     = range;
	
	return config;
}

+ (instancetype)font:(UIFont *)font range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSFontAttributeName;
	config.value     = font;
	config.range     = range;
	
	return config;
}

+ (instancetype)foregroundColor:(UIColor *)color range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSForegroundColorAttributeName;
	config.value     = color;
	config.range     = range;
	
	return config;
}

+ (instancetype)backgroundColor:(UIColor *)color range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSBackgroundColorAttributeName;
	config.value     = color;
	config.range     = range;
	
	return config;
}

+ (instancetype)strikethroughStyle:(NSInteger)number range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSStrikethroughStyleAttributeName;
	config.value     = [NSNumber numberWithInteger:number];
	config.range     = range;
	
	return config;
}

+ (instancetype)paragraphStyle:(NSMutableParagraphStyle *)style range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSParagraphStyleAttributeName;
	config.value     = style;
	config.range     = range;
	
	return config;
}

+ (instancetype)kern:(float)number range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSKernAttributeName;
	config.value     = [NSNumber numberWithFloat:number];
	config.range     = range;
	
	return config;
}

+ (instancetype)underlineStyle:(NSInteger)number range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSUnderlineStyleAttributeName;
	config.value     = [NSNumber numberWithInteger:number];
	config.range     = range;
	
	return config;
}

+ (instancetype)strokeColor:(UIColor *)color range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSStrokeColorAttributeName;
	config.value     = color;
	config.range     = range;
	
	return config;
}

+ (instancetype)strokeWidth:(float)number range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSStrokeWidthAttributeName;
	config.value     = [NSNumber numberWithFloat:number];
	config.range     = range;
	
	return config;
}

+ (instancetype)shadow:(NSShadow *)shadow range:(NSRange)range
{
	YIConfigAttributedString *config = [self new];
	config.attribute = NSShadowAttributeName;
	config.value     = shadow;
	config.range     = range;
	
	return config;
}

@end
