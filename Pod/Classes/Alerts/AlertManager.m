//
//  AlertManger.m
//  TheBigClock
//
//  Created by Rao, Venkat on 3/4/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "AlertManager.h"
#import "AlertView.h"
#import "Alert.h"

@interface AlertManager()<AlertViewDelegate>

@property (weak, nonatomic) AlertView *alertView;
@property (strong, nonatomic) Alert *currentAlert;

@property (strong, nonatomic) NSMutableArray *alertsDisplayed;
@property (strong, nonatomic) NSMutableArray *alertsQueued;

@property (strong, nonatomic) NSLayoutConstraint *topConstraint;

@end

@implementation AlertManager

NSString * AlertManagerBannerDisplayedNotification = @"AlertManagerBannerDisplayedNotification";
NSString * AlertManagerBannerDisplayedDismissed = @"AlertManagerBannerDisplayedDismissed";

-(void) showAlertWithMessage:(Alert *)alert withAnimation:(BOOL)animations {
    
    if ([alert.uniqueId length]) {
        if ([self.alertsDisplayed containsObject:alert.uniqueId]) {
            return;
        } else {
            [self.alertsDisplayed addObject:alert.uniqueId];
        }
    }

    AlertView *banner = [[AlertView alloc] initWithFrame:CGRectZero];
    banner.delegate = self;
    UIViewController *topViewController = [self topViewController];
    
    banner.translatesAutoresizingMaskIntoConstraints = NO;

    [topViewController.view addSubview:banner];
    
    [topViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[banner]|"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:@{@"banner": banner}]];
    
    self.topConstraint = [NSLayoutConstraint constraintWithItem:topViewController.topLayoutGuide
                                                      attribute:NSLayoutAttributeBottom
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:banner
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1.0
                                                       constant:40.0];
    
    [topViewController.view addConstraint:self.topConstraint];
    [topViewController.view layoutIfNeeded];
    
    self.topConstraint.constant = 0.0;
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [topViewController.view layoutIfNeeded];
    } completion:nil];
    
    banner.message = alert.message;
    
    __weak typeof(self) weakSelf = self;
    banner.bannerDismissed = ^void() {
        [weakSelf dismissMesssage];
    };
    
    if (alert.seconds > 0) {
        [NSTimer scheduledTimerWithTimeInterval:alert.seconds
                                         target:self
                                       selector:@selector(dismissMesssage)
                                       userInfo:nil
                                        repeats:NO];

    }
    self.currentAlert = alert;
    self.alertView = banner;
}

-(void)alertViewTapped:(AlertView *)alertView {
    if (self.currentAlert.actionOnTap) {
        self.currentAlert.actionOnTap();
    }
}

-(void) dismissMesssage {
    
    self.topConstraint.constant = 40.0;
    [self.alertView setNeedsUpdateConstraints];
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.alertView layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.alertView removeFromSuperview];
        self.alertView = nil;
    }];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:AlertManagerBannerDisplayedDismissed
                                                        object:self.currentAlert];
    
    self.currentAlert = nil;
}

-(UIViewController *) topViewController {
    
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([topViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *) topViewController;
        topViewController = navigationController.topViewController;
    }
    
    return topViewController;
}

#pragma mark - Public API

+(instancetype) sharedManager {
    static AlertManager *alertManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertManager = [AlertManager new];
    });
    return alertManager;
}

-(void) scheduleAlert:(Alert *)alert {
    [self.alertsQueued addObject:alert];
    [self showNextQueuedAlert];
}

-(void) showNextQueuedAlert {
    if ([self.alertsQueued count] != 0) {
        Alert *alert = [self.alertsQueued firstObject];
        [self.alertsQueued removeObjectAtIndex:0];
        if (alert.shouldDisplay) {
            if (alert.shouldDisplay()) {
                [self showAlertWithMessage:alert withAnimation:YES];
            } else {
                if (alert.retry) {
                    [self.alertsQueued addObject:alert];
                }
            }
        } else {
            [self showAlertWithMessage:alert withAnimation:YES];
        }
    }
}

#pragma mark - Lazy Instantiation

-(NSMutableArray *)alertsDisplayed {
    if (!_alertsDisplayed) {
        _alertsDisplayed = [NSMutableArray new];
    }
    return _alertsDisplayed;
}

-(NSMutableArray *)alertsQueued {
    if (!_alertsQueued) {
        _alertsQueued = [NSMutableArray new];
    }
    return _alertsQueued;
}

@end