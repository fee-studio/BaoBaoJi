//
//  YIBaseViewController.m
//  Dobby
//
//  Created by efeng on 14-5-17.
//  Copyright (c) 2014年 weiboyi. All rights reserved.
//

//#import "UMFeedbackViewController.h"
//#import "DemoMessagesViewController.h"


@interface YIBaseViewController ()

@end

@implementation YIBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"微播圈(激情内测版)";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.frame = mScreenBounds;
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];

    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        // skill 这句很关键.关于在UINavigationController下面布局UIViewController + UITableView
        self.edgesForExtendedLayout = UIRectEdgeNone;
//        self.extendedLayoutIncludesOpaqueBars = YES;
//        self.automaticallyAdjustsScrollViewInsets = YES;
    }

    // register for keyboard notifications
    [mNotificationCenter addObserver:self
                            selector:@selector(keyboardWillShow:)
                                name:UIKeyboardWillShowNotification
                              object:self.view.window];
    // register for keyboard notifications
    [mNotificationCenter addObserver:self
                            selector:@selector(keyboardWillHide:)
                                name:UIKeyboardWillHideNotification
                              object:self.view.window];

#if DEBUG
    self.rdv_tabBarController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"FLEX" style:UIBarButtonItemStylePlain target:self action:@selector(flexButtonTapped:)];
#endif

}

#if DEBUG
- (void)flexButtonTapped:(id)sender {
    [[FLEXManager sharedManager] showExplorer];
}
#endif

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [MobClick beginLogPageView:NSStringFromClass(self.class)];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [MobClick endLogPageView:NSStringFromClass(self.class)];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

//    UIViewController *curVc = [[mAppDelegate window] currentViewController];
//    if ([curVc isKindOfClass:[MMDrawerController class]]) {
//        MMDrawerController *dc = (MMDrawerController *) curVc;
//        [TSMessage setDefaultViewController:[dc centerViewController]];
//    } else {
//        [TSMessage setDefaultViewController:curVc];
//    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
//    UIViewController *curVc = [[mAppDelegate window] currentViewController];
//    if ([curVc isKindOfClass:[MMDrawerController class]]) {
//        MMDrawerController *dc = (MMDrawerController *) curVc;
//        [TSMessage setDefaultViewController:[dc centerViewController]];
//    } else {
//        [TSMessage setDefaultViewController:curVc];
//    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self hideKeyboard:nil];
}

#pragma mark - keyboard selector
/**
 *  隐藏键盘
 */
- (void)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

- (void)keyboardWillShow:(NSNotification *)n {
    _keyboardIsShown = YES;
}

- (void)keyboardWillHide:(NSNotification *)n {
    _keyboardIsShown = NO;
}

#pragma mark -

#pragma mark - MMDrawerController 相关方法
#pragma mark 左右按钮

- (void)setupLeftMenuButton {
    MMDrawerBarButtonItem *leftDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(leftDrawerButtonPress:)];
    [leftDrawerButton setImage:[UIImage imageNamed:@"more_btn"]];
    [self.navigationItem setLeftBarButtonItem:leftDrawerButton animated:YES];
}

- (void)setupRightMenuButton {
    MMDrawerBarButtonItem *rightDrawerButton = [[MMDrawerBarButtonItem alloc] initWithTarget:self action:@selector(rightDrawerButtonPress:)];
    [self.navigationItem setRightBarButtonItem:rightDrawerButton animated:YES];
}

#pragma mark Button Handlers

- (void)leftDrawerButtonPress:(id)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    [self hideKeyboard:nil];
}

- (void)rightDrawerButtonPress:(id)sender {
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideRight animated:YES completion:nil];
    [self hideKeyboard:nil];
}

#pragma mark - MBProgressHUD 相关方法

- (void)showLoadingView {
    [self hideKeyboard:nil];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)showLoadingViewToWindow {
    [self hideKeyboard:nil];
    HUD = [MBProgressHUD showHUDAddedTo:[mAppDelegate window] animated:YES];
}

- (void)showLoadingViewNoInteraction {
    [self hideKeyboard:nil];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.userInteractionEnabled = NO;
}

- (void)hideLoadingView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)hideLoadingViewToWindow {
    [MBProgressHUD hideHUDForView:self.view.window animated:YES];
}

- (void)showLoadingViewWithText:(NSString *)text {
    [self hideKeyboard:nil];
    HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = text;
}

- (void)showLoadingViewDefaultText {
    [self hideKeyboard:nil];
    [self showLoadingViewWithText:@"正在加载中..."];
}

#pragma mark -

- (void)feedbackAction:(id)sender {
//    [MobClick event:CLICK_FEEDBACK_ENTER];

    
//    if ([YIConfigUtil onFeedback2]) {
//        DemoMessagesViewController *vc = [DemoMessagesViewController messagesViewController];
//        [self.navigationController pushViewController:vc animated:YES];
//    } else {
//        YIFeedbackVc *fvc = [[YIFeedbackVc alloc] init];
//        [self.navigationController pushViewController:fvc animated:YES];
//    }
}

#pragma mark -

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud {
    // Remove HUD from screen when the HUD was hidded
    [HUD removeFromSuperview];
    HUD = nil;
}

@end
