//
//  LCBabyEntity.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/16.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "AVObject.h"
//#import "LCUserEntity.h"

@class LCUserEntity;

@interface LCBabyEntity : AVObject <AVSubclassing>

@property(nonatomic, strong) AVFile *avatar;
@property(nonatomic, strong) NSDate *birthday;
@property(nonatomic, assign) int blood;
@property(nonatomic, assign) int sex;
@property(nonatomic, assign) float height;
@property(nonatomic, assign) float weight;
@property(nonatomic, strong) NSString *nickName;
@property(nonatomic, strong) LCUserEntity *creator;
@property(nonatomic, strong) NSString *birthTime; // 出时时刻

@end
