//
//  RSWebViewController.m
//  RSInterfaceKit
//
//  Created by Venkat Rao on 1/25/16.
//  Copyright © 2016 Venkat Rao. All rights reserved.
//

#import "RSWebViewController.h"

@import WebKit;

@interface RSWebViewController ()

@property (strong, nonatomic) WKWebView *view;

@end

@implementation RSWebViewController

@dynamic view;

-(void)loadView {
    self.view = [[WKWebView alloc] init];
}

-(void) loadURL:(NSURL *)url {
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
    [self.view loadRequest:urlRequest];
}

@end
