//
//  YIBabyHeaderView.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/25.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YIBabyHeaderViewDelegate <NSObject>

- (void)resetBabyCoverImage;
- (void)resetBabyAvatarImage;

@end


@interface YIBabyHeaderView : UICollectionReusableView

@property (nonatomic, weak) id<YIBabyHeaderViewDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *avatarIv;
@property (weak, nonatomic) IBOutlet UIImageView *coverIv;
@property (weak, nonatomic) IBOutlet UILabel *hintLbl;


+ (UINib *)viewNib;

- (void)setupView:(NSDictionary *)data;

@end
