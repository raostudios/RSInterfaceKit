//
//  ImageViewController.m
//  Chrytotype
//
//  Created by Rao, Venkat on 11/19/14.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import "FullImageViewController.h"
#import "FullImageView.h"
#import "ZoomAnimator.h"
#import "RSZoomableImageView.h"

@interface FullImageViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentInteractionControllerDelegate, ZoomAnimatorDelegate>

@property (strong, nonatomic) FullImageView *view;
@property (strong, nonatomic) ZoomAnimator *zoomAnimator;

@end

@implementation FullImageViewController

@dynamic view;

-(void) loadView {
    self.view = [[FullImageView alloc] initWithFrame:CGRectZero];
}

-(void) viewDidLoad {
    [super viewDidLoad];

    [self.view.buttonDone addTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view shouldShowButtons:NO];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:gesture];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view.buttonDone
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.bottomLayoutGuide
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(imageTapped:)];
    [self.view.scrollView addGestureRecognizer:tapGesture];
}

-(BOOL) prefersStatusBarHidden {
    return YES;
}

-(void) viewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view flipWithAnimation:YES];
}

-(void) imageTapped:(UITapGestureRecognizer *) gesture {
    [self.view animateBackToOriginalWithCompletion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void) donePressed:(UIButton *)sender {
    [self.view animateBackToOriginalWithCompletion:^{
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void) setImage: (UIImage *)image {
    self.view.scrollView.image = image;
}

-(UIImage *)image {
    return self.view.scrollView.image;
}

-(void)setDelegate:(id<FullImageViewControllerDelegate>)delegate {
    _delegate = delegate;
    self.transitioningDelegate = self.zoomAnimator;
}

-(CGRect) rectForInitialImageForView:(UIView *)view forFullImageViewController:(ZoomAnimator *)zoomAnimator {
    return [self.delegate rectForInitialImageForView:view forFullImageViewController:self];
}

-(UIImageView *) initialImageViewForFullImageViewController:(ZoomAnimator *)zoomAnimator {
    return [self.delegate initialImageViewForFullImageViewController:self];
}

-(UIImage *) initialImageForFullImageViewController:(ZoomAnimator *)zoomAnimator {
    return [self.delegate initialImageForFullImageViewController:self];
}


-(ZoomAnimator *) zoomAnimator {
    if (!_zoomAnimator) {
        _zoomAnimator = [ZoomAnimator new];
        _zoomAnimator.delegate = self;
    }
    return _zoomAnimator;
}

@end
