//
//  YIPublishVc.m
//  BaoBaoJi
//
//  Created by efeng on 15/11/5.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIPublishVc.h"
#import "LCTimelineModel.h"
#import "YIFirstDoItemView.h"
#import "CTAssetsPickerController.h"
#import "YIRecordTimeViewController.h"
#import "YIFamilyListViewController.h"

@interface YIPublishVc () <UITextViewDelegate, SwipeViewDelegate,
SwipeViewDataSource, YIFirstDoItemViewDelegate,
CTAssetsPickerControllerDelegate, UIActionSheetDelegate> {
    UIView *lastView;

    UITextView *textView;
	UIButton *firstDoBtn;
	UIView *photosView;
}

@property(nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) SwipeView *swipeView;
@property (nonatomic, copy) NSArray *firstDoThings;
@end

@implementation YIPublishVc

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"宝宝记录";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	// 导航栏
    [self setupNavigationBar];
    
    // 输入框...
    textView = [[UITextView alloc] init];
    textView.font = [UIFont systemFontOfSize:18];
    textView.placeholder = @"此刻的想法...";
    textView.delegate = self;
    [self.scrollView addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scrollView);
        make.top.equalTo(self.scrollView);
        make.width.equalTo(self.scrollView);
        make.height.equalTo(@150);
    }];
    lastView = textView;
	
	// 工具栏
	UIView *toolbarView = [self toolbarView];
	[self.scrollView addSubview:toolbarView];
	[toolbarView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(lastView);
		make.top.equalTo(lastView ? lastView.mas_bottom : @0).with.offset(1);;
		make.width.equalTo(self.scrollView);
		make.height.equalTo(@44);
	}];
	lastView = toolbarView;
	
    // 照片...
	photosView = [self photosView];
	[self.scrollView addSubview:photosView];
	[photosView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.scrollView);
		make.right.equalTo(self.scrollView);
		make.width.equalTo(self.scrollView);
		make.top.equalTo(lastView.mas_bottom).with.offset(1);
	}];
	lastView = photosView;
	
	// 其他参数
	UIView *timeView = [self otherParametersViewText:@"记录时间" value:@""];
	UITapGestureRecognizer *timeTGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTimeViewAction:)];
	[timeView addGestureRecognizer:timeTGR];
	[self.scrollView addSubview:timeView];
	[timeView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.scrollView);
		make.width.equalTo(self.scrollView);
		make.height.equalTo(@44);
		make.top.equalTo(lastView.mas_bottom).with.offset(20);
	}];
	lastView = timeView;

	UIView *roleView = [self otherParametersViewText:@"可见范围" value:@"所有亲"];
	[self.scrollView addSubview:roleView];
	UITapGestureRecognizer *roleTGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapRoleViewAction:)];
	[roleView addGestureRecognizer:roleTGR];
	[roleView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.scrollView);
		make.width.equalTo(self.scrollView);
		make.height.equalTo(@44);
		make.top.equalTo(lastView.mas_bottom).with.offset(1);
	}];
	lastView = roleView;

	UIView *localView = [self otherParametersViewText:@"所在位置" value:@"不显示位置"];
	[self.scrollView addSubview:localView];
	UITapGestureRecognizer *localTGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLocalViewAction:)];
	[localView addGestureRecognizer:localTGR];
	[localView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.scrollView);
		make.width.equalTo(self.scrollView);
		make.height.equalTo(@44);
		make.top.equalTo(lastView.mas_bottom).with.offset(1);
	}];
	lastView = localView;
	
	[self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(lastView).with.offset(20);
	}];
	
	// 点击键盘
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
	[self.scrollView addGestureRecognizer:tap];
}

