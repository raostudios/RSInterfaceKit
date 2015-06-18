//
//  RSAlertsExampleViewController.m
//  RSInterfaceKit
//
//  Created by Venkat Rao on 6/9/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "RSAlertsExampleViewController.h"

@interface RSAlertsExampleViewController ()

@end

@implementation RSAlertsExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *buttonUniqueAlert = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonUniqueAlert.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:buttonUniqueAlert];
    [buttonUniqueAlert setTitle:@"Unique Alert" forState:UIControlStateNormal];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonUniqueAlert
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual toItem:buttonUniqueAlert attribute:NSLayoutAttributeTop multiplier:1 constant:0]];

}

@end
