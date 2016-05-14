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

@property (strong, nonatomic) NSTimer *currentTimer;

@end

@implementation AlertManager

NSString * const AlertManagerBannerDisplayedNotification = @"AlertManagerBannerDisplayedNotification";
NSString * const AlertManagerBannerWillDisplayNotification = @"AlertManagerBannerWillDisplayNotification";

NSString * const AlertManagerBannerDismissedNotification = @"AlertManagerBannerDismissedNotification";
NSString * const AlertManagerBannerWillDismissNotification = @"AlertManagerBannerWillDismissNotification";


-(void) showAlertWithMessage:(Alert *)alert withAnimation:(BOOL)animations {
    
    if ([alert.uniqueId length]) {
        [self.alertsDisplayed addObject:alert.uniqueId];
    }
    
    AlertView *banner = [[AlertView alloc] initWithFrame:CGRectZero];
    banner.delegate = self;
    UIViewController *topViewController = [self topViewController];
    
    if (!topViewController) {
        return;
    }
    
    banner.translatesAutoresizingMaskIntoConstraints = NO;
    
    [topViewController.view addSubview:banner];
    
    [topViewController.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[banner]|"
                                                                                   options:0
                                                                                   metrics:nil
                                                                                     views:@{@"banner": banner}]];
    
    self.topConstraint = [NSLayoutConstraint constraintWithItem:topViewController.topLayoutGuide
                                                      attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:banner
                                                      attribute:NSLayoutAttributeBottom
                                                     multiplier:1.0
                                                       constant:0.0];
    
    [topViewController.view addConstraint:self.topConstraint];
    [topViewController.view layoutIfNeeded];
    
    [banner layoutIfNeeded];
    [[NSNotificationCenter defaultCenter] postNotificationName:AlertManagerBannerWillDisplayNotification
                                                        object:nil
                                                      userInfo:@{@"bannerFrame": [NSValue valueWithCGRect:banner.frame],
                                                                 @"alert": alert}];
    
    [topViewController.view removeConstraint:self.topConstraint];
    self.topConstraint = [NSLayoutConstraint constraintWithItem:topViewController.topLayoutGuide
                                                      attribute:NSLayoutAttributeBottom
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:banner
                                                      attribute:NSLayoutAttributeTop
                                                     multiplier:1.0
                                                       constant:0.0];
    [topViewController.view addConstraint:self.topConstraint];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        [topViewController.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        [[NSNotificationCenter defaultCenter] postNotificationName:AlertManagerBannerDisplayedNotification
                                                            object:nil
                                                          userInfo:@{@"bannerFrame": [NSValue valueWithCGRect:banner.frame],
                                                                     @"alert": alert}];
    }];
    
    banner.message = alert.message;
    
    __weak typeof(self) weakSelf = self;
    banner.bannerDismissed = ^void() {
        [weakSelf dismissMesssageWithAnimation:YES withCompletion:^{
            [self showNextQueuedAlert];
        }];
    };
    
    if (alert.seconds > 0) {
        self.currentTimer = [NSTimer scheduledTimerWithTimeInterval:alert.seconds
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
    [self dismissMesssageWithAnimation:YES withCompletion:^{
        [self showNextQueuedAlert];
    }];
}

-(void) dismissMesssageWithAnimation:(BOOL) animated withCompletion:(void(^)(void))completionBlock {
    
    if (self.alertView) {
        
        [self.currentTimer invalidate];
        
        UIViewController *topViewController = [self topViewController];
        
        if (topViewController.view == self.alertView.superview) {
            [topViewController.view removeConstraint:self.topConstraint];
            self.topConstraint = [NSLayoutConstraint constraintWithItem:topViewController.topLayoutGuide
                                                              attribute:NSLayoutAttributeTop
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:self.alertView
                                                              attribute:NSLayoutAttributeBottom
                                                             multiplier:1.0
                                                               constant:0.0];
            
            [topViewController.view addConstraint:self.topConstraint];
        } else {
            self.topConstraint.constant = CGRectGetHeight(self.alertView.frame);
        }
        
        __weak typeof(self) weakSelf = self;
        
        [UIView animateWithDuration:(animated ? 1.0 : 0.0) delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            [weakSelf.alertView layoutIfNeeded];
        } completion:^(BOOL finished) {
            [weakSelf.alertView removeFromSuperview];
            weakSelf.alertView = nil;
            weakSelf.currentAlert = nil;
            if (completionBlock) {
                completionBlock();
            }
        }];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:AlertManagerBannerDismissedNotification
                                                            object:nil
                                                          userInfo:@{@"bannerFrame":  [NSValue valueWithCGRect:self.alertView.frame],
                                                                     @"alert": self.currentAlert}];
    }
}

-(UIViewController *) topViewController {
    
    UIViewController *topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([topViewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *splitViewController = (UISplitViewController *)topViewController;
        
        if ([splitViewController.viewControllers count] > 1) {
            if (splitViewController.collapsed) {
                topViewController = splitViewController.viewControllers[0];
            } else {
                topViewController = splitViewController.viewControllers[1];
            }
        } else if ([splitViewController.viewControllers count] == 1) {
            topViewController = splitViewController.viewControllers[0];
        }
    }
    
    while ([topViewController isKindOfClass:[UINavigationController class]]) {
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

-(void) scheduleAlert:(Alert *)newAlert {
    
    if ([newAlert.uniqueId length]) {
        if ([self.alertsDisplayed containsObject:newAlert.uniqueId]) {
            return;
        }
            
        for (Alert *alert in self.alertsQueued) {
            if ([alert.uniqueId length] && [newAlert.uniqueId isEqualToString:alert.uniqueId]) {
                return;
            }
        }
    }
    
    [self.alertsQueued addObject:newAlert];
    
    if (!self.currentAlert) {
        [self showNextQueuedAlert];
    }
}

-(void) cancelAlert:(Alert *)alert {
    
    if ([alert.message isEqualToString:self.currentAlert.message]) {
        [self dismissMesssage];
    }
    
    [self.alertsQueued enumerateObjectsUsingBlock:^(Alert *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.uniqueId isEqualToString:alert.uniqueId]) {
            [self.alertsQueued removeObject:obj];
        }
    }];
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

-(void)viewControllerIsDissapearing {
    if (self.currentAlert) {
        [self dismissMesssage];
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