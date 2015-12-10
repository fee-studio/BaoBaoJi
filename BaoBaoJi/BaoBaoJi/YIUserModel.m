//
// Created by efeng on 15/9/5.
// Copyright (c) 2015 buerguo. All rights reserved.
//

#import "YIUserModel.h"


@implementation YIUserModel

@dynamic nickName;
@dynamic userName;
@dynamic avatarUrl;
@dynamic sex;
@dynamic role;

+ (NSString *)parseClassName {
    return @"_User";
}


@end


@implementation YIFamilyModel

@dynamic user;
//@dynamic userId;

+ (NSString *)parseClassName {
    return NSStringFromClass([self class]);
}


@end