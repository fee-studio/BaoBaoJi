//
//  LCFirstDoEntity.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/17.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "AVObject.h"

@interface LCFirstDoEntity : AVObject <AVSubclassing>

@property (nonatomic, assign) int itemCode;
@property (nonatomic, strong) NSString *itemText;

@end
