//
//  YIPhotoPreviewViewController.m
//  LoveWallpaper
//
//  Created by efeng on 14-8-19.
//  Copyright (c) 2014年 buerguo. All rights reserved.
//

#import "YIPhotoPreviewViewController.h"
#import "YIPhotoPreviewCell.h"
#import "YIPreviewLayout.h"
#import "YIPhotoListViewController.h"
#import "YITransitionPreviewToNewestList.h"
#import "YITransitionPreviewToPhotoList.h"
#import "YINewestListViewController.h"
#import "LeveyTabBarController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "UMSocial.h"
#import "UIView+PartialRoundedCorner.h"


@interface YIPhotoPreviewViewController () <UINavigationControllerDelegate,UIScrollViewDelegate,UMSocialUIDelegate> {
    
    BOOL isHidden;
}

@property (nonatomic, weak) UIButton *myBackBtn;
@property (nonatomic, weak) UIView *myToolView;

@end

@implementation YIPhotoPreviewViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.baseCollectionView registerClass:[YIPhotoPreviewCell class] forCellWithReuseIdentifier:@"PreviewCell"];
    self.baseCollectionView.pagingEnabled = YES;
    self.baseCollectionView.showsHorizontalScrollIndicator = NO;
	self.baseCollectionView.showsVerticalScrollIndicator = NO;
	self.baseCollectionView.backgroundColor = [UIColor whiteColor];
    
    YIPreviewLayout *automationLayout = (YIPreviewLayout *)self.baseCollectionView.collectionViewLayout;
    [automationLayout registerClass:[YIPhotoPreviewCell class]  forDecorationViewOfKind:@"FloorPlan"];
    
    [self setupToolView];
}

// 加载工具栏
- (void)setupToolView {
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 40, 60, 40);
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    backBtn.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setCornerRadius:10 direction:UIViewPartialRoundedCornerDirectionRight];
    [self.view addSubview:backBtn];
    
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, mScreenHeight - 44, mScreenWidth, 44)];
    toolView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
    [self.view addSubview:toolView];
    
    UIButton *downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    downloadBtn.frame = CGRectMake(0, 0, mScreenWidth/3, 44);
    [downloadBtn setTitle:@"保存" forState:UIControlStateNormal];
    downloadBtn.backgroundColor = [UIColor clearColor];
    [downloadBtn addTarget:self action:@selector(downloadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:downloadBtn];
    
    UIButton *previewBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    previewBtn.frame = CGRectMake(mScreenWidth/3, 0, mScreenWidth/3, 44);
    [previewBtn setTitle:@"预览" forState:UIControlStateNormal];
    previewBtn.backgroundColor = [UIColor clearColor];
    [previewBtn addTarget:self action:@selector(previewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:previewBtn];
    
    UIButton *shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    shareBtn.frame = CGRectMake(mScreenWidth/3*2, 0, mScreenWidth/3, 44);
    [shareBtn setTitle:@"分享" forState:UIControlStateNormal];
    shareBtn.backgroundColor = [UIColor clearColor];
    [shareBtn addTarget:self action:@selector(shareBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:shareBtn];
    
    _myBackBtn = backBtn;
    _myToolView = toolView;
    
    
    _myBackBtn.alpha = 0;
    _myToolView.alpha = 0;
    
    CGRect rect = _myToolView.frame;
    rect.origin.y += rect.size.height;
    _myToolView.frame = rect;
    
    isHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
//    Method original = class_getInstanceMethod([UITabBar class], @selector(actionForLayer:forKey:));
//    Method custom = class_getInstanceMethod([UITabBar class], @selector(customActionForLayer:forKey:));
//    
//    class_replaceMethod([UITabBar class], @selector(actionForLayer:forKey:), method_getImplementation(custom), method_getTypeEncoding(custom));
//    class_addMethod([UITabBar class], @selector(defaultActionForLayer:forKey:), method_getImplementation(original), method_getTypeEncoding(original));
    
    // 显示工具栏
    [self setToolViewHidden:NO animated:animated];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:YES];
    
    self.navigationController.delegate = self;
    
//    [self setControlsHidden:YES animated:NO];
    
    // Hide or show the toolbar at the bottom of the screen.
    [self.navigationController setToolbarHidden:YES animated:NO]; 
    
    // hide status bar
	[[UIApplication sharedApplication] setStatusBarHidden:YES];
    
	// hide navigation bar
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
//    [self.leveyTabBarController hidesTabBar:YES animated:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    
//    [self.leveyTabBarController hidesTabBar:NO animated:NO];
//    [self refreshPhotoListViewControllerCellPosition];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    // scrolling here does work,but in viewDidLoad not work!
    [self.baseCollectionView scrollToItemAtIndexPath:_curIndexPath
                                    atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally
                                            animated:NO];
}

#pragma mark - collection data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _photoArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YIPhotoPreviewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PreviewCell" forIndexPath:indexPath];
    [cell setupCell:_photoArray[indexPath.item] andOriSize:_oriSize];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self setToolViewHidden:!isHidden animated:YES];
}

#pragma mark - Delegate 

- (void)refreshPhotoListViewControllerCellPosition {
    
    if (_delegate && [_delegate respondsToSelector:@selector(myScrollToItemAtIndexPath:)]) {
        [_delegate myScrollToItemAtIndexPath:_curIndexPath];
    }
}

#pragma mark - UIScrollViewDelegate 
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView; {
    
    if ([scrollView isKindOfClass:[UICollectionView class]]) {
        
        UICollectionView *tmpCV = (UICollectionView *)scrollView;
        _curIndexPath = [tmpCV indexPathForItemAtPoint:tmpCV.contentOffset]; // 有坐标计算当前的indexpath
        [self asynDownloadPhotos];
//        [self refreshPhotoListViewControllerCellPosition];
    }
}
#pragma mark - 工具栏操作
- (void)previewBtnAction:(id)sender {
    
    
    
}

