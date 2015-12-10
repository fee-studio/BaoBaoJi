//
//  YITimelineModel.h
//  BaoBaoJi
//
//  Created by efeng on 15/11/4.
//  Copyright © 2015年 buerguo. All rights reserved.
//

//#import "YIBaseModel.h"

@interface YITimelineModel : NSObject

@property(nonatomic, strong) NSArray *shareImages;
@property(nonatomic, copy) NSString *shareMsg;
@property(nonatomic, assign) int recordObj; // 要记录的对象
@property(nonatomic, strong) NSDate *shareTime; // 分享时的时间
@property(nonatomic, strong) NSDate *happenTime; // 图片内容发生的时间
@property(nonatomic, copy) NSString *userName; // 用户名
@property(nonatomic, strong) NSURL *avatarUrl; // 头像链接


@end
