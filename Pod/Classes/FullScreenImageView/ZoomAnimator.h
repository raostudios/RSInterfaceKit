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

-(CGRect) rectForInitialImageForView:(UIView *)view forFullImageViewController:(ZoomAnimator *)zoomAnimator;
-(UIImageView *) initialImageViewForFullImageViewController:(ZoomAnimator *)zoomAnimator;
-(UIImage *) initialImageForFullImageViewController:(ZoomAnimator *)zoomAnimator;

@end

@interface ZoomAnimator : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, weak) id<ZoomAnimatorDelegate> delegate;

@end
