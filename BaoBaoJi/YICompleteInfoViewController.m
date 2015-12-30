//
//  YICompleteInfoViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/13.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YICompleteInfoViewController.h"

#import "YIBabyIndexViewController.h"


@interface YICompleteInfoViewController ()

@property (nonatomic, weak) IBOutlet UITextField *userName;
@property (nonatomic, weak) IBOutlet UITextField *password;
@property (nonatomic, weak) IBOutlet UITextField *rePassword;
@property (nonatomic, weak) IBOutlet UITextField *nickName;

@property (nonatomic, weak) IBOutlet UIButton *nickNameBtn;


@end

@implementation YICompleteInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"完善信息";
	[self setupUI];
	
	LCUserEntity *user = [LCUserEntity currentUser];
	_userName.text = user.username;
	
	
	UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
																 style:UIBarButtonItemStylePlain
																target:self
																action:@selector(backItemAction)];
	self.navigationItem.leftBarButtonItem = backItem;
}

- (void)backItemAction {
	[self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)setupUI {
	[_nickNameBtn setBackgroundColor:[UIColor cantaloupeColor]];
	[_nickNameBtn cornerStyle];
	[_nickNameBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
}

- (IBAction)completeUserInfoBtnAction:(id)sender {
	LCUserEntity *user = [LCUserEntity currentUser];
	user.password = _password.text;
	user.nickName = _nickName.text;
	[user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
		if (succeeded) {
			NSLog(@"完善用户成功");
			YIBabyIndexViewController *vc = [[YIBabyIndexViewController alloc]init];
			[self.navigationController pushViewController:vc animated:YES];
		} else {
			[TSMessage showNotificationWithTitle:[error userInfo][@"error"] type:TSMessageNotificationTypeError];
		}
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
