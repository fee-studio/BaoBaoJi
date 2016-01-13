//
//  DSLTransitionFromSecondToFirst.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "YITransitionPreviewToNewestList.h"

#import "YIPhotoPreviewViewController.h"
#import "YINewestListLayout.h"
#import "YIBbjVc.h"

@implementation YITransitionPreviewToNewestList

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    YIPhotoPreviewViewController *fromViewController = (YIPhotoPreviewViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    YIBbjVc *toViewController = (YIBbjVc*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // 1,拿到 from view & to view
    UIView *fromView = fromViewController.baseCollectionView; // 这里用baseCollectionView不用view是为了不显示工具栏
    UIView *toView = toViewController.view;
    
    // 2,拿到 作动画的view 并初始化正确的frame
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    fromView.frame = fromFrame;
    __block UIView *animationView = [fromView snapshotViewAfterScreenUpdates:NO];
    
    // 5,把toView & 全动画的view加入到containerView 注意顺序
    [containerView addSubview:toView];
    [containerView addSubview:animationView];
    
    // 3,赋值给toView正确的frame,很重要.
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    toViewController.view.frame = toFrame;
    
    // 4,修正toView的UI.显示tabbar & 滚动到指定的位置
    // **** 做点非动画的事情 ****
	toViewController.hidesBottomBarWhenPushed = YES;
    [fromViewController refreshPhotoListViewControllerCellPosition];
    // **** 做点非动画的事情 ****
    
    // 6,计算目标位置
    CGRect targetFrame = CGRectZero;
    CGRect toFrame2 = toViewController.view.frame; // 再拿到经过第4步修正后toViewController.view的frame
//    YINewestListLayout *layout = (YIBbjVc *)toViewController.baseCollectionView.collectionViewLayout;
//    CGFloat x = floorf((fromViewController.curIndexPath.item % 3) * (layout.itemSize.width+layout.minimumInteritemSpacing));
//    // int y = toFrame2.size.height + toFrame2.origin.y - layout.itemSize.height; // 滚动到底时用这个
//    CGFloat y = floorf((toFrame2.size.height - layout.itemSize.height)/2.f + toFrame2.origin.y); // 滚动到垂直居中用这个. // TODO: 最前和最后两排可能要做处理.
//    CGFloat w = layout.itemSize.width;
//    CGFloat h = layout.itemSize.height;
//    
//    targetFrame = CGRectMake(x, y, w, h);
	
    // 7,最后作动画
    [UIView animateWithDuration:duration animations:^{
        animationView.frame = targetFrame;
    } completion:^(BOOL finished) {
        
        [animationView removeFromSuperview];
        animationView = nil;
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
