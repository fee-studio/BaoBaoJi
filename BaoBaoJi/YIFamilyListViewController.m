//
//  YIFamilyListViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/10.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIFamilyListViewController.h"

@interface YIFamilyListViewController ()

@property (nonatomic, strong) NSMutableArray *familyList;

@end

@implementation YIFamilyListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.familyList = [NSMutableArray array];
	
	[_familyList addObject:@{@"title": @"所有亲", @"checked": @(YES)}];
	[_familyList addObject:@{@"title": @"仅自己", @"checked": @(NO)}];
	[_familyList addObject:@{@"title": @"宝爸宝妈", @"checked": @(NO)}];
	[_familyList addObject:@{@"title": @"家人", @"checked": @(NO)}];
	
	[self.baseTableView reloadData];
}

#pragma mark - table view delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _familyList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
	BOOL isChecked = [[_familyList[indexPath.row] objectForKey:@"checked"] boolValue];
	cell.accessoryType = isChecked ? UITableViewCellAccessoryCheckmark :UITableViewCellAccessoryNone;
	cell.textLabel.text = [_familyList[indexPath.row] objectForKey:@"title"];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	[_familyList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		NSMutableDictionary *family = [NSMutableDictionary dictionaryWithDictionary:obj];
		if (idx == indexPath.row) {
			[family setObject:@(YES) forKey:@"checked"];
		} else {
			[family setObject:@(NO) forKey:@"checked"];
		}
		_familyList[idx] = family;
	}];
	
	[self.baseTableView reloadData];
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
