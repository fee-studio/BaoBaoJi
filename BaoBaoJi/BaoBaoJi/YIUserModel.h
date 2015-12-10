//
// Created by efeng on 15/9/5.
// Copyright (c) 2015 buerguo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVUser.h"

@interface YIUserModel : AVUser<AVSubclassing>

@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *avatarUrl;
@property (nonatomic, assign) int sex;
@property (nonatomic, assign) int role; // 爸爸 妈妈 儿子 女儿

@end


@interface YIFamilyModel : AVObject<AVSubclassing>

@property (nonatomic, strong) YIUserModel *user;

//@property (nonatomic, copy) NSString *userId;


@end