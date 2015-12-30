//
//  YIRecordTimeViewController.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/8.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBaseTableViewController.h"

@protocol YIRecordTimeViewControllerDelegate <NSObject>

- (void)selectedDate:(NSDate *)date;

@end

@interface YIRecordTimeViewController : YIBaseTableViewController

@property (nonatomic, strong) NSDate *photoDate;
@property (nonatomic, strong) NSDate *curDate;

@end
