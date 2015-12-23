//
//  YILocationViewController.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/10.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YILocationViewController.h"
#import <AMapSearch/AMapSearchKit/AMapSearchKit.h>
#import <AMapLocation/AMapLocationKit/AMapLocationKit.h>

@interface YILocationViewController () <AMapSearchDelegate> {
	AMapGeoPoint *geoPoint;
}

@property (nonatomic, strong) NSArray *pois;
@property (strong, nonatomic) AMapLocationManager *locationManager;
@property (strong, nonatomic) AMapSearchAPI *search;
@end

@implementation YILocationViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view from its nib.

	if (_selectedIndexPath == nil) {
		self.selectedIndexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	}
	
	[self showLoadingViewWithText:@"正在加载地理位置"];
	[AMapLocationServices sharedServices].apiKey = @"cdd1e561333a882cc1a85f9a61e348a7";
	self.locationManager = [[AMapLocationManager alloc] init];
	// 带逆地理信息的一次定位（返回坐标和地址信息）
	[self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
	// 带逆地理（返回坐标和地址信息）
	[self.locationManager requestLocationWithReGeocode:NO completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
		if (location) {
			NSLog(@"latitude = %f",location.coordinate.latitude);
			NSLog(@"longitude = %f",location.coordinate.longitude);
			
			[AMapSearchServices sharedServices].apiKey = @"cdd1e561333a882cc1a85f9a61e348a7";
			// 初始化检索对象
			self.search = [[AMapSearchAPI alloc] init];
			_search.delegate = self;
			
			//构造AMapPOIAroundSearchRequest对象，设置周边请求参数
			AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
			geoPoint = request.location = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude
														longitude:location.coordinate.longitude];
			
			// types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
			// POI的类型共分为20种大类别，分别为：
			// 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
			// 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
			// 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
			request.types = @"汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施";
			request.sortrule = 0;
			request.requireExtension = YES;
			//发起周边搜索
			[_search AMapPOIAroundSearch:request];
		}
	}];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	if ([_delegate respondsToSelector:@selector(selectedLocation:indexPath:)]) {
		LCLocationEntity *location = [LCLocationEntity new];
		AMapPOI *curPoi = self.pois[_selectedIndexPath.row];
		location.name = curPoi.name;
		location.address = curPoi.address;
		location.latitude = geoPoint.latitude;
		location.longitude = geoPoint.longitude;
		[_delegate selectedLocation:location indexPath:_selectedIndexPath];
	}
	
}

#pragma mark -

//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
	[self hideLoadingView];
	
	if(response.pois.count == 0)
	{
		return;
	}

	//通过 AMapPOISearchResponse 对象处理搜索结果
//	NSString *strCount = [NSString stringWithFormat:@"count: %d",response.count];
//	NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
//	NSString *strPoi = @"";
	
	self.pois = response.pois;
	[self _supplementPoisData];
	[self.baseTableView reloadData];
	
//	for (AMapPOI *p in response.pois) {
//		strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
//	}
//	NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
//	NSLog(@"Place: %@", result);
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error;
{
	[self hideLoadingView];
}

#pragma mark -

- (void)_supplementPoisData {
	NSMutableArray *poiMa = [NSMutableArray arrayWithArray:_pois];
	AMapPOI *poi = [AMapPOI new];
	poi.name = @"不显示位置";
	[poiMa insertObject:poi atIndex:0];
	
	self.pois = poiMa;
}

#pragma mark - table view delegate & datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _pois.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
	if (_selectedIndexPath == indexPath) {

	}
	
	AMapPOI *poi = _pois[indexPath.row];

	cell.accessoryType = _selectedIndexPath == indexPath ? UITableViewCellAccessoryCheckmark :UITableViewCellAccessoryNone;
	
	if (poi.name) {
		cell.textLabel.text = poi.name;
	}
	if (poi.address) {
		cell.detailTextLabel.text = poi.address;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	self.selectedIndexPath = indexPath;
	
//	[_pois enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {		
//		NSMutableDictionary *family = [NSMutableDictionary dictionaryWithDictionary:obj];
//		if (idx == indexPath.row) {
//			[family setObject:@(YES) forKey:@"checked"];
//		} else {
//			[family setObject:@(NO) forKey:@"checked"];
//		}
//		_pois[idx] = family;
//	}];
	
	[self.baseTableView reloadData];
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
