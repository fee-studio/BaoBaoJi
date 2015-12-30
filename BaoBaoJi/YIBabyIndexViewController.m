//
//  YIBabyIndexViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/13.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBabyIndexViewController.h"
#import "YIBabyInfoViewController.h"


@interface YIBabyIndexViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *bgIv;
@property (weak, nonatomic) IBOutlet UITextView *summaryTv;
@property (weak, nonatomic) IBOutlet UIButton *createBabyZoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *inviteOtherFamilyBtn;


@end

@implementation YIBabyIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	[self.view bringSubviewToFront:_summaryTv];
	[self.view bringSubviewToFront:_createBabyZoneBtn];
	[self.view bringSubviewToFront:_inviteOtherFamilyBtn];
	
	_summaryTv.text = @"开启专属于宝宝的亲子空间\r\n把家人手机中的照片放在一起\r\n随时记录宝宝各种萌态\r\n与远方亲人分享宝宝视频\r\n手机丢了也不怕,珍贵照片一张不少";
	_summaryTv.backgroundColor = [UIColor clearColor];
	
	[_createBabyZoneBtn greenStyle];
	[_inviteOtherFamilyBtn greenStyle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)createBabyZoneBtnAction:(id)sender {
	YIBabyInfoViewController *vc = [[YIBabyInfoViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)inviteOtherFamilyBtnAction:(id)sender {
	
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
