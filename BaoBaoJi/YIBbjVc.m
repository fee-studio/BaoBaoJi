//
// Created by efeng on 15/11/5.
// Copyright (c) 2015 buerguo. All rights reserved.
//

#import "YIBbjVc.h"
#import "YIPublishVc.h"
#import "CTAssetsPickerController.h"
#import "YIBbjCell.h"
//#import "YITimelineModel.h"
#import "LCTimelineEntity.h"
#import "UICollectionViewCell+AutoLayoutDynamicHeightCalculation.h"
#import "UICollectionView+ARDynamicCacheHeightLayoutCell.h"
#import "YIBbjHeaderView.h"
#import "CSStickyHeaderFlowLayout.h"
#import "YIBabyDetailVc.h"
#import "IDMPhotoBrowser.h"

@interface YIBbjVc () <UIActionSheetDelegate, CTAssetsPickerControllerDelegate,
YIBbjHeaderViewDelegate, IDMPhotoBrowserDelegate, YIBbjCellDelegate> {

}

@property (nonatomic, strong) NSArray<LCTimelineEntity *> *timelines;

@end


@implementation YIBbjVc {

}

- (instancetype)init {
    self = [super init];
    if (self) {
    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	// todo
//	 self.refreshEnable = YES;
	
    // 装配NavigationBar
    [self setupNavigationBar];

	// 注册 UICollectionView
    [self.baseCollectionView registerNib:[YIBbjCell cellNib]
			  forCellWithReuseIdentifier:NSStringFromClass([YIBbjCell class])];

	[self.baseCollectionView registerNib:[YIBbjHeaderView viewNib]
			  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
					 withReuseIdentifier:NSStringFromClass([YIBbjHeaderView class])];
		
	/*  头部的效果
	[self reloadLayout];
	 */
	
	// todo
	// 这个用法牛比. 自动高度 自动刷新
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wundeclared-selector"
//	method_exchangeImplementations(class_getInstanceMethod(self.baseCollectionView.class, @selector(reloadData)), class_getInstanceMethod(self.baseCollectionView.class, @selector(ar_reloadData)));
//#pragma clang diagnostic pop
	
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self loadTimelineData];
	
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
//	[self.view addSubview:self.baseCollectionView];
}

- (void)reloadLayout {
	UINib *headerNib = [UINib nibWithNibName:@"CSGrowHeader" bundle:nil];
	[self.baseCollectionView registerNib:headerNib
			  forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
					 withReuseIdentifier:@"header"];
	
	CSStickyHeaderFlowLayout *layout = [CSStickyHeaderFlowLayout new];
//	layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 200);
//	layout.itemSize = CGSizeMake(self.view.frame.size.width, layout.itemSize.height);
	// If we want to disable the sticky header effect
	layout.disableStickyHeaders = YES;
	self.baseCollectionView.collectionViewLayout = layout;
}

//- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//}

#pragma mark -

- (void)headerRefreshing {
    [self loadTimelineData];
}

- (void)footerRefreshing {
    
}

#pragma mark -

- (void)setupNavigationBar {
	UIViewController *vc = self.rdv_tabBarController;
    self.rdv_tabBarController.navigationItem.title = @"宝宝记";

    UIBarButtonItem *publishItem = [[UIBarButtonItem alloc] initWithTitle:@"发表"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(publishItemAction)];
//    NSDictionary *titleAttributes = @{
//            NSFontAttributeName : [UIFont systemFontOfSize:15.0],
//			NSForegroundColorAttributeName : [UIColor whiteColor]
//    };
//    [publishItem setTitleTextAttributes:titleAttributes forState:UIControlStateNormal];

    NSMutableArray *rightItemMa = [NSMutableArray arrayWithCapacity:2];
    NSArray *rightItems = self.rdv_tabBarController.navigationItem.rightBarButtonItems;
    if (rightItems) {
        [rightItemMa addObjectsFromArray:rightItems];
    }
    [rightItemMa addObject:publishItem];
    self.rdv_tabBarController.navigationItem.rightBarButtonItems = rightItemMa;
}