- (UIView *)otherParametersViewText:(NSString *)title value:(NSString *)value {
	UIView *parametersView = [UIView new];
	[parametersView setBackgroundColor:[UIColor whiteColor]];
	
	UILabel *titleLbl = [UILabel new];
	titleLbl.text = title;
	[parametersView addSubview:titleLbl];
	[titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(parametersView).with.offset(20);
		make.centerY.equalTo(parametersView);
	}];
	
	UILabel *valueLbl = [UILabel new];
	valueLbl.text = value;
	[parametersView addSubview:valueLbl];
	[valueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(parametersView).with.offset(-40);
		make.centerY.equalTo(parametersView);
	}];
	
	UIImageView *arrowIv = [UIImageView new];
	arrowIv.image = [UIImage imageNamed:@"common_icon_arrow"];
	[parametersView addSubview:arrowIv];
	[arrowIv mas_makeConstraints:^(MASConstraintMaker *make) {
		make.right.equalTo(parametersView).with.offset(-20);
		make.centerY.equalTo(parametersView);
	}];
	
	return parametersView;
}

- (UIView *)toolbarView {
	UIView *toolbarView = [UIView new];
	[toolbarView setBackgroundColor:[UIColor whiteColor]];
	
	// 附加小功能
	firstDoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[firstDoBtn setTitle:@"第一次" forState:UIControlStateNormal];
	[firstDoBtn setImage:[UIImage imageNamed:@"ic_addfirst"] forState:UIControlStateNormal];
	[firstDoBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
	[firstDoBtn addTarget:self action:@selector(showFirstDoList) forControlEvents:UIControlEventTouchUpInside];
	[toolbarView addSubview:firstDoBtn];
	[firstDoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(toolbarView).offset(10);
		make.top.equalTo(toolbarView);
		make.height.equalTo(toolbarView);
	}];
	
	return toolbarView;
}

- (UIView *)photosView {
	if (!photosView) {
		photosView = [UIView new];
		[photosView setBackgroundColor:[UIColor whiteColor]];
	} else {
		for (UIView *view in photosView.subviews) {
			[view removeFromSuperview];
		}
	}
	
	int numbers = 4;
	int separate = 1;
	int padding = 10;
	CGFloat width = (mScreenWidth - (numbers - 1) * separate - padding * 2) / numbers;
	CGFloat height = width;
	
	NSUInteger curLine = 0;
	NSUInteger count = _willPublishImages.count;
	
	UIView *lastImageView;
	UIView *mostRightView;
	for (NSUInteger i = 0; i < count + 1; i++) {
		
		UIImageView *imageView = [[UIImageView alloc] init];
		imageView.userInteractionEnabled = YES;
		[imageView setContentMode:UIViewContentModeScaleAspectFill];
		[imageView setClipsToBounds:YES];
		[photosView addSubview:imageView];
		
		// 可点击
		if (i == count) {
			imageView.image = [UIImage imageNamed:@"ic_add_photo"];
			
			UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadImage:)];
			[imageView addGestureRecognizer:tapGR];
		} else {
			ALAsset *asset = _willPublishImages[i];
			imageView.image = [UIImage imageWithCGImage:asset.thumbnail];

			UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(previewImage:)];
			[imageView addGestureRecognizer:tapGR];
		}
		
		if (i / numbers == curLine) {
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				if (lastImageView) {
					make.top.equalTo(lastImageView.mas_top);
					make.left.equalTo(lastImageView.mas_right).offset(separate);
					make.width.equalTo(lastImageView.mas_width);
					make.height.equalTo(lastImageView.mas_height);
				} else {
					make.left.equalTo(photosView).with.offset(padding);
					make.top.equalTo(photosView).with.offset(padding);
//					make.bottom.equalTo(photosView).with.offset(-padding).priorityLow();
					make.width.equalTo(@(width));
					make.height.equalTo(@(height));
				}
			}];
			if (i == (numbers - 1)) {
				mostRightView = imageView;
			}
		} else {
			curLine = i / numbers;
			[imageView mas_makeConstraints:^(MASConstraintMaker *make) {
				make.top.equalTo(lastImageView ? lastImageView.mas_bottom : photosView).offset(separate);
				make.left.equalTo(photosView).offset(padding);
				make.width.equalTo(lastImageView ? lastImageView.mas_width : @(width));
				make.height.equalTo(lastImageView ? lastImageView.mas_width : @(height));
//				make.bottom.equalTo(photosView).with.offset(-padding).priorityHigh();
			}];
		}
		
		lastImageView = imageView;
	}
	
	[photosView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(lastImageView).with.offset(padding);
	}];
	
	
	return photosView;
}


