//
//  YILocationViewController.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/10.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBaseTableViewController.h"
#import "LCLocationEntity.h"

@protocol YILocationViewControllerDelegate <NSObject>

- (void)selectedLocation:(LCLocationEntity *)location indexPath:(NSIndexPath *)indexPath;

@end

@interface YILocationViewController : YIBaseTableViewController

@property (nonatomic, weak) id<YILocationViewControllerDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

@end
