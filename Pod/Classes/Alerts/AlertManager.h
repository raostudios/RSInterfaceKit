//
//  AlertManger.h
//  TheBigClock
//
//  Created by Rao, Venkat on 3/4/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Alert;

extern NSString * const AlertManagerBannerDisplayedNotification;
extern NSString * const AlertManagerBannerDismissedNotification;
extern NSString * const AlertManagerBannerWillDisplayNotification;
extern NSString * const AlertManagerBannerWillDismissNotification;


@interface AlertManager : NSObject

+(instancetype) sharedManager;

-(void) scheduleAlert:(Alert *)alert;
-(void) showNextQueuedAlert;
-(void) viewControllerIsDissapearing;
-(void) cancelAlert:(Alert *)alert;


@end