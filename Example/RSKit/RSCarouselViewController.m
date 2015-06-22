//
//  RSCarouselViewController.m
//  RSInterfaceKit
//
//  Created by Venkat Rao on 6/17/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "RSCarouselViewController.h"
#import <RSInterfaceKit/RSCarouselView.h>

@interface RSCarouselViewController () <RSCarouselViewDataSource>

@property (nonatomic, strong) RSCarouselView *view;

@end

@implementation RSCarouselViewController

@dynamic view;

- (void)loadView {
    self.view = [[RSCarouselView alloc] initWithFrame:CGRectZero];
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    self.view.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view start];
}

#pragma mark - RSCarouselViewDataSource

-(NSInteger) numberOfItemsInCarouselView:(RSCarouselView *)carouselView {
    return 2;
}
-(void) configureCell:(UICollectionViewCell *)cell InCarouselView:(RSCarouselView *)carouselView atIndex:(NSUInteger)index {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[self imageForIndex:index]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.translatesAutoresizingMaskIntoConstraints = NO;
    [cell.contentView addSubview:imageView];
    
    [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[imageView]|" options:0 metrics:nil views:@{@"imageView": imageView}]];
    [cell.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[imageView]|" options:0 metrics:nil views:@{@"imageView": imageView}]];
    
}

#pragma mark - Private Methods

- (UIImage *) imageForIndex:(NSUInteger)index {
    switch (index) {
        case 0:
            return [UIImage imageNamed:@"bandH"];
            break;
        case 1:
            return [UIImage imageNamed:@"yosemite"];
            break;
        default:
            break;
    }
    return nil;
}



@end
