//
//  LCFamilyEntity.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/26.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "AVObject.h"

@interface LCFamilyEntity : AVObject <AVSubclassing>

/**
 * type & typeText
 * 0    未知
 * 1    爸爸
 * 2    妈妈
 * 3    其他
 */


@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *typeText;

@property (nonatomic, strong) LCBabyEntity *baby;
@property (nonatomic, strong) LCUserEntity *user;

@end
