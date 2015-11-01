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

@interface FullImageViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIDocumentInteractionControllerDelegate>

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
    // Do any additional setup after loading the view.
    [self.view.buttonDone addTarget:self action:@selector(donePressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view shouldShowButtons:NO];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    [self.view addGestureRecognizer:gesture];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view.buttonDone
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self.topLayoutGuide
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
}

-(BOOL) prefersStatusBarHidden {
    return YES;
}

-(void) viewTapped:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view flipWithAnimation:YES];
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

-(ZoomAnimator *) zoomAnimator {
    if (!_zoomAnimator) {
        _zoomAnimator = [ZoomAnimator new];
        _zoomAnimator.fullImageViewController = self;
    }
    return _zoomAnimator;
}

@end
