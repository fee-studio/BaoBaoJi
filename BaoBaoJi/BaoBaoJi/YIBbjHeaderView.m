//
//  YIBbjHeaderView.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/15.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBbjHeaderView.h"

int ITEM_SPACING = 10;

@interface YIBbjHeaderView()

@property (nonatomic, weak) IBOutlet UIImageView *headerIv;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

@end

@implementation YIBbjHeaderView


+ (UINib *)viewNib {
	return [UINib nibWithNibName:NSStringFromClass([self class])
						  bundle:[NSBundle mainBundle]];
}


- (void)setupView {
	_headerIv.image = [UIImage imageNamed:@"ic_lib_tags_bg.jpg"];
	_scrollView.backgroundColor = [UIColor linenColor];
	_scrollView.showsHorizontalScrollIndicator = NO;
	_scrollView.showsVerticalScrollIndicator = NO;
	
	[self _addItemView];
}

- (void)_addItemView {
	NSArray *items = @[@{@"title" : @"疫苗\n接种", @"action" : @"_babyInfoBtnAction"},
					   @{@"title" : @"宝宝\n大记事", @"action" : @"_babyInfoBtnAction"},
					   @{@"title" : @"宝宝\n信息", @"action" : @"_babyInfoBtnAction"}];
	
	__block UIView *lastView = nil;
	[items enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		UIButton *itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		[itemBtn setTitle:obj[@"title"] forState:UIControlStateNormal];
		[itemBtn setTitleColor:kAppTextDeepColor forState:UIControlStateNormal];
		itemBtn.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
		itemBtn.titleLabel.font = kAppSmlFont;
		itemBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
		if (idx % 2) {
			[itemBtn setBackgroundImage:[UIImage imageNamed:@"ic_timeline_button_bg"] forState:UIControlStateNormal];
		} else {
			[itemBtn setBackgroundImage:[UIImage imageNamed:@"ic_timeline_button_bg2"] forState:UIControlStateNormal];
		}
		SEL action = NSSelectorFromString(obj[@"action"]);
		if ([self respondsToSelector:action]) {
			[itemBtn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
		}
		[_scrollView addSubview:itemBtn];
		[itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
			make.top.equalTo(_scrollView);
			make.left.equalTo(lastView ? lastView.mas_right : _scrollView).with.offset(ITEM_SPACING);
			make.width.equalTo(@57);
			make.height.equalTo(@46);
		}];
		lastView = itemBtn;
	}];
	[_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(lastView).with.offset(ITEM_SPACING);
	}];
}

- (void)_babyInfoBtnAction {
	NSLog(@"_babyInfoBtnAction");
	if ([_delegate respondsToSelector:@selector(babyInfoBtnDidSelected)]) {
		[_delegate babyInfoBtnDidSelected];
	}
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
