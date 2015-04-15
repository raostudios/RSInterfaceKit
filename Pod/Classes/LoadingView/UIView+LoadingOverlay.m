//
//  UIView+LoadingOverlay.m
//  TheBigClock
//
//  Created by Rao, Venkat on 2/8/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "UIView+LoadingOverlay.h"
#import "LoadingView.h"
#import "UIView+AutoLayout.h"

@implementation UIView (LoadingOverlay)

-(void) showLoadingOverlayWithText:(NSString *)text {
    LoadingView *loadingView = [[LoadingView alloc] initWithAutoLayout];
    loadingView.labelTitle.text = text;
    [loadingView.indicatorLoading startAnimating];
    
    [self addSubview:loadingView];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[loadingView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"loadingView":loadingView}]];
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[loadingView]|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:@{@"loadingView":loadingView}]];
    
}

-(void) hideLoadingOverlay {
    NSArray *subviews = self.subviews;
    for (int i = 0; i < [self.subviews count]; i++) {
        if ([subviews[i] isKindOfClass:[LoadingView class]]) {
            [subviews[i] removeFromSuperview];
        }
    }
}

@end
