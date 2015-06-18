//
//  RSImageCarouselExampleViewController.m
//  RSInterfaceKit
//
//  Created by Venkat Rao on 6/9/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "RSImageCarouselExampleViewController.h"
#import <RSInterfaceKit/RSCarouselImageView.h>


@interface RSImageCarouselExampleViewController ()<RSCarouselImageViewDataSource>

@property (nonatomic, strong) RSCarouselImageView *view;

@end

@implementation RSImageCarouselExampleViewController

@dynamic view;

-(void)loadView {
    self.view = [[RSCarouselImageView alloc] initWithFrame:CGRectZero];
    self.view.contentMode = UIViewContentModeScaleAspectFill;
}

#pragma mark - View Controller Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.dataSource = self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.view start];
}

#pragma mark - RSCarouselImageViewDataSource

- (NSInteger) numberOfItemsInCarouselView:(RSCarouselImageView *)carouselView {
    return 2;
}

- (UIImage *) imageInCarouselView:(RSCarouselImageView *)carouselView atIndex:(NSUInteger)index {
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
