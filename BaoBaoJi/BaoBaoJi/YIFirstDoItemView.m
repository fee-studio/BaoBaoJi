//
//  YIFirstDoItemView.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/7.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIFirstDoItemView.h"

@interface YIFirstDoItemView()

@property (nonatomic, copy) NSArray *firstDoItems;

@end

@implementation YIFirstDoItemView



- (void)setupItemBtn:(NSArray *)items {
	self.firstDoItems = items;
	
	__block UIView *lastView = nil;
	
	for (UIView *view in self.subviews) {
		[view removeFromSuperview];
	}
	
	[items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {		
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setTag:[[obj objectForKey:@"ftid"] integerValue]];
		[button setTitle:[obj objectForKey:@"present"] forState:UIControlStateNormal];
		[button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		[button setImage:[UIImage imageNamed:[obj objectForKey:@"icon"]] forState:UIControlStateNormal];
		
		UIImage *resizableImage = [[UIImage imageNamed:@"ic_ft_selected_bg"] resizableWithMarginValue:30.f];
		[button setBackgroundImage:resizableImage forState:UIControlStateHighlighted];
		[button setBackgroundImage:resizableImage forState:UIControlStateSelected];
		[button addTarget:self action:@selector(selectFirstDoThingAction:) forControlEvents:UIControlEventTouchUpInside];
		
		[self addSubview:button];
		
		[button mas_makeConstraints:^(MASConstraintMaker *make) {
			if (idx % 3 == 0) { // 第一个
				make.top.equalTo(lastView ? lastView.mas_bottom : self).with.offset(5);
				make.left.equalTo(self).with.offset(5);
				if (lastView) {
					make.width.equalTo(lastView);
					make.height.equalTo(lastView);
				}
				if (idx / 3 == (3-1)) {
					make.bottom.equalTo(self).with.offset(-5);
				}
			} else if (idx % 3 == (3-1)) { // 第三个
				make.top.equalTo(lastView ? lastView.mas_top : self);
				make.left.equalTo(lastView ? lastView.mas_right : self);
				make.right.equalTo(self).with.offset(-5);
				if (lastView) {
					make.width.equalTo(lastView);
					make.height.equalTo(lastView);
				}
			} else {  // 第二个
				make.top.equalTo(lastView ? lastView.mas_top : self);
				make.left.equalTo(lastView ? lastView.mas_right : self);
				if (lastView) {
					make.width.equalTo(lastView);
					make.height.equalTo(lastView);
				}
			}
		}];
		
		lastView = button;
	}];	
}

- (void)selectFirstDoThingAction:(UIButton *)btn {
	for (UIView *view in self.subviews) {
		if ([view isKindOfClass:[UIButton class]]
			&& ![view isEqual:btn]) {
			[((UIButton *)view) setSelected:NO];
		}
	}
	
	btn.selected = !btn.selected;
	
	if ([_delegate respondsToSelector:@selector(firstDoThingSelectedIndex:text:item:) ]) {
		[_delegate firstDoThingSelectedIndex:btn.tag text:btn.titleLabel.text item:_firstDoItems[btn.tag]];
	}
}


@end
