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

@end

@implementation YIBabyIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
