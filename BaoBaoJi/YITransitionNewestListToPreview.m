//
//  DSLTransitionFromFirstToSecond.m
//  TransitionExample
//
//  Created by Pete Callaway on 21/07/2013.
//  Copyright (c) 2013 Dative Studios. All rights reserved.
//

#import "YITransitionNewestListToPreview.h"

#import "YIPhotoPreviewViewController.h"
#import "YIBbjVc.h"

@implementation YITransitionNewestListToPreview

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    YIBbjVc *fromViewController = (YIBbjVc*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    YIPhotoPreviewViewController *toViewController = (YIPhotoPreviewViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	
    UIView *containerView = [transitionContext containerView];
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    UIView *curPage = [fromViewController.baseCollectionView cellForItemAtIndexPath:toViewController.curIndexPath];
    __block UIView *fromView = [curPage snapshotViewAfterScreenUpdates:NO];
    fromView.frame = [containerView convertRect:curPage.frame fromView:curPage.superview];

    UIView *toView = toViewController.view;
    toView.frame = [transitionContext finalFrameForViewController:toViewController];
    toView.hidden = YES;
    
    [containerView addSubview:toView];
    [containerView addSubview:fromView];
    
    [UIView animateWithDuration:duration animations:^{
        
        fromView.frame = toView.frame;
        
    } completion:^(BOOL finished) {
        
        [fromView removeFromSuperview];
        fromView = nil;
        toView.hidden = NO;
        
        // Declare that we've finished
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.3f;
}

@end
