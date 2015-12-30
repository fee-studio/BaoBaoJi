//
//  LCFamilyEntity.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/26.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "LCFamilyEntity.h"

@implementation LCFamilyEntity

@dynamic type;
@dynamic typeText;

@dynamic baby;
@dynamic user;


+ (NSString *)parseClassName {
	return NSStringFromClass([self class]);
}


@end
