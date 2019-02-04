//
//  AlertManger.h
//  TheBigClock
//
//  Created by Rao, Venkat on 3/4/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RSAlert;

extern NSString * _Nonnull const AlertManagerBannerDisplayedNotification;
extern NSString * _Nonnull const AlertManagerBannerDismissedNotification;
extern NSString * _Nonnull const AlertManagerBannerWillDisplayNotification;
extern NSString * _Nonnull const AlertManagerBannerWillDismissNotification;


@interface RSAlertManager : NSObject

+(instancetype _Nonnull) sharedManager;

-(void) scheduleAlert:(RSAlert * _Nonnull)alert;
-(void) showNextQueuedAlert;
-(void) viewControllerIsDissapearing;
-(void) cancelAlert:(RSAlert * _Nonnull)alert;

@end