- (void)setupNavigationBar {
    UIBarButtonItem *publishItem = [[UIBarButtonItem alloc] initWithTitle:@"发表"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(publishItemAction)];
    NSDictionary *publishAttributes = @{
            NSFontAttributeName : [UIFont systemFontOfSize:15.0],
            NSForegroundColorAttributeName : kAppMainColor
    };
    [publishItem setTitleTextAttributes:publishAttributes forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = publishItem;

    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(backItemAction)];
    NSDictionary *backAttributes = @{
            NSFontAttributeName : [UIFont systemFontOfSize:15.0],
            NSForegroundColorAttributeName : kAppMainColor
    };
    [backItem setTitleTextAttributes:backAttributes forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)showFirstDoList {
	[self hideKeyboard:nil];
	
	if (_swipeView && _firstDoThings) {
		_swipeView.hidden = !_swipeView.hidden;
		return;
	}
	
	self.swipeView = [SwipeView new];
	_swipeView.backgroundColor = kAppWhiteColor;
	[self.view addSubview:_swipeView];
	[_swipeView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(self.view);
		make.right.equalTo(self.view);
		make.bottom.equalTo(self.view);
		make.width.equalTo(self.view);
		make.height.equalTo(@200);
	}];
	
	_swipeView.alignment = SwipeViewAlignmentCenter;
	_swipeView.pagingEnabled = YES;
	_swipeView.itemsPerPage = 1;
//	_swipeView.truncateFinalPage = YES;
	
	_swipeView.delegate = self;
	_swipeView.dataSource = self;
	
	NSString *path = [[NSBundle mainBundle] pathForResource:@"firtTimeType" ofType:@"plist"];
	self.firstDoThings = [NSArray arrayWithContentsOfFile:path];
}

- (void)publishItemAction {
    // todo upload server record data
	
    [self createTimelineWithText:textView.text images:_willPublishImages];
}

- (void)createTimelineWithText:(NSString *)text images:(NSArray *)images {
    if (text == nil) {
        text = @"";
    }

    NSMutableArray *imageFileMa = [NSMutableArray array];
    for (int i = 0; i < images.count; i++) {
        // 得到图片
        ALAsset *asset = images[i];
        ALAssetRepresentation *rep = [asset defaultRepresentation];
        CGImageRef fullResImage = [rep fullResolutionImage];
        UIImage *image = [UIImage imageWithCGImage:fullResImage
                                             scale:[rep scale]
                                       orientation:(UIImageOrientation) [rep orientation]];
        // 保存图片
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
        AVFile *imageFile = [AVFile fileWithName:@"share_image.jpeg" data:imageData];
        [imageFile save];
        [imageFileMa addObject:imageFile];
    }
    
    // 保存一条记录
    LCTimelineModel *timelineModel = [LCTimelineModel object];
    timelineModel.shareMsg = text;
    timelineModel.recordObj = 1;
    timelineModel.happenTime = [NSDate date];
    timelineModel.shareImages = imageFileMa;
    timelineModel.isDeleted = NO;
    timelineModel.author = [YIUserModel currentUser]; // todo ...
    [timelineModel saveInBackground];
}

