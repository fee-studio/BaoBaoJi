//
//  LCTimeLineModel.m
//  BaoBaoJi
//
//  Created by efeng on 11/24/15.
//  Copyright © 2015 buerguo. All rights reserved.
//

#import "LCTimeLineModel.h"

@implementation LCTimelineModel

@dynamic author;
@dynamic shareImages;
@dynamic shareMsg;
@dynamic recordObj;
@dynamic happenTime;
@dynamic isDeleted;

+ (NSString *)parseClassName {
    return NSStringFromClass([self class]);
}


@end
