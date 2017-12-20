//
//  ZoomAnimator.h
//  Chrytotype
//
//  Created by Rao, Venkat on 11/19/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZoomAnimator;

@protocol ZoomAnimatorDelegate <NSObject>

-(CGRect) rectForInitialImageForView:(UIView * _Nonnull)view forFullImageViewController:(ZoomAnimator * _Nonnull)zoomAnimator;
-(UIEdgeInsets) insetForFinalImageForView:(UIView * _Nonnull)view forFullImageViewController:(ZoomAnimator * _Nonnull)zoomAnimator;

-(UIImageView * _Nonnull) initialImageViewForFullImageViewController:(ZoomAnimator * _Nonnull)zoomAnimator;
-(UIImage * _Nonnull) initialImageForFullImageViewController:(ZoomAnimator * _Nonnull)zoomAnimator;

-(void)didDismissAnimator:(ZoomAnimator *_Nonnull)zoomAnimator;

@end

@interface ZoomAnimator : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) id<ZoomAnimatorDelegate> _Nullable delegate;

@end
