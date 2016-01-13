//
//  YIModuleItemView.h
//  BaoBaoJi
//
//  Created by efeng on 11/24/15.
//  Copyright © 2015 buerguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LCTimelineEntity.h"


@interface YIModuleItemView : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subTitle;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) UIView *customView;
@property (nonatomic, strong) NSArray *images;

+ (instancetype)viewWithTitle:(NSString *)title content:(NSString *)content customView:(UIView *)customView;
+ (instancetype)viewWithTitle:(NSString *)title subTitle:(NSString *)subTitle content:(NSString *)content images:(NSArray *)images;

- (instancetype)initWithTitle:(NSString *)title
                     subTitle:(NSString *)subTitle
                      content:(NSString *)content
                   customView:(UIView *)customView
                       images:(NSArray *)images;




@property (nonatomic, strong) LCTimelineEntity *timeline;

+ (instancetype)viewWithTimeline:(LCTimelineEntity *)timeline;

@end
