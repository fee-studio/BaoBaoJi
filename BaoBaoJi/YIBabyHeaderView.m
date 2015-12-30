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

@end
