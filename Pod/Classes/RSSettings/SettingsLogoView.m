//
//  LogoView.m
//  TheBigClock
//
//  Created by Rao, Venkat on 2/28/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "SettingsLogoView.h"
#import <RSInterfaceKit/UIView+AutoLayout.h>

@implementation SettingsLogoView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.logoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.logoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.logoButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.logoButton];
        
        self.labelBuildNumber = [[UILabel alloc] initWithAutoLayout];
        self.labelBuildNumber.textAlignment = NSTextAlignmentCenter;

        [self addSubview:self.labelBuildNumber];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[labelBuildNumber]-[logoButton]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"logoButton": self.logoButton,
                                                                               @"labelBuildNumber":self.labelBuildNumber}]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.logoButton
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.labelBuildNumber
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
    }
    return self;
}

@end
