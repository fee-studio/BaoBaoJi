//
//  YIRecordTimeViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/8.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIRecordTimeViewController.h"

@interface YIRecordTimeViewController ()
{
	UIDatePicker *datePicker;
}
@property (nonatomic, strong) NSMutableArray *recordTimeList;

@end

@implementation YIRecordTimeViewController

- (instancetype)init {
	self = [super init];
	if (self) {
		self.title = @"选择记录时间";
		self.curDate = [NSDate date];
	}
	return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];

	self.recordTimeList = [NSMutableArray arrayWithCapacity:2];
	
	if (_photoDate) {
		[_recordTimeList addObject:@{@"title" : @"照片时间",
									 @"time" : _photoDate,
									 @"checked" : @(NO)}];
	}
	
	[_recordTimeList addObject:@{@"title" : @"当前时间",
								 @"time" : _curDate,
								 @"checked" : @(YES)}];
	
	[_recordTimeList addObject:@{@"title" : @"自定义时间",
								 @"time" : @"",
								 @"checked" : @(NO)}];
}

- (void)viewDidDisappear:(BOOL)animated {
	
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
	cell.detailTextLabel.text = [[_recordTimeList[indexPath.row] objectForKey:@"time"] convertDateToStringWithFormat:@"yyyy-MM-dd"];
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	[_recordTimeList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
		NSMutableDictionary *recordTime = [NSMutableDictionary dictionaryWithDictionary:obj];
		if (idx == indexPath.row) {
			[recordTime setObject:@(YES) forKey:@"checked"];
		} else {
			[recordTime setObject:@(NO) forKey:@"checked"];
		}
		_recordTimeList[idx] = recordTime;
	}];
	[self.baseTableView reloadData];
	
	if (indexPath.row == 1) {
		[self showDatePicker];
	} else {
		[self hideDatePicker];
	}
}

#pragma mark -

- (void)showDatePicker {
	if (datePicker == nil) {
		datePicker = [[UIDatePicker alloc] init];
		[datePicker setDate:[NSDate date] animated:YES];
		[datePicker setDatePickerMode:UIDatePickerModeDate];
		[datePicker addTarget:self action:@selector(selectedDateChanged:) forControlEvents:UIControlEventValueChanged];
		[self.view addSubview:datePicker];
		[datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
			make.width.equalTo(self.view);
			make.left.equalTo(self.view);
			make.bottom.equalTo(self.view);
			make.height.equalTo(@216);
		}];
	}
	if (datePicker) {
		datePicker.hidden = NO;
	}
}

- (void)hideDatePicker {
	if (datePicker) {
		datePicker.hidden = YES;
	}
}

- (void)selectedDateChanged:(id)sender {
	NSArray *array = @[ [NSIndexPath indexPathForRow:1 inSection:0] ];
	NSMutableDictionary *recordTime = [NSMutableDictionary dictionaryWithDictionary:_recordTimeList[1]];
	[recordTime setObject:datePicker.date forKey:@"time"];
	_recordTimeList[1] = recordTime;
	[self.baseTableView reloadRowsAtIndexPaths:array withRowAnimation:UITableViewRowAnimationFade];
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
