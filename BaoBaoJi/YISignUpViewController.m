//
//  YISignUpViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/13.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YISignUpViewController.h"
#import "YIValidateUtil.h"
#import "YIVerifyMobileViewController.h"

@interface YISignUpViewController ()

@property (nonatomic, weak) IBOutlet UIButton *countryBtn;
@property (nonatomic, weak) IBOutlet UITextField *mobileTf;
@property (nonatomic, weak) IBOutlet UIButton *signUpBtn;

@end

@implementation YISignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self setupUI];
}

- (void)setupUI {	
	[_countryBtn borderAndCornerStyle];
	
	[_signUpBtn setBackgroundColor:[UIColor cantaloupeColor]];
	[_signUpBtn cornerStyle];
	[_signUpBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)signUpBtnAction:(id)sender {
	if (!_mobileTf.text.isOK || ![YIValidateUtil validatePhone:_mobileTf.text]) {
		[TSMessage showNotificationWithTitle:@"请输入正确的手机号" type:TSMessageNotificationTypeError];
		return;
	}	
	/*
	AVUser *user = [AVUser user];
//	user.username = @"hjiang";
//	user.password =  @"f32@ds*@&dsa";
//	user.email = @"hang@leancloud.rocks";
	user.mobilePhoneNumber = _mobileTf.text;
	NSError *error = nil;
	[user signUp:&error];
	 */
	
	
	

	
//	AVUser *user = [AVUser user];
//	user.username = @"fengg";
//	user.password =  @"f32@ds*@&dsa";
////	user.email = @"hang@leancloud.rocks";
//	user.mobilePhoneNumber = _mobileTf.text;
//	[user setObject:@"186-1234-0000" forKey:@"phone"];
//	
//	[user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//		if (succeeded) {
//			
//			[AVUser requestMobilePhoneVerify:_mobileTf.text withBlock:^(BOOL succeeded, NSError *error) {
//				if (succeeded) {
//					
//					NSLog(@"succeeded = %d", succeeded);
//					
//				}
//			}];
//
//		} else {
//			
//		}
//	}];
	
	// 需要 启用账号无关短信验证服务
	[AVOSCloud requestSmsCodeWithPhoneNumber:_mobileTf.text callback:^(BOOL succeeded, NSError *error) {
		if (succeeded) {
			[TSMessage showNotificationWithTitle:@"验证码已经发送,请注意查收!" type:TSMessageNotificationTypeSuccess];
			
			YIVerifyMobileViewController *vc = [[YIVerifyMobileViewController alloc] init];
			vc.mobileNumber = _mobileTf.text;
			[self.navigationController pushViewController:vc animated:YES];
		} else {
			NSString *errorMsg = [error userInfo][@"error"];
			[TSMessage showNotificationWithTitle:errorMsg type:TSMessageNotificationTypeError];
		}
	}];
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
