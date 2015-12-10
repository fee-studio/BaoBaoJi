//
//  YIRecordTimeViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/8.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIRecordTimeViewController.h"

@interface YIRecordTimeViewController ()

@property (nonatomic, strong) NSMutableArray *recordTimeList;

@end

@implementation YIRecordTimeViewController

- (instancetype)init {
	self = [super init];
	if (self) {
		self.title = @"选择记录时间";
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

	self.recordTimeList = [NSMutableArray arrayWithCapacity:2];
	
	if (_photoTime) {
		[_recordTimeList addObject:@{@"title" : @"照片时间",
									 @"time" : [_photoTime convertDateToStringWithFormat:@"yyyy-MM-dd"],
									 @"checked" : @(NO)}];
	}
	
	[_recordTimeList addObject:@{@"title" : @"当前时间",
								 @"time" : [[NSDate date] convertDateToStringWithFormat:@"yyyy-MM-dd"],
								 @"checked" : @(YES)}];
	
	[_recordTimeList addObject:@{@"title" : @"自定义时间",
								 @"time" : @"",
								 @"checked" : @(NO)}];
}

#pragma mark - table view delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _recordTimeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
	}
	BOOL isChecked = [[_recordTimeList[indexPath.row] objectForKey:@"checked"] boolValue];
	cell.accessoryType = isChecked ? UITableViewCellAccessoryCheckmark :UITableViewCellAccessoryNone;
	cell.textLabel.text = [_recordTimeList[indexPath.row] objectForKey:@"title"];
	cell.detailTextLabel.text = [_recordTimeList[indexPath.row] objectForKey:@"time"];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	[_recordTimeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		if (idx == indexPath.row) {
			[_recordTimeList[idx] setObject:@(YES) forKey:@"checked"];
		} else {
			[_recordTimeList[idx] setObject:@(NO) forKey:@"checked"];
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
