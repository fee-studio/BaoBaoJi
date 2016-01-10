//
//  YIBbjHeaderView.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/15.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YIBbjHeaderViewDelegate <NSObject>

- (void)babyInfoBtnDidSelected;

@end

@interface YIBbjHeaderView : UICollectionReusableView

@property (nonatomic, weak) id<YIBbjHeaderViewDelegate> delegate;

+ (UINib *)viewNib;
- (void)setupView;

@end
