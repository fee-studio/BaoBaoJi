//
// Created by efeng on 15/11/5.
// Copyright (c) 2015 buerguo. All rights reserved.
//

#import "YIBbjVc.h"
#import "YIPublishVc.h"
#import "CTAssetsPickerController.h"
#import "YIBbjCell.h"
#import "YITimelineModel.h"
#import "LCTimelineModel.h"
#import "UICollectionViewCell+AutoLayoutDynamicHeightCalculation.h"
#import "UICollectionView+ARDynamicCacheHeightLayoutCell.h"

@interface YIBbjVc () <UIActionSheetDelegate, CTAssetsPickerControllerDelegate> {

}

@property (nonatomic, strong) NSArray<YITimelineModel *> *timelines;

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
    // 装配NavigationBar
    [self setupNavigationBar];

    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.baseCollectionView.collectionViewLayout;
//    layout.estimatedItemSize = CGSizeMake(1, 1);

	
    [self.baseCollectionView registerNib:[YIBbjCell cellNib] forCellWithReuseIdentifier:NSStringFromClass([YIBbjCell class])];
	
	// 这个用法牛比.
	method_exchangeImplementations(class_getInstanceMethod(self.baseCollectionView.class, @selector(reloadData)), class_getInstanceMethod(self.baseCollectionView.class, @selector(ar_reloadData)));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark -

- (void)headerRefreshing {
    [self loadTimelineData];
}

- (void)footerRefreshing {
    
}

#pragma mark -

- (void)setupNavigationBar {
    self.rdv_tabBarController.navigationItem.title = @"宝宝记";

    UIBarButtonItem *publishItem = [[UIBarButtonItem alloc] initWithTitle:@"发表"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(publishItemAction)];
    NSDictionary *titleAttributes = @{
            NSFontAttributeName : [UIFont systemFontOfSize:15.0],
            NSForegroundColorAttributeName : kAppMainColor
    };
    [publishItem setTitleTextAttributes:titleAttributes forState:UIControlStateNormal];

    NSMutableArray *rightItemMa = [NSMutableArray arrayWithCapacity:2];
    NSArray *rightItems = self.rdv_tabBarController.navigationItem.rightBarButtonItems;
    if (rightItems) {
        [rightItemMa addObjectsFromArray:rightItems];
    }
    [rightItemMa addObject:publishItem];
    self.rdv_tabBarController.navigationItem.rightBarButtonItems = rightItemMa;
}

- (void)loadTimelineData {
    AVQuery *query = [LCTimelineModel query];
    [query orderByDescending:@"createdAt"];
    [query setLimit:10];
    [query whereKey:@"isDeleted" equalTo:@(NO)];
    /**
     *  如果对象的某一属性是一个文件数组，那么在获取该属性的查询中，必须加上 includeKey: 来指定该属性名，否则，查询结果中该属性对应的值将是 AVObject 数组，而不是 AVFile 数组。
     */
    [query includeKey:@"shareImages"]; // VIP 这个是关键
    [query setCachePolicy:kAVCachePolicyNetworkElseCache];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        [self.baseCollectionView.mj_header endRefreshing];
        if (!error) {
            self.timelines = [self formatLCTimelinesToYITimelines:objects];
            [self.baseCollectionView reloadData];
        }
    }];
}

- (NSArray *)formatLCTimelinesToYITimelines:(NSArray *)lcTimelines {
    NSMutableArray *yiTimelines = [NSMutableArray array];
    for (LCTimelineModel *timeline in lcTimelines) {
        [yiTimelines addObject:[self formatLCTimelineToYITimeline:timeline]];
    }
    return yiTimelines;
}

- (YITimelineModel *)formatLCTimelineToYITimeline:(LCTimelineModel *)lcTimeline {
    YITimelineModel *yiTimeline = [[YITimelineModel alloc] init];
    yiTimeline.shareImages = lcTimeline.shareImages;
    yiTimeline.shareMsg = lcTimeline.shareMsg;
    yiTimeline.recordObj = lcTimeline.author.role; // todo ...
    yiTimeline.shareTime = lcTimeline.createdAt;
    yiTimeline.happenTime = lcTimeline.happenTime;
    yiTimeline.userName = lcTimeline.author.userName;
    yiTimeline.avatarUrl = [NSURL URLWithString:lcTimeline.author.avatarUrl];
    return yiTimeline;
}

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
    YITimelineModel *timeline = _timelines[indexPath.row];
    [cell setupCell:timeline];
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

#pragma mark -  UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
//    YIBbjCell *cell = (YIBbjCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    NSLog(@"--------> %@",cell);
//    return CGSizeMake(mScreenWidth, 200);
    
//    YIBbjCell * cell = (YIBbjCell *) [self.baseCollectionView cellForItemAtIndexPath:indexPath];
//    
//    if (cell == nil) {
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"YIBbjCell" owner:self options:nil];
//        cell = [topLevelObjects objectAtIndex:0];
//        cell.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20);
//        // SET YOUR CONTENT
//        [cell layoutIfNeeded];
//    }
//
//    CGSize CellSize1 = [cell systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    CGSize CellSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize
//                          withHorizontalFittingPriority:UILayoutPriorityDefaultHigh
//                                verticalFittingPriority:UILayoutPriorityDefaultHigh];
//    return CellSize1;
    
//    static YIBbjCell *sizingCell = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//    YIBbjCell *sizingCell = (YIBbjCell *) [self.baseCollectionView cellForItemAtIndexPath:indexPath];
//        
//        if (sizingCell == nil) {
//            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"YIBbjCell" owner:self options:nil];
//            sizingCell = [topLevelObjects firstObject];
////            sizingCell.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 20);
////            // SET YOUR CONTENT
////            [cell layoutIfNeeded];
//        }
//
////    });
//    
//    [sizingCell setNeedsLayout];
//    [sizingCell layoutIfNeeded];
//    
//    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
//    return size;
    
//    YIBbjCell *cell = [YIBbjCell heightCalculationCellFromNibWithName:NSStringFromClass([YIBbjCell class])];
//    CGFloat height = [cell heightAfterAutoLayoutPassAndRenderingWithBlock:^{
////        [(id<MYSweetCellRenderProtocol>)cell renderWithModel:someModel];
//    }];
//    return CGSizeMake(CGRectGetWidth(self.baseCollectionView.bounds), height);
    
//    return [collectionView ar_sizeForCellWithIdentifier:@"YIBbjCell" configuration:^(id cell) {
//        //configuration your cell
////        FeedModel *feed = self.feeds[indexPath.row];
////        [cell filleCellWithFeed:feed];
//    }];
    
//    return [collectionView ar_sizeForCellWithIdentifier:@"YIBbjCell" indexPath:indexPath configuration:^(__kindof UICollectionViewCell *cell) {
//        
//    }];
    
    
    YITimelineModel *timeline = _timelines[indexPath.row];
    CGSize size = [collectionView ar_sizeForCellWithIdentifier:NSStringFromClass([YIBbjCell class]) indexPath:indexPath fixedWidth:mScreenWidth configuration:^(__kindof UICollectionViewCell *cell) {
        [cell setupCell:timeline];
    }];
	
	NSLog(@"collectionView-size = %@",NSStringFromCGSize(size));
	
	return size;
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsZero;
}


@end