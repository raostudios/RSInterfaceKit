//
//  AlertManger.m
//  TheBigClock
//
//  Created by Rao, Venkat on 3/4/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "AlertManager.h"

@implementation AlertManager

+(instancetype)sharedManager {
    static AlertManager *alertManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        alertManager = [AlertManager new];
    });
    return alertManager;
}

-(void) showAlert:(NSString *)message withAnimation:(BOOL)animations forced:(BOOL) forced {
    
}

@end
