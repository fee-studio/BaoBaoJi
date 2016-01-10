//
//  YIBabyListCell.m
//  BaoBaoJi
//
//  Created by efeng on 16/1/6.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIBabyListCell.h"

@interface YIBabyListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarIv;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;


@end

@implementation YIBabyListCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupCell:(LCBabyEntity *)baby; {	
	NSURL *avatarUrl = [NSURL URLWithString:baby.avatar.url];
	[_avatarIv sd_setImageWithURL:avatarUrl placeholderImage:kAppPlaceHolderImage];
	
	_titleLbl.text = baby.nickName;
	_infoLbl.text = @"这里要随便写点什么";
}

@end
