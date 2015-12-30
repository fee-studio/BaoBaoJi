//
//  LCTimeLineModel.h
//  BaoBaoJi
//
//  Created by efeng on 11/24/15.
//  Copyright © 2015 buerguo. All rights reserved.
//

#import "AVObject.h"

#import "LCBabyEntity.h"
#import "LCFirstDoEntity.h"
#import "LCLocationEntity.h"
#import "LCItemEntity.h"

@interface LCTimelineEntity : AVObject <AVSubclassing>

@property(nonatomic, strong) NSDate *happenTime; // 图片内容发生的时间 // 默认为分享的时间
@property(nonatomic, assign) BOOL isDeleted; //是否删除
@property(nonatomic, strong) NSString *sharedText; // 分享的内容

@property(nonatomic, strong) LCUserEntity *author; // 作者
@property(nonatomic, strong) LCBabyEntity *baby; // 宝宝

/*
 <dict>
 <key>des</key>
 <string>str_ft_cry</string>
 <key>ftid</key>
 <integer>4</integer>
 <key>icon</key>
 <string>ic_ft_cry</string>
 <key>present</key>
 <string>哭</string>
 </dict>
 */
@property(nonatomic, strong) NSDictionary *firstDo; // 第一次
@property(nonatomic, strong) LCLocationEntity *location; //地理位置
@property(nonatomic, strong) LCItemEntity *sharedItem; // 发布的文件如: 照片/音频/视频


@end
