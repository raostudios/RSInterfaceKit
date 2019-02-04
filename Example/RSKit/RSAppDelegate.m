//
//  RSAppDelegate.m
//  RSKit
//
//  Created by CocoaPods on 04/14/2015.
//  Copyright (c) 2014 Venkat Rao. All rights reserved.
//

#import "RSAppDelegate.h"
#import "RSInterfaceKitLibraryViewController.h"
#import "RSAlertView.h"

@implementation RSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    RSInterfaceKitLibraryViewController *viewController = [[RSInterfaceKitLibraryViewController alloc] init];
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    UISplitViewController *splitViewController = [[UISplitViewController alloc] init];
    splitViewController.viewControllers = @[navigationController];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = splitViewController;
    [self.window makeKeyAndVisible];
    
    [[RSAlertView appearance] setUserBackgroundColor:[UIColor greenColor]];
    [[RSAlertView appearance] setTextColor:[UIColor whiteColor]];
    
    return YES;
}

@end
