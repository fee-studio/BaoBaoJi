//
//  LCLocationEntity.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/17.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "LCLocationEntity.h"

@implementation LCLocationEntity

@dynamic address;
@dynamic name;
@dynamic latitude;
@dynamic longitude;

+ (NSString *)parseClassName {
	return NSStringFromClass([self class]);
}

@end
