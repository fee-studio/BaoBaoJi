//
//  LCItemEntity.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/17.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "LCItemEntity.h"

@implementation LCItemEntity

@dynamic type;
@dynamic data;

+ (NSString *)parseClassName {
	return NSStringFromClass([self class]);
}


@end
