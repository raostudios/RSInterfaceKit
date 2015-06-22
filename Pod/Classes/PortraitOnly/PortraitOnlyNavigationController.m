//
//  PortraitOnlyNavigationController.m
//  TheBigClock
//
//  Created by Rao, Venkat on 2/11/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "PortraitOnlyNavigationController.h"

@implementation PortraitOnlyNavigationController

-(BOOL)shouldAutorotate {
    return NO;
}

-(NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

@end
