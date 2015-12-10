//
//  YINetworkManager.m
//  Dobby
//
//  Created by efeng on 15/6/27.
//  Copyright (c) 2015年 weiboyi. All rights reserved.
//

#import "YINetworkManager.h"

@implementation YINetworkManager {
    
}

+ (YINetworkManager *)instance {
    static YINetworkManager *_instance = nil;

    @synchronized (self) {
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    }

    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer = [AFHTTPRequestSerializer serializer];
        _manager.responseSerializer = [AFJSONResponseSerializer serializer];
    }

    return self;
}

- (NSURLSessionDataTask *)doRequest:(YIBaseRequest *)request
                            success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                            failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {

    if (_manager.reachabilityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        NSError *error = [NSError networkNotReachableError];
        [error toHandle];
        failure(nil, error);
    }

    NSURLSessionDataTask *task = nil;
    if ([request requestMethod] == RequestMethodGET) {
        task = [_manager GET:[request requestUrlString]
                  parameters:request.allParameters
                     success:^(NSURLSessionDataTask *task, id responseObject) {
                         success(task, responseObject);
                     }
                     failure:^(NSURLSessionDataTask *task, NSError *error) {
                         // 返回后 不再做错误的处理,只做其他处理,比如:隐藏加载框..
                         NSError *failureError = [NSError networkNotReachableError];
                         [failureError toHandle];
                         failure(task, failureError);
                     }];
    } else {
        task = [_manager POST:[request requestUrlString]
                   parameters:request.allParameters
                      success:^(NSURLSessionDataTask *task, id responseObject) {
                          success(task, responseObject);
                      }
                      failure:^(NSURLSessionDataTask *task, NSError *error) {
                          // 返回后 不再做错误的处理,只做其他处理,比如:隐藏加载框..
                          NSError *failureError = [NSError networkNotReachableError];
                          [failureError toHandle];
                          failure(task, failureError);
                      }];
    }

    /*
    NSOperationQueue *operationQueue = _manager.operationQueue;
    [_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                mGlobalData.netType = @"wwan";
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                mGlobalData.netType = @"wifi";
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:[YINetworkManager instance]
                [operationQueue setSuspended:YES];
                [operationQueue cancelAllOperations];
                break;
        }
        NSLog(@"网络环境改变: status = %ld", (long) status);
    }];
    [_manager.reachabilityManager startMonitoring];

    NSLog(@"operationQueue = %@", operationQueue);
    NSLog(@"operationQueue.operations.count = %lu", (unsigned long) operationQueue.operations.count);
     */
    return task;
}

+ (void)startMonitoring {
    [[YINetworkManager instance].manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                mGlobalData.netType = @"wwan";
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi:{
                mGlobalData.netType = @"wifi";
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:
            default:{
            }
                break;
        }
        NSLog(@"网络环境改变: status = %ld", (long) status);
    }];
    [[YINetworkManager instance].manager.reachabilityManager startMonitoring];

}


@end
