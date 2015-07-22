//
//  RSFullScreenImageTestViewController.m
//  RSInterfaceKit
//
//  Created by Venkat Rao on 6/7/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "RSFullScreenImageTestViewController.h"
#import <RSInterfaceKit/FullImageViewController.h>

@interface RSFullScreenImageTestViewController ()<FullImageViewControllerDelegate>

@property (strong, nonatomic) UIButton *buttonImageToZoom;
@property (strong, nonatomic) FullImageViewController *fullImageViewController;
@end

@implementation RSFullScreenImageTestViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.buttonImageToZoom = [UIButton buttonWithType:UIButtonTypeCustom];
    self.buttonImageToZoom.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.buttonImageToZoom setImage:[UIImage imageNamed:@"bandH"] forState:UIControlStateNormal]
    ;
    [self.view addSubview:self.buttonImageToZoom];
    
    self.buttonImageToZoom.frame = CGRectMake(0, 64, 40, 40);
    [self.buttonImageToZoom addTarget:self action:@selector(fullScreenTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void) fullScreenTapped:(UIButton *)sender {
    self.fullImageViewController = [[FullImageViewController alloc] init];
    self.fullImageViewController.delegate = self;
    [self.fullImageViewController setImage:self.buttonImageToZoom.imageView.image];
    [self presentViewController:self.fullImageViewController animated:YES completion:nil];
}

#pragma mark - FullImageViewControllerDelegate

-(CGRect) rectForInitialImageForView:(UIView *)view forFullImageViewController:(FullImageViewController *)fullImageViewController {
    return self.buttonImageToZoom.frame;
}

-(UIImageView *) initialImageViewForFullImageViewController:(FullImageViewController *)fullImageViewController {
    return self.buttonImageToZoom.imageView;
}

@end
