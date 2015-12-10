//
// Created by efeng on 15/9/11.
// Copyright (c) 2015 buerguo. All rights reserved.
//

#import "YIAVOSUtil.h"
#import "AVOSCloudSNS.h"
#import "YIUserModel.h"

@implementation YIAVOSUtil


+ (void)toLogin; {
    [AVOSCloudSNS setupPlatform:AVOSCloudSNSWeiXin
                     withAppKey:WX_APP_ID
                   andAppSecret:WX_APP_SECRET
                 andRedirectURI:@""];

    [AVOSCloudSNS loginWithCallback:^(id object, NSError *error) {
        if (error) {
            
        } else {
            // todo ...登录后的优化
            NSString *accessToken = object[@"access_token"];
            NSString *username = object[@"username"];
            NSString *avatar = object[@"avatar"];
            NSDictionary *rawUser = object[@"raw-user"]; // 性别等第三方平台返回的用户信息
            
            [YIUserModel loginWithAuthData:object
                             platform:@"weixin"
                                block:^(AVUser *user, NSError *error) {
                                    YIUserModel *userModel = (YIUserModel *)user;
                                    userModel.username = username;
                                    userModel.nickName = rawUser[@"nickname"];
                                    userModel.avatarUrl = rawUser[@"headimgurl"];
                                    userModel.sex = [rawUser[@"sex"] intValue];
                                    [userModel saveInBackground];
                                    
                                    YIFamilyModel *family = [YIFamilyModel object];
//                                    family.userId = userModel.objectId;
                                    family.user = userModel;
                                    [family saveInBackground];
            }];
        }
    } toPlatform:AVOSCloudSNSWeiXin];
}




@end