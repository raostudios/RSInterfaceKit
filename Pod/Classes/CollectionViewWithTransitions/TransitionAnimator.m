//
//  TransitionAnimator.m
//  CollectionViewTest
//
//  Created by Venkat Rao on 8/4/15.
//  Copyright (c) 2015 Rao Studios. All rights reserved.
//

#import "TransitionAnimator.h"
#import "CollectionViewWithTransitions.h"

@implementation TransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return .3;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    __block NSUInteger index = 0;
    
    UICollectionViewController *toViewController = (UICollectionViewController*)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UICollectionViewController *fromViewController = (UICollectionViewController*)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UICollectionViewFlowLayout *toLayout = (UICollectionViewFlowLayout*) toViewController.collectionView.collectionViewLayout;
    UICollectionViewFlowLayout *currentLayout = (UICollectionViewFlowLayout*) fromViewController.collectionView.collectionViewLayout;
    
    fromViewController.view.alpha = 0.0;
    
    NSIndexPath *selectedIndexPath = [[fromViewController.collectionView indexPathsForSelectedItems] firstObject];
    
    UIView *inView = [transitionContext containerView];
    
    if (self.presenting) {
        
        for (UICollectionViewCell *cell in [fromViewController.collectionView visibleCells]) {
            
            NSIndexPath *indexPath = [fromViewController.collectionView indexPathForCell:cell];
            
            UIView *snapshot = [cell snapshotViewAfterScreenUpdates:YES];
            [inView insertSubview:snapshot aboveSubview:fromViewController.view];
            
            UICollectionViewLayoutAttributes *fromAttributes = [currentLayout layoutAttributesForItemAtIndexPath:indexPath];
            
            CGRect frame = [inView convertRect:fromAttributes.frame fromView:fromViewController.collectionView];
            snapshot.frame = frame;
            
            
            if (indexPath.item == selectedIndexPath.item) {
                snapshot.layer.zPosition = 100;
            }
            index++;
            
            [inView addSubview:toViewController.view];
            toViewController.view.alpha = 0.0;
            
            if (!selectedIndexPath) {
                
                if (fromViewController.collectionView.contentOffset.y <= 0.0) {
                    selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
                } else {
                    selectedIndexPath = [fromViewController.collectionView indexPathForItemAtPoint:CGPointMake(CGRectGetMidX(fromViewController.view.bounds),
                                                                                                               fromViewController.collectionView.contentOffset.y + CGRectGetMidY(fromViewController.view.bounds))];
                    [toViewController.collectionView scrollToItemAtIndexPath:selectedIndexPath
                                                            atScrollPosition:UICollectionViewScrollPositionCenteredVertically
                                                                    animated:NO];
                }
            }
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 
                                 snapshot.frame = CGRectMake(0,
                                                             0,
                                                             toLayout.itemSize.width,
                                                             toLayout.itemSize.width);
                                 
                                 if (selectedIndexPath.item != 0) {
                                     snapshot.center = toViewController.view.center;
                                 }
                                 
                                 if (selectedIndexPath.item == [toViewController.collectionView numberOfItemsInSection:0] - 1) {
                                     snapshot.frame = CGRectMake(CGRectGetMinX(snapshot.frame),
                                                                 CGRectGetMaxY(toViewController.view.frame) - CGRectGetHeight(snapshot.frame),
                                                                 CGRectGetWidth(snapshot.frame),
                                                                 CGRectGetHeight(snapshot.frame));
                                 }
                                 
                                 snapshot.center = CGPointMake(snapshot.center.x,
                                                               snapshot.center.y + (indexPath.item - selectedIndexPath.item) * (CGRectGetWidth([UIScreen mainScreen].bounds) + currentLayout.minimumLineSpacing) + toViewController.collectionView.contentInset.top);
                                 
                             } completion:^(BOOL finished) {
                                 [snapshot removeFromSuperview];
                                 
                                 index--;
                                 if (index == 0) {
                                     toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
                                     toViewController.view.alpha = 1.0;
                                     [transitionContext completeTransition:finished];
                                 }
                             }];
        }
    } else {
        for (UICollectionViewCell *cell in [toViewController.collectionView visibleCells]) {
            
            NSIndexPath *indexPath = [toViewController.collectionView indexPathForCell:cell];
            
            UIView *snapshot;
            UICollectionViewLayoutAttributes *attributes;
            
            for (UICollectionViewCell *selectCell in [fromViewController.collectionView visibleCells]) {
                if (indexPath.item == [fromViewController.collectionView indexPathForCell:selectCell].item) {
                    attributes = [fromViewController.collectionViewLayout layoutAttributesForItemAtIndexPath:[fromViewController.collectionView indexPathForCell:selectCell]];
                    snapshot = [selectCell snapshotViewAfterScreenUpdates:YES];
                }
            }
            
            if (!snapshot) {
                snapshot = [cell snapshotViewAfterScreenUpdates:YES];
            }
            
            [inView insertSubview:snapshot aboveSubview:fromViewController.view];

            
            if (attributes) {
                CGRect frame = [inView convertRect:attributes.frame fromView:fromViewController.collectionView];
                snapshot.frame = frame;
            } else {
                snapshot.frame = CGRectMake(0, 0,
                                            currentLayout.itemSize.width,
                                            currentLayout.itemSize.height);
                
                if (selectedIndexPath.item != 0) {
                    snapshot.center = toViewController.view.center;
                }
                
                snapshot.center = CGPointMake(snapshot.center.x,
                                              snapshot.center.y + (indexPath.item - selectedIndexPath.item) * (CGRectGetWidth([UIScreen mainScreen].bounds) + currentLayout.minimumLineSpacing) + 64);
                
                CGRect frame = [inView convertRect:snapshot.frame
                                          fromView:fromViewController.collectionView];
                snapshot.frame = frame;
            }
            
            if (indexPath.item == selectedIndexPath.item) {
                snapshot.layer.zPosition = 100;
            }
            
            index++;
            
            [UIView animateWithDuration:[self transitionDuration:transitionContext]
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 CGRect frame = [toLayout layoutAttributesForItemAtIndexPath:indexPath].frame;
                                 snapshot.frame = [toViewController.view convertRect:frame fromView:toViewController.collectionView];
                             } completion:^(BOOL finished) {
                                 
                                 [snapshot removeFromSuperview];

                                 
                                 index--;
                                 if (index == 0) {
                                     toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
                                     [inView addSubview:toViewController.view];
                                     toViewController.view.alpha = 1.0;
                                     [transitionContext completeTransition:finished];
                                 }
                             }];
        }
    }
}

@end
