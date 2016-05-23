//
//  RSZoomImageToImageViewController.m
//  RSInterfaceKit
//
//  Created by Venkat Rao on 7/19/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "RSZoomImageToImageViewController.h"
#import <RSInterfaceKit/RSZoomableImageView.h>


@interface RSZoomImageToImageViewController ()

@property (nonatomic, strong) RSZoomableImageView *imageView;

@end

@implementation RSZoomImageToImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.imageView = [[RSZoomableImageView alloc] initWithFrame:CGRectZero];
    self.imageView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self.view addSubview:self.imageView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"imageView": self.imageView}]];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:@{@"imageView": self.imageView}]];
    
    [self.imageView updateImage:[UIImage imageNamed:@"yosemite"] shouldUpdateFrame:YES];
}

@end
