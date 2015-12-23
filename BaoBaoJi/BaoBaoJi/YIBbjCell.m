//
//  YIBbjCell.m
//  BaoBaoJi
//
//  Created by efeng on 15/11/9.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBbjCell.h"
#import "YITimelineModel.h"
#import "NSDate+Additional.h"
#import "YIModuleItemView.h"
#import "UIImageView+AFNetworking.h"

@interface YIBbjCell () {
    YIModuleItemView *miv;
}
//@property (nonatomic, strong) YIModuleItemView *miv;
@end

@implementation YIBbjCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (void)setupCell:(LCTimelineEntity *)timeline; {
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
	
	NSString *firstDoText = [NSString stringWithFormat:@"第一次%@",timeline.firstDo[@"present"]];
    miv = [YIModuleItemView viewWithTitle:timeline.sharedText
                                 subTitle:firstDoText
                                  content:timeline.location.name
                                   images:timeline.sharedItem.data];
    [self.contentView addSubview:miv];
	
    UIEdgeInsets padding = UIEdgeInsetsMake(10, 10, 10, 10);
    [miv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).with.insets(padding);
    }];
}

@end