- (void)backItemAction {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text; {

    return true;
}

#pragma mark - 浏览图片

- (void)previewImage:(UITapGestureRecognizer *)tap {
//    CTAssetsPageViewController *vc = [[CTAssetsPageViewController alloc] initWithAllPictures:self.allPictures];
//    vc.pageIndex = tap.view.tag - kPictureTagBaseValue;
//    vc.isDeletable = YES;
//    vc.dataSource2 = self;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadImage:(UITapGestureRecognizer *)tap {
	//    CTAssetsPageViewController *vc = [[CTAssetsPageViewController alloc] initWithAllPictures:self.allPictures];
	//    vc.pageIndex = tap.view.tag - kPictureTagBaseValue;
	//    vc.isDeletable = YES;
	//    vc.dataSource2 = self;
	//    [self.navigationController pushViewController:vc animated:YES];
	
	UIActionSheet *publishAs = [[UIActionSheet alloc] initWithTitle:NULL
														   delegate:self
												  cancelButtonTitle:@"取消"
											 destructiveButtonTitle:NULL
												  otherButtonTitles:@"拍照", @"从手机相册选择", nil];
	[publishAs showInView:[mAppDelegate window]];
}

- (void)tapTimeViewAction:(UITapGestureRecognizer *)tap {
	YIRecordTimeViewController *vc = [[YIRecordTimeViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)tapRoleViewAction:(UITapGestureRecognizer *)tap {
	YIFamilyListViewController *vc = [[YIFamilyListViewController alloc] init];
	[self.navigationController pushViewController:vc animated:YES];
}

- (void)tapLocalViewAction:(UITapGestureRecognizer *)tap {
	
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex; {
	if (buttonIndex == 0) { // 拍照
		
	} else if (buttonIndex == 1) { // 从手机相册选择
		[self loadPickerVc];
	}
}

#pragma mark -

- (NSInteger)numberOfItemsInSwipeView:(SwipeView *)swipeView
{
	NSUInteger count = _firstDoThings.count;
	float items = count / 9.f;
	int finalItems =(int) ceil(items);
	return finalItems;
}

- (UIView *)swipeView:(SwipeView *)swipeView viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
	YIFirstDoItemView *itemView = nil;
	if (!view) {
		view = [[UIView alloc] initWithFrame:swipeView.bounds];
		itemView = [[YIFirstDoItemView alloc] initWithFrame:view.bounds];
		itemView.delegate = self;
		itemView.tag = 2001;
		[view addSubview:itemView];
		
	} else {
		itemView = (YIFirstDoItemView *)[view viewWithTag:2001];
	}
	
	int len = 9 * (index + 1) <= _firstDoThings.count ? 9 : _firstDoThings.count % 9;
	NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(9 * index, len)];
	NSArray *array = [_firstDoThings objectsAtIndexes:indexSet];
	[itemView setupItemBtn:array];
	
	return view;
}

- (CGSize)swipeViewItemSize:(SwipeView *)swipeView {
	return CGSizeMake(swipeView.width, swipeView.height);
}

- (void)swipeViewCurrentItemIndexDidChange:(SwipeView *)swipeView; {
//	_headerView.pageControl.currentPage = swipeView.currentPage;
}

#pragma mark - YIFirstDoItemViewDelegate

- (void)firstDoThingSelectedIndex:(NSUInteger)index text:(NSString *)text; {
	NSString *title = [NSString stringWithFormat:@"第一次%@",text];
	[firstDoBtn setTitle:title forState:UIControlStateNormal];
	
	[firstDoBtn setTitleColor:[UIColor oliveColor] forState:UIControlStateNormal];
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
	
//	YIPublishVc *publishVc = [[YIPublishVc alloc] init];
//	publishVc.willPublishImages = assets;
//	YIBaseNavigationController *bnc = [[YIBaseNavigationController alloc] initWithRootViewController:publishVc];
//	[self presentViewController:bnc animated:YES completion:NULL];
	
	_willPublishImages = assets;
	[self photosView];
	
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

	return true;
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