- (void)loadTimelineData {
    AVQuery *query = [LCTimelineEntity query];
    [query orderByDescending:@"createdAt"];
    [query setLimit:10];
    [query whereKey:@"isDeleted" equalTo:@(NO)];
	[query whereKey:@"baby" equalTo:mGlobalData.user.curBaby];
    /**
		如果对象的某一属性是一个文件数组，那么在获取该属性的查询中，必须加上 includeKey: 来指定该属性名，否则，查询结果中该属性对应的值将是 AVObject 数组，而不是 AVFile 数组。
     */
    [query includeKey:@"sharedItem"]; // VIP 这个是关键
	[query includeKey:@"sharedItem.data"]; // VVIP 太酷了这样.这种写法都能被我猜到
	[query includeKey:@"location"];
    [query setCachePolicy:kAVCachePolicyNetworkElseCache];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
//        [self.baseCollectionView.mj_header endRefreshing];
        if (!error) {
			self.timelines = objects;
			
			self.baseCollectionView.delegate = self;
			self.baseCollectionView.dataSource = self;
			[self.baseCollectionView reloadData];
		}
    }];
}

//- (NSArray *)formatLCTimelinesToYITimelines:(NSArray *)lcTimelines {
//    NSMutableArray *yiTimelines = [NSMutableArray array];
//    for (LCTimelineEntity *timeline in lcTimelines) {
//        [yiTimelines addObject:[self formatLCTimelineToYITimeline:timeline]];
//    }
//    return yiTimelines;
//}

//- (YITimelineModel *)formatLCTimelineToYITimeline:(LCTimelineEntity *)lcTimeline {
//    YITimelineModel *yiTimeline = [[YITimelineModel alloc] init];
//	//    yiTimeline.shareImages = lcTimeline.shareImages; // todo ...
//    yiTimeline.shareMsg = lcTimeline.shareMsg;
////    yiTimeline.recordObj = lcTimeline.author.role; // todo ...
//    yiTimeline.shareTime = lcTimeline.createdAt;
//    yiTimeline.happenTime = lcTimeline.happenTime;
//	yiTimeline.userName = lcTimeline.author.username;
//    yiTimeline.avatarUrl = [NSURL URLWithString:lcTimeline.author.avatar];
//    return yiTimeline;
//}

#pragma mark - 发表记录

- (void)publishItemAction {
	/* 方案一
    UIActionSheet *publishAs = [[UIActionSheet alloc] initWithTitle:NULL
                                                           delegate:self
                                                  cancelButtonTitle:@"取消"
                                             destructiveButtonTitle:NULL
                                                  otherButtonTitles:@"拍照", @"从手机相册选择", nil];
    [publishAs showInView:[mAppDelegate window]];
	 */
	
	// 方案二
	YIPublishVc *publishVc = [[YIPublishVc alloc] init];
	YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:publishVc];
	[self presentViewController:bnc animated:YES completion:NULL];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex; {
    if (buttonIndex == 0) { // 拍照

    } else if (buttonIndex == 1) { // 从手机相册选择
        [self loadPickerVc];
    }
}

- (void)loadPickerVc {
    // init picker
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] init];
    // set delegate
    picker.delegate = self;
    // Optionally present picker as a form sheet on iPad
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        picker.modalPresentationStyle = UIModalPresentationFormSheet;
    // present picker
    [self presentViewController:picker animated:NO completion:nil];
}

#pragma mark - CTAssetsPickerControllerDelegate

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group {
    return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos);
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets {
    [picker.presentingViewController dismissViewControllerAnimated:NO completion:nil];
    
    YIPublishVc *publishVc = [[YIPublishVc alloc] init];
    publishVc.willPublishImages = assets;
    YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:publishVc];
    [self presentViewController:bnc animated:YES completion:NULL];

