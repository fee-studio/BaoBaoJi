//
//  YIBbjDetailVc.m
//  BaoBaoJi
//
//  Created by efeng on 16/1/14.
//  Copyright © 2016年 buerguo. All rights reserved.
//

#import "YIBbjDetailVc.h"
#import "YIBbjCell.h"
#import "IDMPhotoBrowser.h"

@interface YIBbjDetailVc () <IDMPhotoBrowserDelegate, YIBbjCellDelegate>
{
	YIBbjCell *mainView;
	
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation YIBbjDetailVc

- (instancetype)init {
	self = [super init];
	if (self) {
		self.hidesBottomBarWhenPushed = YES;
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	mainView = [[YIBbjCell alloc] init];
	mainView.numbersOfLine = 1;
	mainView.delegate = self;
	[mainView setupCell:_timeline];
	[_scrollView addSubview:mainView];
	[mainView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.left.equalTo(_scrollView);
		make.right.equalTo(_scrollView);
		make.top.equalTo(_scrollView);
		make.size.mas_equalTo([self sizeForCell]);
	}];
	
	[_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
		make.bottom.equalTo(mainView);
	}];	
}

- (CGSize)sizeForCell {
	CGSize size = CGSizeMake(mScreenWidth, mScreenWidth);
	NSLayoutConstraint *tempConstraint = [NSLayoutConstraint
										  constraintWithItem:mainView.contentView
										  attribute:NSLayoutAttributeWidth
										  relatedBy:NSLayoutRelationEqual
										  toItem:nil
										  attribute:NSLayoutAttributeNotAnAttribute
										  multiplier:1
										  constant:mScreenWidth];
	[mainView.contentView addConstraint:tempConstraint];
	size  = [mainView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
	[mainView.contentView removeConstraint:tempConstraint];
	
	return size;
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

#pragma mark - IDMPhotoBrowserDelegate

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
