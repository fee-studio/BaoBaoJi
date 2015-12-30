//
//  YIBabyDetailVc.m
//  BaoBaoJi
//
//  Created by efeng on 15/12/25.
//  Copyright © 2015年 buerguo. All rights reserved.
//

#import "YIBabyDetailVc.h"
#import "CSStickyHeaderFlowLayout.h"
#import "YIBabyDetailCell.h"
#import "YIBabyHeaderView.h"

@interface YIBabyDetailVc ()

@property(nonatomic, strong) NSArray *babyDetails;
@property(nonatomic, strong) LCBabyEntity *curBaby;


@end


@implementation YIBabyDetailVc

- (instancetype)init {
    self = [super init];
    if (self) {

    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.curBaby = mGlobalData.curBaby;

    [self loadCollectionData];
	
    // 注册 UICollectionView
    [self.baseCollectionView registerNib:[YIBabyDetailCell cellNib]
              forCellWithReuseIdentifier:NSStringFromClass([YIBabyDetailCell class])];

	[self reloadLayout];
	
//	[self.baseCollectionView registerNib:[YIBabyHeaderView viewNib]
//			  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
//					 withReuseIdentifier:NSStringFromClass([YIBabyHeaderView class])];
	
    [self.baseCollectionView reloadData];
}

- (void)loadCollectionData {
	self.babyDetails = @[
			@{
                    @"title" : @"小名",
                    @"content" : @"",
					@"detail" : _curBaby.nickName?:@""
            },
            @{
                    @"title" : @"性别",
                    @"content" : @"",
                    @"detail" : @(_curBaby.sex)?[@(_curBaby.sex) stringValue]:@""
            },
            @{
                    @"title" : @"生日",
                    @"content" : @"",
                    @"detail" : [_curBaby.birthday convertDateToStringWithFormat:@"yyyy年MM月dd日"]?:@""
            },
            @{
                    @"title" : @"血型",
                    @"content" : @"",
                    @"detail" : @(_curBaby.blood)? [@(_curBaby.blood) stringValue]:@""
            },
            @{
                    @"title" : @"出生时刻",
                    @"content" : @"",
                    @"detail" : _curBaby.birthTime?:@""
            },
            @{
                    @"title" : @"身高",
                    @"content" : @"",
                    @"detail" : @(_curBaby.height)?[@(_curBaby.height) stringValue]:@""
            },
            @{
                    @"title" : @"体重",
                    @"content" : @"",
                    @"detail" : @(_curBaby.weight)?[@(_curBaby.weight) stringValue]:@""
            },
    ];
}

- (void)reloadLayout {
	UINib *headerNib = [YIBabyHeaderView viewNib]; // [UINib nibWithNibName:@"YIBabyHeaderView" bundle:nil];
    [self.baseCollectionView registerNib:headerNib
              forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                     withReuseIdentifier:@"header"];

    CSStickyHeaderFlowLayout *layout = [CSStickyHeaderFlowLayout new];
    layout.parallaxHeaderReferenceSize = CGSizeMake(mScreenWidth, 150);
    layout.itemSize = CGSizeMake(mScreenWidth, 150);
    // If we want to disable the sticky header effect
    layout.disableStickyHeaders = YES;
	
    self.baseCollectionView.collectionViewLayout = layout;
}

#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _babyDetails.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    YIBabyDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([YIBabyDetailCell class])
                                                                       forIndexPath:indexPath];
    NSDictionary *detail = _babyDetails[indexPath.row];
    [cell setupCell:detail];
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
        YIBabyHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                    withReuseIdentifier:NSStringFromClass([YIBabyHeaderView class])
                                                                           forIndexPath:indexPath];
        return view;
    } else {
        return nil;
    }
}


#pragma mark -  UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section; {
//	return CGSizeMake(mScreenWidth, 20.f);
//}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(mScreenWidth, 44);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsZero;
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
