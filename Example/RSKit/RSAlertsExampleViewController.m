//
//  RSAlertsExampleViewController.m
//  RSInterfaceKit
//
//  Created by Venkat Rao on 6/9/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "RSAlertsExampleViewController.h"
#import "RSAlertManager.h"
#import "RSAlert.h"
#import "RSWebViewController.h"

@interface RSAlertsExampleViewController ()

@end

@implementation RSAlertsExampleViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *buttonSimpleAlert = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSimpleAlert.translatesAutoresizingMaskIntoConstraints = NO;

    [buttonSimpleAlert addTarget:self
                          action:@selector(showSimpleAlert:)
                forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonSimpleAlert];
    
    [buttonSimpleAlert setTitle:@"Simple Alert"
                       forState:UIControlStateNormal];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonSimpleAlert
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.topLayoutGuide
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:buttonSimpleAlert
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1.0
                                                            constant:0]];
    
    UIButton *buttonUniqueAlert = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonUniqueAlert.translatesAutoresizingMaskIntoConstraints = NO;
    [buttonUniqueAlert addTarget:self action:@selector(showUniqueAlert:)
                forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buttonUniqueAlert];
    [buttonUniqueAlert setTitle:@"Unique Alert" forState:UIControlStateNormal];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonUniqueAlert
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonSimpleAlert
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:buttonUniqueAlert
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
    
    UIButton *buttonTimedAlert = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonTimedAlert.translatesAutoresizingMaskIntoConstraints = NO;
    
    [buttonTimedAlert addTarget:self
                         action:@selector(showTimedAlert:)
               forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:buttonTimedAlert];
    
    [buttonTimedAlert setTitle:@"Timed Alert"
                      forState:UIControlStateNormal];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonTimedAlert
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:buttonUniqueAlert
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:buttonTimedAlert
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0]];
}

-(void) showSimpleAlert:(UIButton *)sender {
    
    RSAlert *alert = [RSAlert new];
    alert.message = @"Test";
    alert.actionOnTap = ^void (void) {
        RSWebViewController *webView = [RSWebViewController new];
        [webView loadURL:[NSURL URLWithString:@"http://www.google.com"]];
        [self.navigationController pushViewController:webView animated:YES];
    };
    
    [[RSAlertManager sharedManager] scheduleAlert:alert];
}

-(void) showUniqueAlert:(UIButton *)sender {
    
    RSAlert *alert = [RSAlert new];
    alert.message = @"Test";
    alert.uniqueId = @"dsfsdf";
    
    [[RSAlertManager sharedManager] scheduleAlert:alert];
}

-(void) showTimedAlert:(UIButton *)sender {
    
    RSAlert *alert = [RSAlert new];
    alert.message = @"Test";
    alert.seconds = 2;
    
    [[RSAlertManager sharedManager] scheduleAlert:alert];
}

@end
