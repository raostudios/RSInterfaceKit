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

-(CGRect) rectForInitialImageForView:(UIView * _Nonnull)view forFullImageViewController:(FullImageViewController * _Nonnull)fullImageViewController;
-(UIImageView * _Nonnull) initialImageViewForFullImageViewController:(FullImageViewController * _Nonnull)fullImageViewController;
-(UIImage * _Nonnull) initialImageForFullImageViewController:(FullImageViewController *_Nonnull)fullImageViewController;

@end

@interface FullImageViewController : UIViewController

@property (nonatomic) UIImage * _Nonnull image;
@property (nonatomic, weak) id<FullImageViewControllerDelegate> _Nullable delegate;

@end
