//
//  LCTimeLineModel.h
//  BaoBaoJi
//
//  Created by efeng on 11/24/15.
//  Copyright © 2015 buerguo. All rights reserved.
//

#import "AVObject.h"
#import "YIUserModel.h"

@interface LCTimelineModel : AVObject <AVSubclassing>

@property(nonatomic, strong) YIUserModel *author; // 作者
@property(nonatomic, strong) NSArray *shareImages; // 分享的照片
@property(nonatomic, strong) NSString *shareMsg; // 分享的内容
@property(nonatomic, assign) int recordObj; // 要记录的对象
@property(nonatomic, strong) NSDate *happenTime; // 图片内容发生的时间 // 默认为分享的时间
@property(nonatomic, assign) BOOL isDeleted; //是否删除

@end
