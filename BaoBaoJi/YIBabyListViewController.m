//
//  YIBabyListViewController.m
//  BaoBaoJi
//
//  Created by efeng on 16/1/6.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIBabyListViewController.h"
#import "YIBabyListHeaderView.h"
#import "YIBabyListCell.h"
#import "YIBabyInfoViewController.h"


@interface YIBabyListViewController () <YIBabyListHeaderViewDelegate>

@property (nonatomic, copy) NSArray *babyData;

@end

@implementation YIBabyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	YIBabyListHeaderView *headerView = (YIBabyListHeaderView *)[UIView loadNibView:NSStringFromClass(YIBabyListHeaderView.class)];
	headerView.delegate = self;
	UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, mScreenWidth, 100)];
	[tableHeaderView addSubview:headerView];
	[headerView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.edges.equalTo(tableHeaderView);
	}];
	self.baseTableView.tableHeaderView = tableHeaderView;
	
	UINib *nib = [UINib nibWithNibName:NSStringFromClass([YIBabyListCell class]) bundle:[NSBundle mainBundle]];
	[self.baseTableView registerNib:nib forCellReuseIdentifier:NSStringFromClass([YIBabyListCell class])];
	self.baseTableView.rowHeight = 80.f;
	
	self.baseTableView.contentInset = UIEdgeInsetsMake(44+20, 0, 0, 0);
	self.baseTableView.scrollIndicatorInsets = UIEdgeInsetsMake(44+20, 0, 0, 0);
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.babyData = mGlobalData.user.babies;
	[self.baseTableView reloadData];
}

#pragma mark - table view delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _babyData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	YIBabyListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([YIBabyListCell class])];
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	// 装配CELL
	[cell setupCell:_babyData[indexPath.row]];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section; {
	return 20.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section; {
	return 0.01f;
}

#pragma mark - YIBabyListHeaderViewDelegate

- (void)selectedAddBabyAction {
	YIBabyInfoViewController *vc = [[YIBabyInfoViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)selectedInputInviteCodeAction {
	// todo ...
}

#pragma mark -

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
