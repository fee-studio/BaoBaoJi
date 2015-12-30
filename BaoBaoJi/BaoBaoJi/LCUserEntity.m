//
//  LCUserEntity.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/17.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "LCUserEntity.h"

@implementation LCUserEntity

@dynamic area;
@dynamic babyRelation;
@dynamic birthday;
@dynamic nickName;
@dynamic avatar;
@dynamic isOnline;
@dynamic sex;
@dynamic babies;
//@dynamic curBaby;


+ (NSString *)parseClassName {
	return @"_User";
}


@end
