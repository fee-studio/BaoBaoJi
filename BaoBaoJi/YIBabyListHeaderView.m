//
//  YIBabyListHeaderView.m
//  BaoBaoJi
//
//  Created by efeng on 16/1/6.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIBabyListHeaderView.h"

@interface YIBabyListHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *addBabyView;
@property (weak, nonatomic) IBOutlet UIView *inputInviteCodeView;

@end


@implementation YIBabyListHeaderView

- (void)awakeFromNib {
	[_addBabyView borderStyle];
	[_inputInviteCodeView borderStyle];
	
	_addBabyView.userInteractionEnabled = YES;
	UITapGestureRecognizer *tapAddBaby = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapAddBabyAction)];
	[_addBabyView addGestureRecognizer:tapAddBaby];
	
	_inputInviteCodeView.userInteractionEnabled = YES;
	UITapGestureRecognizer *tapInputInviteCode = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_tapInputInviteCodeAction)];
	[_inputInviteCodeView addGestureRecognizer:tapInputInviteCode];
}

- (void)_tapAddBabyAction {
	if ([_delegate respondsToSelector:@selector(selectedAddBabyAction)]) {
		[_delegate selectedAddBabyAction];
	}
}

- (void)_tapInputInviteCodeAction {
	if ([_delegate respondsToSelector:@selector(selectedInputInviteCodeAction)]) {
		[_delegate selectedInputInviteCodeAction];
	}
}


@end
