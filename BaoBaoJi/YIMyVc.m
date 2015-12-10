//
//  YIMyVc.m
//  BaoBaoJi
//
//  Created by efeng on 15/9/11.
//  Copyright (c) 2015年 buerguo. All rights reserved.
//

#import "YIMyVc.h"
#import "YIUserModel.h"

@interface YIMyVc ()

@property (weak, nonatomic) IBOutlet UILabel *testLbl;
@property (weak, nonatomic) IBOutlet UIButton *testBtn;
- (IBAction)testBtnAction:(id)sender;

@end

@implementation YIMyVc

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
//    [YIUserModel logInWithUsernameInBackground:@"82kxrao8k2wtw30cw01rs6k2a" password:<#(NSString *)#> block:^(AVUser *user, NSError *error) {
        AVUser *user = [AVUser currentUser];
        _testLbl.text = [user objectId];
//    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testBtnAction:(id)sender {
    [YIAVOSUtil toLogin];
}


@end
