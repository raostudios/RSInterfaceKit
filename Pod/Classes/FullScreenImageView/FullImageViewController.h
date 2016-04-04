//
//  ImageViewController.h
//  Chrytotype
//
//  Created by Rao, Venkat on 11/19/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FullImageViewController;

@protocol FullImageViewControllerDelegate <NSObject>

-(CGRect) rectForInitialImageForView:(UIView *)view forFullImageViewController:(FullImageViewController *)fullImageViewController;
-(UIImageView *) initialImageViewForFullImageViewController:(FullImageViewController *)fullImageViewController;
-(UIImage *) initialImageForFullImageViewController:(FullImageViewController *)fullImageViewController;

@end

@interface FullImageViewController : UIViewController

@property (nonatomic) UIImage *image;
@property (nonatomic, weak) id<FullImageViewControllerDelegate> delegate;

@end
