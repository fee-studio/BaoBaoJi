//
//  YIFirstDoItemView.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/7.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIFirstDoItemView.h"

@implementation YIFirstDoItemView



- (void)setupItemBtn:(NSArray *)items {
	__block UIView *lastView = nil;
	/*
	for (NSDictionary *item in items) {
		UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setTitle:[item objectForKey:@"present"] forState:UIControlStateNormal];
		[button setBackgroundColor:[UIColor redColor]];
		[self addSubview:button];
		[button mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(lastView ? lastView.mas_bottom : self);
			make.left.equalTo(lastView ? lastView.mas_right : self);
			make.width.equalTo(lastView ? lastView : @0);
			make.height.equalTo(lastView ? lastView : @0);
		}];
		lastView= button;
	}
	 */
	
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
	
	if ([_delegate respondsToSelector:@selector(firstDoThingSelectedIndex:text:) ]) {
		[_delegate firstDoThingSelectedIndex:btn.tag text:btn.titleLabel.text];
	}
}


@end
