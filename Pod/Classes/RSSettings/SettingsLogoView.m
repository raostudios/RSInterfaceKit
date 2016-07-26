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

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        self.logoButton = [UIImageView new];
        [self.logoButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.logoButton.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView  addSubview:self.logoButton];

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[logoButton]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"logoButton": self.logoButton}]];
        
        [self.contentView  addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[logoButton]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"logoButton": self.logoButton}]];
        
        [self.contentView  addConstraint:[NSLayoutConstraint constraintWithItem:self.logoButton
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.logoButton
                                                         attribute:NSLayoutAttributeHeight
                                                        multiplier:1
                                                          constant:0]];
    }
    return self;
}

@end
