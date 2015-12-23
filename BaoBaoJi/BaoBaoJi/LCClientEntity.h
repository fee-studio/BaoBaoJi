//
//  YIBaseModel.h
//  Dobby
//
//  Created by efeng on 14-6-10.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AVObject+Subclass.h"
#import "AVSubclassing.h"

@interface LCClientEntity : AVObject <AVSubclassing> {

}

@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *appChannel;
@property (nonatomic, copy) NSString *osName;
@property (nonatomic, copy) NSString *osVersion;
@property (nonatomic, copy) NSString *deviceModel;
@property (nonatomic, copy) NSString *idfv;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *netType;
@property (nonatomic, copy) NSString *provider;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *longitude;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *resolutionWidth;
@property (nonatomic, copy) NSString *resolutionHeight;


///////////////////////////////////////////////////////
@property (nonatomic, strong) NSString *savedPath;

- (BOOL)saveData:(NSString *)filePath;
- (id)fetchData:(NSString *)filePath;
- (BOOL)clearData:(NSString *)filePath;
+ (void)clearAllCacheData;
///////////////////////////////////////////////////////

@end
