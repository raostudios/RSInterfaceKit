//
//  AlertManger.h
//  TheBigClock
//
//  Created by Rao, Venkat on 3/4/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Alert;

extern const NSString * AlertManagerBannerDisplayedNotification;
extern const NSString * AlertManagerBannerDisplayedDismissed;

@interface AlertManager : NSObject

+(instancetype) sharedManager;

-(void) scheduleAlert:(Alert *)alert;
-(void) showNextQueuedAlert;
-(void) viewControllerIsDissapearing;


@end