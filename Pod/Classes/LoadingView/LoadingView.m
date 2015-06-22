//
//  LoadingView.m
//  TheBigClock
//
//  Created by Rao, Venkat on 2/8/15.
//  Copyright (c) 2015 Venkat Rao. All rights reserved.
//

#import "LoadingView.h"
#import "UIView+AutoLayout.h"

@interface LoadingView ()


@end

@implementation LoadingView

-(instancetype)initWithAutoLayout {
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.backgroundColor = [UIColor blackColor];
        
        UIView *contentView = [[UIView alloc] initWithAutoLayout];
        
        [contentView addSubview:self.labelTitle];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.labelTitle
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
        [contentView addSubview:self.indicatorLoading];

        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:contentView
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self.indicatorLoading
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];
        
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[indicatorLoading]-[labelTitle]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:@{@"labelTitle":self.labelTitle,
                                                                               @"indicatorLoading":self.indicatorLoading}]];
        
        [contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[labelTitle]-|"
                                                                            options:0
                                                                            metrics:nil
                                                                              views:@{@"labelTitle":self.labelTitle,
                                                                                      @"indicatorLoading":self.indicatorLoading}]];
        
        [self addSubview:contentView];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                                attribute:NSLayoutAttributeCenterX
                                                                relatedBy:NSLayoutRelationEqual
                                                                   toItem:contentView
                                                                attribute:NSLayoutAttributeCenterX
                                                               multiplier:1
                                                                 constant:0]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:self
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:contentView
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1
                                                          constant:0]];
        
    }
    return self;
}

-(void)layoutSubviews {
    [super layoutSubviews];
    self.labelTitle.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - 16;
}

-(UILabel *)labelTitle {
    if (!_labelTitle) {
        _labelTitle = [[UILabel alloc] initWithAutoLayout];
        _labelTitle.textColor = [UIColor whiteColor];
        _labelTitle.textAlignment = NSTextAlignmentCenter;
        _labelTitle.numberOfLines = 0;
    }
    return _labelTitle;
}

-(UIActivityIndicatorView *)indicatorLoading {
    if (!_indicatorLoading) {
        _indicatorLoading = [[UIActivityIndicatorView alloc] initWithAutoLayout];
    }
    return _indicatorLoading;
}

@end
