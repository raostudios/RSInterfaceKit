//
//  UIView+LoadingOverlay.h
//  TheBigClock
//
//  Created by Rao, Venkat on 2/8/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LoadingOverlay)

-(void) showLoadingOverlayWithText:(NSString *)text;
-(void) hideLoadingOverlay;

@end
