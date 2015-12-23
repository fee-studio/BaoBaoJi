//
// Created by efeng on 15/11/8.
// Copyright (c) 2015 buerguo. All rights reserved.
//

#import "YIBaseCollectionViewController.h"
#import "YIBaseCollectionViewCell.h"

@implementation YIBaseCollectionViewController {

}

- (void)viewDidLoad {
    [super viewDidLoad];
	self.edgesForExtendedLayout = UIRectEdgeAll;
    // 初始化
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//	flowLayout.minimumLineSpacing = 1.f;
    self.baseCollectionView = [[UICollectionView alloc] initWithFrame:mScreenBounds collectionViewLayout:flowLayout];
    _baseCollectionView.delegate = self;
    _baseCollectionView.dataSource = self;
    _baseCollectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:_baseCollectionView];
    [_baseCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    //注册
    [_baseCollectionView registerClass:[YIBaseCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([YIBaseCollectionViewCell class])];
    // 刷新数据
    [_baseCollectionView reloadData];
    
    // 上下拉刷新
    _baseCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefreshing)];
    [_baseCollectionView.mj_header beginRefreshing];
    
    _baseCollectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRefreshing)];
    _baseCollectionView.mj_footer.hidden = YES;
	
	
	if (self.rdv_tabBarController.tabBar.translucent) {
		CGFloat tabBarHeight = CGRectGetHeight(self.rdv_tabBarController.tabBar.frame);
		UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, tabBarHeight, 0);
		
		_baseCollectionView.contentInset = insets;
		_baseCollectionView.scrollIndicatorInsets = insets;
	}
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [YILogUtil logFrameOfView:_baseCollectionView andName:@"_baseCollectionView"];
}

#pragma mark - 上下拉刷新

- (void)headerRefreshing {
    
}

- (void)footerRefreshing {
    
}


#pragma mark -  UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}

#pragma mark -  UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

}

#pragma mark  - UICollectionViewDelegateFlowLayout



@end