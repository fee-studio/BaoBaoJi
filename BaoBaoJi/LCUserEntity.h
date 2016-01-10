//
//  LCUserEntity.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/17.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "AVObject.h"
#import "LCBabyEntity.h"

@interface LCUserEntity : AVUser <AVSubclassing>

@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *babyRelation; // 与宝宝的关系 json 因为多个宝宝
@property (nonatomic, copy) NSDate *birthday;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, assign) BOOL isOnline; // 是否在线
@property (nonatomic, assign) int sex;
@property (nonatomic, strong) NSMutableArray *babies;
@property (nonatomic, strong) LCBabyEntity *curBaby;


+ (void)reloadCurrentUserData;

@end