- (void)downloadBtnAction:(id)sender {
    
    YIPhotoPreviewCell *cell = (YIPhotoPreviewCell *)[self.baseCollectionView cellForItemAtIndexPath:_curIndexPath];
    UIImage *image = cell.previewIV.image;
 
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    if (image) {
        [library saveImage:image
                   toAlbum:YI_APP_NAME
       withCompletionBlock:^(NSError *error) {
           if (error) {
               [TSMessage showNotificationWithTitle:@"保存失败"
                                           subtitle:@"    打开图片保存开关:[设置]>[隐私]>[照片]>[壁纸]"
                                               type:TSMessageNotificationTypeWarning];
           } else {
               
               [TSMessage showNotificationWithTitle:@"保存成功" type:TSMessageNotificationTypeSuccess];
           }
       }];
    }
}

- (void)shareBtnAction:(id)sender {
    
    YIPhotoPreviewCell *cell = (YIPhotoPreviewCell *)[self.baseCollectionView cellForItemAtIndexPath:_curIndexPath];
    UIImage *image = cell.previewIV.image;
    
    //注意：分享到微信好友、微信朋友圈、微信收藏、QQ空间、QQ好友、来往好友、来往朋友圈、易信好友、易信朋友圈、Facebook、Twitter、Instagram等平台需要参考各自的集成方法
    
    // 1******************
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:kUmengKey
                                      shareText:@"每分享一次,只为爱心工程捐助一分钱! https://itunes.apple.com/cn/app/hua-jian-ji/id911260002?mt=8"
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,UMShareToQzone,UMShareToWechatTimeline,UMShareToWechatSession,UMShareToWechatFavorite,UMShareToQQ,nil]
                                       delegate:self];
    
    // 2******************
    
//    [[UMSocialControllerService defaultControllerService] setShareText:@"分享内嵌文字" shareImage:[UIImage imageNamed:@"icon"] socialUIDelegate:self];        //设置分享内容和回调对象
//    [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    
    // 3******************
}

#pragma mark - 分享成功回调
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}

#pragma mark - 
- (void)asynDownloadPhotos {
    
    NSInteger preItem = _curIndexPath.item - 1;
    if (preItem >= 0) {
        YIPictureModel *picture = _photoArray[preItem];
        NSURL *url = [YIConfigUtil screenPictureURL:picture.thumb];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
        }];
        
        NSURL *urlSmall = [YIConfigUtil customPictureURL:picture.thumb andSize:kGlobalData.listItemSize];
        [[SDWebImageManager sharedManager] downloadImageWithURL:urlSmall options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
        }];        
    }
    
    NSInteger nextItem = _curIndexPath.item + 1;
    if (nextItem < _photoArray.count) {
        YIPictureModel *picture = _photoArray[nextItem];
        NSURL *url = [YIConfigUtil screenPictureURL:picture.thumb];
        
        [[SDWebImageManager sharedManager] downloadImageWithURL:url options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
        }];
        
        NSURL *urlSmall = [YIConfigUtil customPictureURL:picture.thumb andSize:kGlobalData.listItemSize];
        [[SDWebImageManager sharedManager] downloadImageWithURL:urlSmall options:SDWebImageLowPriority progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            
        }];
    }
}


#pragma mark - 显示隐藏 工具栏
- (void)setToolViewHidden:(BOOL)hidden animated:(BOOL)animated {
    
    if (isHidden == hidden) {
        return;
    }
    
    isHidden = hidden;
    
    CGFloat animationDuration = (animated ? 0.3 : 0);
    CGFloat alpha = isHidden ? 0 : 1;
    CGRect toolViewRect = _myToolView.frame;
    if (isHidden) {
        toolViewRect.origin.y += toolViewRect.size.height;
    } else {
        toolViewRect.origin.y -= toolViewRect.size.height;
    }
    
    [UIView animateWithDuration:animationDuration animations:^{
        
        _myBackBtn.alpha = alpha;
        _myToolView.alpha = alpha;
        _myToolView.frame = toolViewRect;
        
    }];
}

#pragma mark -
- (void)setControlsHidden:(BOOL)hidden animated:(BOOL)animated{

//    BOOL slideAndFade = SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7");
//    CGFloat animatonOffset = 20;
//    CGFloat animationDuration = (animated ? 0.35 : 0);
    
    isHidden = hidden;
    [self prefersStatusBarHidden];
    
    [[UIApplication sharedApplication] setStatusBarHidden:hidden];
    
    if ([self respondsToSelector:@selector(setNeedsStatusBarAppearanceUpdate)]) {
        // iOS 7
        [self performSelector:@selector(setNeedsStatusBarAppearanceUpdate)];
    }
    
    CGFloat alpha = hidden ? 0 : 1;
    
    // Nav bar slides up on it's own on iOS 7
    [self.navigationController.navigationBar setAlpha:alpha];
}

// override
- (BOOL)prefersStatusBarHidden {
    
    return isHidden;
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    // Check if we're transitioning from this view controller to a DSLFirstViewController
    if (fromVC == self) {
        if ([toVC isKindOfClass:[YIPhotoListViewController class]]) {
            return [[YITransitionPreviewToPhotoList alloc] init];
        } else if ([toVC isKindOfClass:[YINewestListViewController class]]) {
            return [[YITransitionPreviewToNewestList alloc] init];
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([viewController isKindOfClass:[YINewestListViewController class]])
	{
//        [self.leveyTabBarController hidesTabBar:NO animated:YES];
	}
}

#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
