//
//  YIBabyHeaderView.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/25.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBabyHeaderView.h"

@implementation YIBabyHeaderView

- (void)awakeFromNib {
	self.avatarIv.userInteractionEnabled = YES;
	UITapGestureRecognizer *avatarTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAvatarImageAction:)];
	[self.avatarIv addGestureRecognizer:avatarTap];
	
	self.coverIv.userInteractionEnabled = YES;
	UITapGestureRecognizer *coverTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoverImageAction:)];
	[self.coverIv addGestureRecognizer:coverTap];

}

+ (UINib *)viewNib {
	return [UINib nibWithNibName:NSStringFromClass([self class])
						  bundle:[NSBundle mainBundle]];
}

- (void)setupView:(NSDictionary *)data; {
	self.avatarIv.image = data[@"avatar"];
	self.coverIv.image = data[@"cover"];
	self.hintLbl.text = data[@"hint"];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.avatarIv.layer.borderColor = [[UIColor whiteColor] CGColor];
	self.avatarIv.layer.cornerRadius = self.avatarIv.width / 2.f;
	self.avatarIv.layer.borderWidth = 3.f;
	self.avatarIv.layer.masksToBounds = YES;
}

- (void)tapAvatarImageAction:(UITapGestureRecognizer *)tap {
	if ([_delegate respondsToSelector:@selector(resetBabyAvatarImage)]) {
		[_delegate resetBabyAvatarImage];
	}
}

- (void)tapCoverImageAction:(UITapGestureRecognizer *)tap {
	if ([_delegate respondsToSelector:@selector(resetBabyCoverImage)]) {
		[_delegate resetBabyCoverImage];
	}
}

@end
