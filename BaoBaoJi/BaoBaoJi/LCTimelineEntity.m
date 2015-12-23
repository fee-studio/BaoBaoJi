//
//  LCTimeLineModel.m
//  BaoBaoJi
//
//  Created by efeng on 11/24/15.
//  Copyright © 2015 buerguo. All rights reserved.
//

#import "LCTimelineEntity.h"

@implementation LCTimelineEntity

@dynamic author;
@dynamic sharedItem;
@dynamic sharedText;
@dynamic happenTime;
@dynamic isDeleted;
@dynamic baby;
@dynamic firstDo;
@dynamic location;


+ (NSString *)parseClassName {
    return NSStringFromClass([self class]);
}


@end
