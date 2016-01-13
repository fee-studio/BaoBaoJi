//
//  YIBbjCell.h
//  BaoBaoJi
//
//  Created by efeng on 15/11/9.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YIBaseCollectionViewCell.h"
#import "YITimelineModel.h"
#import "LCTimelineEntity.h"

@protocol YIBbjCellDelegate <NSObject>

- (void)tapPhotoAtIndex:(NSUInteger)index allPhotos:(NSArray *)photos tappedView:(UIView *)view;

@end


@interface YIBbjCell : YIBaseCollectionViewCell

@property (nonatomic, weak) id<YIBbjCellDelegate> delegate;

@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

//- (void)setupCell:(YITimelineModel *)timeline;
- (void)setupCell:(LCTimelineEntity *)timeline;

@end
