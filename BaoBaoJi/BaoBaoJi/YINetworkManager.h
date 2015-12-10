//
//  YINetworkManager.h
//  Dobby
//
//  Created by efeng on 15/6/27.
//  Copyright (c) 2015年 weiboyi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YIBaseRequest.h"

@interface YINetworkManager : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;

+ (YINetworkManager *)instance;

- (NSURLSessionDataTask *)doRequest:(YIBaseRequest *)request
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure;

+ (void)startMonitoring;
@end
