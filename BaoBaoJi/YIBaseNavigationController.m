//
//  YIBaseNavigationController.m
//  Dobby
//
//  Created by efeng on 14-5-17.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//


@interface YIBaseNavigationController ()

@end

@implementation YIBaseNavigationController

#pragma mark 一个类只会调用一次

+ (void)initialize {

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.mm_drawerController.showsStatusBarBackgroundView) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationBar.tintColor = kAppMainColor;
    self.navigationBar.translucent = YES;
    self.navigationBar.alpha = 0.3f;
    self.navigationBar.barTintColor = [UIColor colorWithHexString:@"f5f5f5"];

    NSDictionary *titleAttributes = @{
            NSFontAttributeName : [UIFont fontWithName:@"Helvetica-Bold" size:16.0],
            NSForegroundColorAttributeName : kAppDeepColor
    };
    self.navigationBar.titleTextAttributes = titleAttributes;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

//- (void)longPress:(id)sender {
//    [self.navigationController popToRootViewControllerAnimated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
