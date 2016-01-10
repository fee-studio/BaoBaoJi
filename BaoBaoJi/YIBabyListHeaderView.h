//
//  YIBabyListHeaderView.h
//  BaoBaoJi
//
//  Created by efeng on 16/1/6.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YIBabyListHeaderViewDelegate <NSObject>

- (void)selectedAddBabyAction;
- (void)selectedInputInviteCodeAction;

@end

@interface YIBabyListHeaderView : UIView

@property (nonatomic, weak) id<YIBabyListHeaderViewDelegate> delegate;

@end
