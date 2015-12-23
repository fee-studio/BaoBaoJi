//
//  LCLocationEntity.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/17.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "AVObject.h"

@interface LCLocationEntity : AVObject <AVSubclassing>

@property (nonatomic, strong) NSString *address;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) double latitude;
@property (nonatomic, assign) double longitude;
@end
