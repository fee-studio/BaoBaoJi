//
//  YIFirstDoItemView.h
//  BaoBaoJi
//
//  Created by efeng on 15/12/7.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YIFirstDoItemViewDelegate <NSObject>

- (void)firstDoThingSelectedIndex:(NSUInteger)index text:(NSString *)text item:(NSDictionary *)item;

@end

@interface YIFirstDoItemView : UIView



@property(nonatomic, weak) id <YIFirstDoItemViewDelegate> delegate;

- (void)setupItemBtn:(NSArray *)items;


@end
