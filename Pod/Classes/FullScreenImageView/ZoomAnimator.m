//
//  ZoomAnimator.m
//  Chrytotype
//
//  Created by Rao, Venkat on 11/19/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import "ZoomAnimator.h"
#import "FullImageViewController.h"
#import "FullImageView.h"

@interface ZoomAnimator ()<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, getter = isPresenting) BOOL presenting;

@end

@implementation ZoomAnimator

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source {
    self.presenting = YES;
    return self;
}

-(id<UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed {
    self.presenting = NO;
    return self;
}

-(NSTimeInterval) transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    return .2;
}

-(void) animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *container = [transitionContext containerView];
    UIImageView *tempView = [UIImageView new];
    
    UIImageView *initialImageView = [self.delegate initialImageViewForFullImageViewController:self];
    initialImageView.alpha = 0.0;
    tempView.image = [self.delegate initialImageForFullImageViewController:self];
    tempView.contentMode = initialImageView ? initialImageView.contentMode : UIViewContentModeScaleAspectFill;
    
    CGRect initialFrame = CGRectZero;
    CGRect finalFrame = CGRectZero;
    
    if (self.presenting) {
        
        CGRect insideFrame = [self.delegate rectForInitialImageForView:fromViewController.view
                                            forFullImageViewController:self];
        
        UIImage *image = [self.delegate initialImageForFullImageViewController:self];
        
        initialFrame = [self frameForImage:image
                               insideFrame:insideFrame forContentMode:initialImageView.contentMode];
        
        finalFrame = [self frameForImage:image
                             insideFrame:[transitionContext finalFrameForViewController:toViewController]
                          forContentMode:UIViewContentModeScaleAspectFit];
        
        tempView.frame = initialFrame;
        
        [container addSubview:tempView];
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            fromViewController.view.alpha = 0.0;
            tempView.frame = finalFrame;
        } completion:^(BOOL finished) {
            [tempView removeFromSuperview];
            initialImageView.alpha = 1.0;
            toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
            [container addSubview:toViewController.view];
            [transitionContext completeTransition:finished];
        }];
        
    } else {
        
        UIImage *image = [self.delegate initialImageForFullImageViewController:self];
        
        UIViewContentMode mode = initialImageView ? initialImageView.contentMode : UIViewContentModeScaleAspectFill;
        
        if (image) {
            finalFrame = [self frameForImage:image
                                 insideFrame:[self.delegate rectForInitialImageForView:toViewController.view
                                                            forFullImageViewController:self]
                              forContentMode:mode];
            
            initialFrame = [self frameForImage:image
                                   insideFrame:[transitionContext finalFrameForViewController:fromViewController]
                                forContentMode:UIViewContentModeScaleAspectFit];
        }
        
        tempView.frame = initialFrame;
        [container addSubview:tempView];
        
        fromViewController.view.alpha = 0.0;
        toViewController.view.alpha = 0.0;
        
        [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
            tempView.frame = finalFrame;
        } completion:^(BOOL finished) {
            toViewController.view.alpha = 1.0;
            [tempView removeFromSuperview];
            toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
            initialImageView.alpha = 1.0;
            [transitionContext completeTransition:finished];
        }];
    }
}

-(CGRect) frameForImage:(UIImage *)image insideFrame:(CGRect)frame forContentMode:(UIViewContentMode)contentMode {
    NSAssert(image, @"image cannot be nil");
    
    if (contentMode == UIViewContentModeScaleAspectFit) {
        CGFloat imageRatio = image.size.width/image.size.height;
        CGFloat frameRatio = frame.size.width/frame.size.height;
        
        if (imageRatio < frameRatio) {
            CGFloat ratio = image.size.height / frame.size.height;
            frame.origin.x += (frame.size.width - image.size.width / ratio) / 2.0;
            frame.size.width = image.size.width / ratio;
        } else {
            CGFloat ratio = image.size.width/frame.size.width;
            frame.origin.y += (frame.size.height - image.size.height / ratio) / 2.0;
            frame.size.height = image.size.height / ratio;
        }
    } else if (contentMode == UIViewContentModeScaleAspectFill) {
        CGFloat ratio;
        if (image.size.width > image.size.height) {
            ratio = CGRectGetHeight(frame) / image.size.height;
            CGFloat newWidth = image.size.width * ratio;
            frame = CGRectMake((CGRectGetWidth(frame) - newWidth) / 2.0 + CGRectGetMinX(frame),
                               CGRectGetMinY(frame),
                               image.size.width * ratio,
                               image.size.height * ratio);
        } else {
            ratio = CGRectGetWidth(frame) / image.size.width;
            CGFloat newHeight = image.size.height * ratio;
            frame = CGRectMake(CGRectGetMinX(frame),
                               (CGRectGetHeight(frame) - newHeight) / 2.0 + CGRectGetMinY(frame),
                               image.size.width * ratio,
                               image.size.height * ratio);
        }
    }
    
    return frame;
}

@end
