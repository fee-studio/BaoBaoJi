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
    
}


+ (UINib *)viewNib {
	return [UINib nibWithNibName:NSStringFromClass([self class])
						  bundle:[NSBundle mainBundle]];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	self.avatarIv.layer.borderColor = [[UIColor whiteColor] CGColor];
	self.avatarIv.layer.cornerRadius = self.avatarIv.width / 2.f;
	self.avatarIv.layer.borderWidth = 3.f;
	self.avatarIv.layer.masksToBounds = YES;
}

@end
