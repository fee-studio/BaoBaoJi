//
//  YIBabyHeaderCell.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/25.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBabyDetailCell.h"

@interface YIBabyDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailsLbl;
@property (weak, nonatomic) IBOutlet UIImageView *arrowIv;

@end

@implementation YIBabyDetailCell

- (void)awakeFromNib {
    
}

- (void)setupCell:(NSDictionary *)detail {
	self.backgroundColor = kAppWhiteColor;
	
	_titleLbl.text = detail[@"title"];
//	_contentLbl.text = detail[@"content"];
	_detailsLbl.text = detail[@"detail"];
	
	_arrowIv.image = [UIImage imageNamed:@"common_icon_arrow"];
}

@end
