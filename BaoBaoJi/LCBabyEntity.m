//
//  LCBabyEntity.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/16.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "LCBabyEntity.h"

@implementation LCBabyEntity

@dynamic avatar;
@dynamic birthday;
@dynamic blood;
@dynamic sex;
@dynamic height;
@dynamic weight;
@dynamic nickName;
//@dynamic creator;
@dynamic birthTime;

+ (NSString *)parseClassName {
	return NSStringFromClass([self class]);
}

@end
