//
//  YIGlobalData.m
//  Dobby
//
//  Created by efeng on 14-6-4.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//
//  常用的全局数据放这里.


static YIGlobalData *sharedGlobalData = nil;


@implementation YIGlobalData

+ (YIGlobalData *)sharedInstance {
    @synchronized (sharedGlobalData) {
        if (!sharedGlobalData) {
            sharedGlobalData = [[self alloc] init];
        }
        return sharedGlobalData;
    }
}

- (id)init {
    self = [super init];
    if (self) {
//        _flight = @"0";
    }
    return self;
}

- (void)loadDefaultValue {
	_user = [LCUserEntity currentUser];
	
	
    _login = [mUserDefaults boolForKey:kLogin];
//    _deviceToken = [mUserDefaults stringForKey:kDeviceToken];
    _isLaunched = [mUserDefaults boolForKey:kLaunched];
    _debugOn = [mUserDefaults boolForKey:kDebugOn];
    _isShowFeature = [mUserDefaults boolForKey:kShowFeature];
//    _savedVersionCode = [mUserDefaults stringForKey:kSavedVersionCode];
}

- (void)setLogin:(BOOL)isLogin {
    _login = isLogin;
    [mUserDefaults setBool:_login forKey:kLogin];
    [mUserDefaults synchronize];
}

//- (void)setDeviceToken:(NSString *)aDeviceToken {
//    _deviceToken = aDeviceToken;
//    [mUserDefaults setValue:_deviceToken forKey:kDeviceToken];
//    [mUserDefaults synchronize];
//}
//
//- (void)setSavedVersionCode:(NSString *)savedVersionCode {
//    _savedVersionCode = savedVersionCode;
//    [mUserDefaults setValue:_savedVersionCode forKey:kSavedVersionCode];
//    [mUserDefaults synchronize];
//}

- (void)setIsLaunched:(BOOL)isLaunched {
    _isLaunched = isLaunched;
    [mUserDefaults setBool:_isLaunched forKey:kLaunched];
    [mUserDefaults synchronize];
}

- (void)setDebugOn:(BOOL)debugOn {
    _debugOn = debugOn;
    [mUserDefaults setBool:_debugOn forKey:kDebugOn];
    [mUserDefaults synchronize];
}

- (void)setIsShowFeature:(BOOL)isShowFeature {
    _isShowFeature = isShowFeature;
    [mUserDefaults setBool:_isShowFeature forKey:kShowFeature];
    [mUserDefaults synchronize];
}

@end
