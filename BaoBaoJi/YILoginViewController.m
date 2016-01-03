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
													 mGlobalData.user = (LCUserEntity *)user;
													 
													 AVQuery *query = [LCFamilyEntity query];
													 [query whereKey:@"user" equalTo:user];
													 [query includeKey:@"baby"]; // vip 想查出baby 必须includeKey baby
													 [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
														 NSMutableArray *babies = [NSMutableArray array];
														 for(LCFamilyEntity *family in objects) {
															 LCBabyEntity *baby = family.baby;
															 [babies addObject:baby];
														 }
														 mGlobalData.user.babies = babies;
														 mGlobalData.user.curBaby = [babies lastObject];
														 [mGlobalData.user saveInBackground];
														 
														 if (mGlobalData.user.babies.count) {
															 [mAppDelegate loadMainViewController];
														 } else {
															 [mAppDelegate loadAddBabyViewController];
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