//    _assets = [NSMutableArray arrayWithArray:assets];
//    [self refreshPictureData];
//    _commitBtnItem.enabled = YES;
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset {
    // Enable video clips if they are at least 5s
    if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo]) {
        NSTimeInterval duration = [[asset valueForProperty:ALAssetPropertyDuration] doubleValue];
        return lround(duration) >= 5;
    } else {
        return YES;
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset {
//    if (picker.selectedAssets.count >= self.maxCountSelected - _serverPictures.count) {
//        NSString *alertString = [NSString stringWithFormat:@"最多只能选%lu张图片", (unsigned long) self.maxCountSelected];
//        UIAlertView *alertView =
//        [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention", nil)
//                                   message:NSLocalizedString(alertString, nil)
//                                  delegate:nil
//                         cancelButtonTitle:nil
//                         otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
//
//        [alertView show];
//    }
//
//    if (!asset.defaultRepresentation) {
//        UIAlertView *alertView =
//        [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Attention", nil)
//                                   message:@"Your asset has not yet been downloaded to your device"
//                                  delegate:nil
//                         cancelButtonTitle:nil
//                         otherButtonTitles:NSLocalizedString(@"OK", nil), nil];
//
//        [alertView show];
//    }
//
//    return (picker.selectedAssets.count < (self.maxCountSelected - _serverPictures.count) && asset.defaultRepresentation != nil);
    return true;
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _timelines.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YIBbjCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YIBbjCell class]) forIndexPath:indexPath];
	cell.delegate = self;
    LCTimelineEntity *timeline = _timelines[indexPath.row];
    [cell setupCell:timeline];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath; {
	
	// Check the kind if it's CSStickyHeaderParallaxHeader
	if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
		UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
																					  withReuseIdentifier:@"header"
																							 forIndexPath:indexPath];
		return cell;
	} else if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
		YIBbjHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
																   withReuseIdentifier:NSStringFromClass([YIBbjHeaderView class])
																		  forIndexPath:indexPath];
		view.delegate = self;
		[view setupView];
		
		return view;
	} else {
		return nil;
	}
}


#pragma mark -  UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section; {
	return CGSizeMake(mScreenWidth, 200.f);
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LCTimelineEntity *timeline = _timelines[indexPath.row];
    CGSize size = [collectionView ar_sizeForCellWithIdentifier:NSStringFromClass([YIBbjCell class]) indexPath:indexPath fixedWidth:mScreenWidth configuration:^(__kindof UICollectionViewCell *cell) {
        [cell setupCell:timeline];
    }];
	
	NSLog(@"collectionView-size = %@", NSStringFromCGSize(size));
	
	return size;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}

#pragma mark - YIBbjHeaderViewDelegate

- (void)babyInfoBtnDidSelected; {
	YIBabyDetailVc *vc = [[YIBabyDetailVc alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

#pragma YIBbjCellDelegate 

- (void)tapPhotoAtIndex:(NSUInteger)index allPhotos:(NSArray *)photos tappedView:(UIView *)view {
	IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos animatedFromView:view]; // using initWithPhotos:animatedFromView: method to use the zoom-in animation
	browser.delegate = self;
	browser.displayToolbar = YES;
	browser.displayArrowButton = NO;
	browser.displayCounterLabel = YES;
	browser.usePopAnimation = YES;
	browser.scaleImage = ((UIImageView *)view).image;
	[browser setInitialPageIndex:index];
	[self presentViewController:browser animated:YES completion:nil];
}

#pragma mark - IDMPhotoBrowser Delegate

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didShowPhotoAtIndex:(NSUInteger)pageIndex
{
	id <IDMPhoto> photo = [photoBrowser photoAtIndex:pageIndex];
	NSLog(@"Did show photoBrowser with photo index: %d, photo caption: %@", pageIndex, photo.caption);
}

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser willDismissAtPageIndex:(NSUInteger)pageIndex
{
	id <IDMPhoto> photo = [photoBrowser photoAtIndex:pageIndex];
	NSLog(@"Will dismiss photoBrowser with photo index: %d, photo caption: %@", pageIndex, photo.caption);
}

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissAtPageIndex:(NSUInteger)pageIndex
{
	id <IDMPhoto> photo = [photoBrowser photoAtIndex:pageIndex];
	NSLog(@"Did dismiss photoBrowser with photo index: %d, photo caption: %@", pageIndex, photo.caption);
}

- (void)photoBrowser:(IDMPhotoBrowser *)photoBrowser didDismissActionSheetWithButtonIndex:(NSUInteger)buttonIndex photoIndex:(NSUInteger)photoIndex
{
	id <IDMPhoto> photo = [photoBrowser photoAtIndex:photoIndex];
	NSLog(@"Did dismiss actionSheet with photo index: %d, photo caption: %@", photoIndex, photo.caption);
	
}


@end