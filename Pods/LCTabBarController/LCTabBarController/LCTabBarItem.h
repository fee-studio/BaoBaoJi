//
//  LCTabBarItem.h
//  LCTabBarControllerDemo
//
//  Created by Leo on 15/12/2.
//  Copyright © 2015年 Leo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCTabBarItem : UIButton

@property (nonatomic, strong) UITabBarItem *tabBarItem;

@property (nonatomic, assign) NSInteger tabBarItemCount;

/**
 *  tabbar item title color
 */
@property (nonatomic, strong) UIColor *itemTitleColor;

/**
 *  tabbar selected item title color
 */
@property (nonatomic, strong) UIColor *selectedItemTitleColor;

/**
 *  tabbar item title font
 */
@property (nonatomic, strong) UIFont *itemTitleFont;

/**
 *  tabbar item's badge title font
 */
@property (nonatomic, strong) UIFont *badgeTitleFont;

/**
 *  tabbar item image ratio
 */
@property (nonatomic, assign) CGFloat itemImageRatio;

- (instancetype)initWithItemImageRatio:(CGFloat)itemImageRatio;

@end
