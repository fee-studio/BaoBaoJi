//
//  LCItemEntity.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/17.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "AVObject.h"

@interface LCItemEntity : AVObject <AVSubclassing>

/**
 type含义
 1 照片
 2 音频
 3 视频
 */
@property (nonatomic, assign) int type;
@property (nonatomic, strong) id data;


@end
