//
//  YIVerifyMobileViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/13.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIVerifyMobileViewController.h"
#import "YICompleteInfoViewController.h"
#import "YIValidateUtil.h"

@interface YIVerifyMobileViewController ()

@property (nonatomic, weak) IBOutlet UITextField *captchaTf;
@property (nonatomic, weak) IBOutlet UILabel *hintLbl;
@property (nonatomic, weak) IBOutlet UIButton *verifyBtn;
@property (nonatomic, weak) IBOutlet UIButton *requestCaptchaBtn;
@end

@implementation YIVerifyMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"验证手机";
	[self setupUI];
	
	_hintLbl.text = [NSString stringWithFormat:@"验证码短信已经发送到 +86 %@",_mobileNumber];
	
}

- (void)setupUI {
	_hintLbl.backgroundColor =[UIColor clearColor];
	
	[_verifyBtn setBackgroundColor:[UIColor cantaloupeColor]];
	[_verifyBtn cornerStyle];
	[_verifyBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
	
	[_requestCaptchaBtn setBackgroundColor:[UIColor grassColor]];
	[_requestCaptchaBtn cornerStyle];
	[_requestCaptchaBtn setTitleColor:kAppWhiteColor forState:UIControlStateNormal];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self showCountDownTime];
}

- (void)showCountDownTime {
	// 倒计时Label
	UILabel *_lblTimerExample13 = [[UILabel alloc] init];
	_lblTimerExample13.backgroundColor = [UIColor grassColor];
	_lblTimerExample13.font = kAppMidFont;
	_lblTimerExample13.textColor = [UIColor whiteColor];
	_lblTimerExample13.textAlignment = NSTextAlignmentCenter;
	_lblTimerExample13.userInteractionEnabled = YES;
	[_requestCaptchaBtn addSubview:_lblTimerExample13];
	
	MZTimerLabel *timerExample13 = [[MZTimerLabel alloc] initWithLabel:_lblTimerExample13 andTimerType:MZTimerLabelTypeTimer];
	timerExample13.timerType = MZTimerLabelTypeTimer;
	[timerExample13 setCountDownTime:60];
	NSString *text = @"time秒后重新获取";
	NSRange r = [text rangeOfString:@"time"];
	timerExample13.text = text;
	timerExample13.textRange = r;
	timerExample13.timeFormat = @"ss";
	timerExample13.resetTimerAfterFinish = NO;
	[timerExample13 startWithEndingBlock:^(NSTimeInterval countTime) {
		[_lblTimerExample13 removeFromSuperview];
	}];
	
	[_lblTimerExample13 mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(_requestCaptchaBtn);
	}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)requestCaptchaBtnAction:(id)sender {
	[self showCountDownTime];
	[AVOSCloud requestSmsCodeWithPhoneNumber:_mobileNumber callback:^(BOOL succeeded, NSError *error) {
		if (succeeded) {
			[TSMessage showNotificationWithTitle:@"验证码已经发送,请注意查收!" type:TSMessageNotificationTypeSuccess];
		}
	}];
}

- (IBAction)verifyMobileBtnAction:(id)sender {
	[LCUserEntity signUpOrLoginWithMobilePhoneNumberInBackground:_mobileNumber smsCode:_captchaTf.text block:^(AVUser *user, NSError *error) {
		if (user) {
			YICompleteInfoViewController *vc = [[YICompleteInfoViewController alloc] init];
			[self.navigationController pushViewController:vc animated:YES];
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
