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


@interface YIBbjCell : YIBaseCollectionViewCell {
	int numbersOfLine;
}

@property (nonatomic, assign) int numbersOfLine; // 一行的图片的个数

@property (nonatomic, weak) id<YIBbjCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)setupCell:(LCTimelineEntity *)timeline;

@end
