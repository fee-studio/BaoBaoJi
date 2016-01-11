//
//  YILoginViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/13.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YILoginViewController.h"
#import "YISignUpViewController.h"
#import "LCFamilyEntity.h"

@interface YILoginViewController ()

@property (nonatomic, weak) IBOutlet UIButton *loginBtn;
@property (nonatomic, weak) IBOutlet UIButton *signUpBtn;
@property (nonatomic, weak) IBOutlet UITextField *userNameTf;
@property (nonatomic, weak) IBOutlet UITextField *passwordTf;

@end

@implementation YILoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[self setupUI];
}

- (void)setupUI {
	[_loginBtn setBackgroundColor:[UIColor grassColor]];
	[_loginBtn cornerStyle];
	[_loginBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
	
	[_signUpBtn setBackgroundColor:[UIColor cantaloupeColor]];
	[_signUpBtn cornerStyle];
	[_signUpBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loginBtnAction:(id)sender {
	[LCUserEntity logInWithMobilePhoneNumberInBackground:_userNameTf.text
										  password:_passwordTf.text
											 block:^(AVUser *user, NSError *error) {
												 if (user) {
													 [LCUserEntity reloadCurrentUserData:^(NSError *error) {
														 if (error == nil) {
															 if (mGlobalData.user.babies.count) {
																 [mAppDelegate loadMainViewController2];
															 } else {
																 [mAppDelegate loadAddBabyViewController];
															 }
														 } else {
															 
														 }
													 }];
												 }
											 }];
}

- (IBAction)signUpBtnAction:(id)sender {
	YISignUpViewController *vc = [[YISignUpViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)forgetPasswordBtnAction:(id)sender {
	
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
